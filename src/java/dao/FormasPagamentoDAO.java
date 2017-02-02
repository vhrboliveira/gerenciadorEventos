package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.FormasPagamento;

public class FormasPagamentoDAO extends DAO<FormasPagamento> {
    // id, formas_pagamento
    static String allQuery = "SELECT * FROM formas_pagamento";
     
    static String createQuery = "INSERT INTO formas_pagamento(formas_pagamento) " 
            + "VALUES (?) RETURNING id";
    
    static String deleteQuery = "DELETE FROM formas_pagamento WHERE id=?";
    
    static String readQuery = "SELECT * FROM formas_pagamento WHERE id=?";
    
    static String updateQuery = "UPDATE formas_pagamento SET formas_pagamento=? WHERE id=?";
   
    public FormasPagamentoDAO(Connection connection) {
        super(connection);
    }

    @Override
    public void create(FormasPagamento formasPagamento) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(createQuery);) {
            // id, formas_pagamento 
            statement.setString(1, formasPagamento.getFormas_pagamento());
           
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                formasPagamento.setId(result.getLong("id"));
            }

            result.close();

        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().contains("pk_formas_pagamento")) {
                throw new SQLException("Erro ao inserir forma de pagamento: nome já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao inserir forma de pagamento: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao inserir forma de pagamento.");
            }
        }
    }

    @Override
    public FormasPagamento read(Long id) throws SQLException {
        FormasPagamento formasPagamento = new FormasPagamento();
        
        
        try (PreparedStatement statement = connection.prepareStatement(readQuery);) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    formasPagamento.setId(id);
                    formasPagamento.setFormas_pagamento(result.getString("formas_pagamento"));
                    
                } else {
                    throw new SQLException("Erro ao visualizar: forma de pagamento não encontrada.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: forma de pagamento não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar forma de pagamento.");
            }
        }
        
        return formasPagamento;
    }

    @Override
    public void update(FormasPagamento formasPagamento) throws SQLException {
        
        try (PreparedStatement statement = connection.prepareStatement(updateQuery);) {
            statement.setString(1, formasPagamento.getFormas_pagamento());
            statement.setLong(2, formasPagamento.getId());
            
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: forma de pagamento não encontrada.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao editar: forma de pagamento não encontrada.")) {
                throw ex;
            } else if (ex.getMessage().contains("pk_formas_pagamento")) {
                throw new SQLException("Erro ao editar forma de pagamento: nome já existente.");
            } else {
                throw new SQLException("Erro ao editar forma de pagamento.");
            }
        }
    }

    @Override
    public void delete(Long id) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(deleteQuery);) {
            statement.setLong(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: forma de pagamento não encontrada.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao excluir: forma de pagamento não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir forma de pagamento.");
            }
        }
    }

    @Override
    public List<FormasPagamento> all() throws SQLException {
        List<FormasPagamento> formasPagamentoList = new ArrayList<>();
        
        try (PreparedStatement statement = connection.prepareStatement(allQuery);
                ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                FormasPagamento formasPagamento = new FormasPagamento();
                formasPagamento.setId(result.getLong("id"));
                formasPagamento.setFormas_pagamento(result.getString("formas_pagamento"));
                formasPagamentoList.add(formasPagamento);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao listar forma de pagamento.");
        }
       
        return formasPagamentoList;
    }
    
}
