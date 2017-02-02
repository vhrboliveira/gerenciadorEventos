package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.EntPromotora;

public class EntPromotoraDAO extends DAO<EntPromotora> {
    // Nome, descricao
    static String allQuery = "SELECT id, nome, descricao FROM entidade_promotora";
     
    static String createQuery = "INSERT INTO entidade_promotora(nome, descricao) " 
            + "VALUES (?, ?) RETURNING id";
    
    static String deleteQuery = "DELETE FROM entidade_promotora WHERE id=?";
    
    static String readQuery = "SELECT * FROM entidade_promotora WHERE id=?";
    
    static String updateQuery = "UPDATE entidade_promotora SET nome=?, descricao=? WHERE id=?";
   
    public EntPromotoraDAO(Connection connection) {
        super(connection);
    }

    @Override
    public void create(EntPromotora entPromotora) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(createQuery);) {
            // Nome, descricao 
            statement.setString(1, entPromotora.getNome());
            statement.setString(2, entPromotora.getDescricao());
           
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                entPromotora.setId(result.getLong("id"));
            }

            result.close();

        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().contains("entidade_promotora_nome_key")) {
                throw new SQLException("Erro ao inserir entidade promotora: nome já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao inserir entidade promotora: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao inserir entidade promotora.");
            }
        }
    }

    @Override
    public EntPromotora read(Long id) throws SQLException {
        EntPromotora entPromotora = new EntPromotora();
        
        try (PreparedStatement statement = connection.prepareStatement(readQuery);) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    entPromotora.setId(id);
                    entPromotora.setNome(result.getString("nome"));
                    entPromotora.setDescricao(result.getString("descricao"));
                } else {
                    throw new SQLException("Erro ao visualizar: entidade promotora não encontrada.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: entidade promotora não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar entidade promotora.");
            }
        }
        
        return entPromotora;
    }

    @Override
    public void update(EntPromotora entPromotora) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(updateQuery);) {
            statement.setString(1, entPromotora.getNome());
            statement.setString(2, entPromotora.getDescricao());
            statement.setLong(3, entPromotora.getId());
            
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: entidade promotora não encontrada.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao editar: entidade promotora não encontrada.")) {
                throw ex;
            } else if (ex.getMessage().contains("entidade_promotora_nome_key")) {
                throw new SQLException("Erro ao editar entidade promotora: nome já existente.");
            } else {
                throw new SQLException("Erro ao editar entidade promotora.");
            }
        }
    }

    @Override
    public void delete(Long id) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(deleteQuery);) {
            statement.setLong(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: entidade promotora não encontrada.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao excluir: entidade promotora não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir entidade promotora.");
            }
        }
    }

    @Override
    public List<EntPromotora> all() throws SQLException {
        List<EntPromotora> entPromotoraList = new ArrayList<>();
        
        try (PreparedStatement statement = connection.prepareStatement(allQuery);
                ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                EntPromotora entPromotora = new EntPromotora();
                entPromotora.setId(result.getLong("id"));
                entPromotora.setNome(result.getString("nome"));
                entPromotora.setDescricao(result.getString("descricao"));
               
                entPromotoraList.add(entPromotora);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao listar entidade promotora.");
        }
       
        return entPromotoraList;
    }
    
}
