package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Inscricao;

public class InscricaoDAO extends DAO<Inscricao> {
    //(id,idUsuario,idEdicao, valor_inscricao, conhecimento_evento, acompanhante)    
    static String allQuery = "SELECT * FROM inscricao";
     
    static String createQuery = "INSERT INTO inscricao(idUsuario, idEdicao, valor_inscricao, "
            + "conhecimento_evento, acompanhante)  VALUES (?, ?, ?, ?, ?) RETURNING id";
    
    static String deleteQuery = "DELETE FROM inscricao WHERE id=?";
    
    static String readQuery = "SELECT * FROM inscricao WHERE id=?";
    
    static String readFormas_pagamentoQuery = "SELECT f.formas_pagamento AS formas_pagamento FROM edicoes AS ed "
        +"INNER JOIN formas_pagamento AS f ON(ed.idformas_pagamento = f.id) " 
        +"INNER JOIN inscricao AS i ON(ed.id = i.idedicao) WHERE i.id = ?";
    
    static String updateQuery = "UPDATE inscricao SET status_pagamento=1, valor_pago=? WHERE id=?";
    
    static String updateConfirmInscQuery = "UPDATE inscricao SET status_inscricao=1 WHERE id=?";
    
    static String checkStatusEventEd = "SELECT evento.status FROM evento, edicoes WHERE evento.id = edicoes.idevento AND edicoes.id = ?";
   
    public InscricaoDAO(Connection connection) {
        super(connection);
    }

    @Override
    public void create(Inscricao inscricao) throws SQLException {
        
        try (PreparedStatement statement = connection.prepareStatement(createQuery);) {
    
            statement.setLong(1, inscricao.getIdUsuario());
            statement.setLong(2, inscricao.getIdEdicao());
            statement.setFloat(3,inscricao.getValor_inscricao());
            statement.setString(4, inscricao.getConhecimento_evento());
            statement.setString(5, inscricao.getAcompanhante());
            
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                inscricao.setId(result.getLong("id"));
            }
            result.close();

        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao inserir inscrição: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao inserir inscrição.");
            }
        }
    }

    @Override
    public Inscricao read(Long id) throws SQLException {
        Inscricao inscricao = new Inscricao();
        // Pegando dados referente a inscricao
        try (PreparedStatement statement = connection.prepareStatement(readQuery);) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                //(id,idUsuario,idEdicao, valor_inscricao
                    inscricao.setId(id);
                    inscricao.setIdUsuario(result.getLong("idUsuario"));
                    inscricao.setIdEdicao(result.getLong("idEdicao"));
                    inscricao.setValor_inscricao(result.getFloat("valor_inscricao"));
                                        
                } else {
                    throw new SQLException("Erro ao visualizar: inscrição não encontrado.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: inscrição não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar inscrição.");
            }
        }
        
        // Pegando forma de pagamento com Inner join
        try (PreparedStatement statement = connection.prepareStatement(readFormas_pagamentoQuery);) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                //(formas_pagamento
                    inscricao.setId(id);
                    inscricao.setFormas_pagamento(result.getString("formas_pagamento"));
                } else {
                    throw new SQLException("Erro ao visualizar: inscrição não encontrado.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: inscrição não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar inscrição.");
            }
        }
        
        return inscricao;
    }

    @Override
    public void update(Inscricao inscricao) throws SQLException {
        String query = null;
        
        if(inscricao.getStatus_inscricao()== 1){
            query = updateConfirmInscQuery;
        }else{
            query = updateQuery;
        }
        
        try (PreparedStatement statement = connection.prepareStatement(query);) {
            if(inscricao.getStatus_inscricao() == 1){
                statement.setLong(1, inscricao.getId());
            }else{
                statement.setFloat(1, inscricao.getValor_pago());
                statement.setLong(2, inscricao.getId());
            }
            
            
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: inscrição não encontrada.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao editar: inscrição não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao editar inscrição.");
            }
        }
    }

    @Override
    public void delete(Long id) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(deleteQuery);) {
            statement.setLong(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: inscrição não encontrada.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao excluir: inscrição não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir inscrição.");
            }
        }
    }

    @Override
    public List<Inscricao> all() throws SQLException {
        List<Inscricao> inscricaoList = new ArrayList<>();
        
        try (PreparedStatement statement = connection.prepareStatement(allQuery);
                ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                Inscricao inscricao = new Inscricao();
                
                inscricao.setId(result.getLong("id"));
                inscricao.setIdUsuario(result.getLong("idUsuario"));
                inscricao.setIdEdicao(result.getLong("idEdicao"));
                inscricao.setValor_inscricao(result.getFloat("valor_inscricao"));
                inscricao.setValor_pago(result.getFloat("valor_pago"));
                String[] data2 = result.getString("data_inscricao").split("-");
                inscricao.setData_inscricao(data2[2]+"/"+ data2[1]+"/"+data2[0]);
                inscricao.setStatus_inscricao(result.getLong("status_inscricao"));
                inscricao.setStatus_pagamento(result.getLong("status_pagamento"));
                inscricaoList.add(inscricao);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao listar inscrição.");
        }
       
        return inscricaoList;
    }
    
    public Long eventoRedirect(Long id) throws SQLException{
        long status = 0;
       
        try (PreparedStatement statement = connection.prepareStatement(checkStatusEventEd);) {
            statement.setLong(1, id);
            
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    status = result.getLong("status");
                } else {
                    throw new SQLException("Erro ao visualizar: evento/edicao não encontrado.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao editar: evento/edicao não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao editar evento/edicao.");
            }
        }
        
        return status;
    }
}
