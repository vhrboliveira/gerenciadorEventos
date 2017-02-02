package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Evento;

public class EventoDAO extends DAO<Evento> {

    static String allQuery = "SELECT * FROM evento";
    // titulo, descricao, inf_importantes, id_entidadepromotora
    static String createQuery = "INSERT INTO evento(titulo, descricao, id_entidadepromotora, inf_importantes) " 
            + "VALUES (?, ?, ?, ?) RETURNING id";

    static String deleteQuery = "DELETE FROM evento WHERE id=?";

    static String readQuery = "SELECT * FROM evento WHERE id=?";
    
    static String updateQuery = "UPDATE evento SET titulo=?, descricao=?, id_entidadepromotora=?, inf_importantes=? "
            +"WHERE id=?";
    
    static String updateHabInscQuery = "UPDATE evento SET status=1 WHERE id=?";
    static String updateEncInscQuery = "UPDATE evento SET status=0 WHERE id=?";
    
    

    public EventoDAO(Connection connection) {
        super(connection);
    }

    @Override
    public void create(Evento evento) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(createQuery);) {
            // titulo, descricao, id_entidadepromotora, inf_importantes 
            statement.setString(1, evento.getTitulo());
            statement.setString(2, evento.getDescricao());
            statement.setLong(3, evento.getId_entidadepromotora());
            statement.setString(4, evento.getInf_importantes());
            
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                evento.setId(result.getLong("id"));
            }

            result.close();

        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().contains("evento_titulo_key")) {
                throw new SQLException("Erro ao inserir evento: titulo já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao inserir evento: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao inserir evento.");
            }
        }
    }

    @Override
    public Evento read(Long id) throws SQLException {
        Evento evento = new Evento();
        
        try (PreparedStatement statement = connection.prepareStatement(readQuery);) {
            statement.setLong(1, id);
            
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    evento.setDescricao(result.getString("descricao"));
                    evento.setId(id);
                    evento.setId_entidadepromotora(result.getLong("id_entidadepromotora"));
                    evento.setInf_importantes(result.getString("inf_importantes"));
                    evento.setTitulo(result.getString("titulo"));
                    evento.setStatus(result.getLong("status"));
                
                } else {
                    throw new SQLException("Erro ao visualizar: evento não encontrado.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: evento não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar evento.");
            }
        }
        
        return evento;
    }

    @Override
    public void update(Evento evento) throws SQLException {
        String query = null;
        
        if(evento.getStatus() == 0){
            query = updateQuery;
        }else if(evento.getStatus() == 1){
            query = updateHabInscQuery;
        }else if(evento.getStatus() == 2){
            query = updateEncInscQuery;
        }
        
        try (PreparedStatement statement = connection.prepareStatement(query);) {
            if(evento.getStatus() == 0){
                statement.setString(1, evento.getTitulo());
                statement.setString(2, evento.getDescricao());
                statement.setLong(3, evento.getId_entidadepromotora());
                statement.setString(4, evento.getInf_importantes());
                statement.setLong(5, evento.getId());
            }else{
                statement.setLong(1, evento.getId());
            }
            
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: evento não encontrado.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao editar: evento não encontrado.")) {
                throw ex;
            } else if (ex.getMessage().contains("evento_titulo_key")) {
                throw new SQLException("Erro ao editar evento: titulo já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao editar evento: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao editar evento.");
            }
        }
    }

    @Override
    public void delete(Long id) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(deleteQuery);) {
            statement.setLong(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: evento não encontrado.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao excluir: evento não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir evento.");
            }
        }
    }

    @Override
    public List<Evento> all() throws SQLException {
        List<Evento> eventoList = new ArrayList<>();
        
        try (PreparedStatement statement = connection.prepareStatement(allQuery);
                ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                Evento evento = new Evento();
                evento.setId(result.getLong("id"));
                evento.setDescricao(result.getString("descricao"));
                evento.setInf_importantes(result.getString("inf_importantes"));
                evento.setTitulo(result.getString("titulo"));
                evento.setId_entidadepromotora(result.getLong("id_entidadepromotora"));
                evento.setStatus(result.getLong("status"));
                
                eventoList.add(evento);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao listar evento.");
        }
        
        return eventoList;
    }
    
}