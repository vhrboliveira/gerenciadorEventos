package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Edicoes;

public class EdicoesDAO extends DAO<Edicoes> {
    //   (id, nome, idlocal, nomelocal, idevento, preco, idformas_pagamento)
    static String allQuery = "SELECT * FROM edicoes";
    static String rendaQuery = "select SUM(valor_pago) AS renda from inscricao where idedicao = ?";
     
    static String createQuery = "INSERT INTO edicoes(nome, idLocal, nomeLocal, idEvento, preco, idformas_pagamento) " 
            + "VALUES (?, ?, ?, ?, ?, ?) RETURNING id";
    // Periodo (id,idEdicao,tipo,dataInicio,dataTermino,horaInicio,horaTermino)
    static String createPeriodoUQuery = "INSERT INTO periodo(idEdicao, tipo, dataInicio, dataTermino, horaInicio, horaTermino) " 
            + "VALUES (?, ?, TO_DATE(?, 'DD-MM-YYYY'), TO_DATE(?, 'DD-MM-YYYY'), ?, ?) RETURNING id";
    
//// Periodo - (id,idEdicao,tipo,dias,dataInicio,dataTermino,horaInicio,horaTermino)    
    static String createPeriodoPQuery = "INSERT INTO periodo(idEdicao, tipo, dias, dataInicio, dataTermino, horaInicio, horaTermino) " 
            + "VALUES (?, ?, ?, TO_DATE(?, 'DD-MM-YYYY'), TO_DATE(?, 'DD-MM-YYYY'), ?, ?) RETURNING id";
    
    static String deleteQuery = "DELETE FROM edicoes WHERE id=?";
    
    static String readQuery = "SELECT * FROM edicoes WHERE id=?";
    
    static String updateQuery = "UPDATE edicoes SET nome=?, idLocal=?, nomeLocal=?, " 
            + " idEvento=?, preco=?, idformas_pagamento=? WHERE id=?";
   
    static String getIdLocalEdQuery = "SELECT id FROM local_ed WHERE nome = ?";
    
    static String estTotal = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ?";
    static String estSexoMasc = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND sexo = 'masculino' AND inscricao.idedicao = ?";
    static String estSexoFem = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND sexo = 'feminino' AND inscricao.idedicao = ?";
    static String estSexoOutro = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND sexo = 'outro' AND inscricao.idedicao = ?";
    static String estInstituicao_origem = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ? AND instituicao_origem = ?";
    
    static String estFaixa10 = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ? AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 10";
    static String estFaixa1020 = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ? AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) > 10 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 20";
    static String estFaixa2030 = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ? AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) > 20 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 30";
    static String estFaixa30 = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ? AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) > 30";

    static String combFaixa10 = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ? AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 10 AND sexo = ?";
    static String combFaixa1020 = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ? AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) > 10 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 20 AND sexo = ?";
    static String combFaixa2030 = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ? AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) > 20 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 30 AND sexo = ?";
    static String combFaixa30 = "SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = ? AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) > 30 AND sexo = ?";
    
    public EdicoesDAO(Connection connection) {
        super(connection);
    }

    @Override
    public void create(Edicoes edicoes) throws SQLException {
        // Edicoes
        try (PreparedStatement statement = connection.prepareStatement(createQuery);) {
            //   (id, nome, idlocal, nomelocal, idevento, preco, formas_pagamento)
            statement.setString(1, edicoes.getNome());
            statement.setLong(2, edicoes.getIdLocal());
            statement.setString(3, edicoes.getNomeLocal());
            statement.setLong(4, edicoes.getIdEvento());
            statement.setFloat(5, edicoes.getPreco());
            statement.setLong(6, edicoes.getIdFormas_Pagamento());
           
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                edicoes.setId(result.getLong("id"));
            }
            
            result.close();

        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().contains("edicoes_pkey")) {
                throw new SQLException("Erro ao inserir edição: edição já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao inserir edição: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao inserir edição.");
            }
        }
        // Periodo (id,idEdicao,tipo,dataInicio,dataTermino,horaInicio,horaTermino)
        
        String query = "";
        if(edicoes.getTipo() == 0){
            query = createPeriodoUQuery;  
        }else if(edicoes.getTipo() == 2){
            query = createPeriodoPQuery;
        }
        try (PreparedStatement statement = connection.prepareStatement(query);) {
            statement.setLong(1, edicoes.getId());
            statement.setLong(2, edicoes.getTipo());
            if(edicoes.getTipo() == 0){
                statement.setString(3, edicoes.getDataInicio());
                statement.setString(4, edicoes.getDataTermino());
                statement.setString(5, edicoes.getHoraInicio());
                statement.setString(6, edicoes.getHoraTermino());
            }else if(edicoes.getTipo() == 2){
                String resultado = "";
                for (String dias : edicoes.getDias()) {
                    resultado += dias+",";
                }
                resultado = resultado.substring(0, resultado.length()-1);
        
                statement.setString(3, resultado);
                statement.setString(4, edicoes.getDataInicio());
                statement.setString(5, edicoes.getDataTermino());
                statement.setString(6, edicoes.getHoraInicio());
                statement.setString(7, edicoes.getHoraTermino());
            }
           
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                edicoes.setId(result.getLong("id"));
            }
            
            result.close();

        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao inserir periodo: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao inserir periodo.");
            }
        }
        
    }

    @Override
    public Edicoes read(Long id) throws SQLException {
        Edicoes edicoes = new Edicoes();
        
        try (PreparedStatement statement = connection.prepareStatement(readQuery);) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    edicoes.setId(id);
                    edicoes.setNome(result.getString("nome"));
                    edicoes.setIdEvento(Long.parseLong(result.getString("idEvento")));
                    edicoes.setIdLocal(Long.parseLong(result.getString("idLocal")));
                    edicoes.setNomeLocal(result.getString("nomeLocal"));
                    edicoes.setPreco(Float.parseFloat(result.getString("preco")));
                    //String[] data2 = result.getString("dataInicio").split("-");
                    //edicoes.setDataInicio(data2[2]+"/"+ data2[1]+"/"+data2[0]);
                    edicoes.setIdFormas_Pagamento(Long.parseLong(result.getString("idformas_pagamento")));
                    
                    
                } else {
                    throw new SQLException("Erro ao visualizar: edição não encontrada.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: edição não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar edição.");
            }
        }
        // RENDA
        try (PreparedStatement statement = connection.prepareStatement(rendaQuery);) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    edicoes.setId(id);
                    
                    if(result.getString("renda") == null)
                        edicoes.setRenda(0);                    
                    else
                        edicoes.setRenda(Float.parseFloat(result.getString("renda")));                    
                } else {
                    throw new SQLException("Erro ao visualizar: edição não encontrada.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: edição não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar edição.");
            }
        }
        
        return edicoes;
    }

    @Override
    public void update(Edicoes edicoes) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(updateQuery);) {
            statement.setString(1, edicoes.getNome());
            statement.setLong(2, edicoes.getIdLocal());
            statement.setString(3, edicoes.getNomeLocal());
            statement.setLong(4, edicoes.getIdEvento());
            statement.setFloat(5, edicoes.getPreco());
            //statement.setString(6, edicoes.getDataInicio());
            statement.setLong(6, edicoes.getIdFormas_Pagamento());
            statement.setLong(7, edicoes.getId());
            
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: edicão não encontrada.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao editar: edição não encontrada.")) {
                throw ex;
            } else if (ex.getMessage().contains("edicoes_pkey")) {
                throw new SQLException("Erro ao editar edição: nome já existente.");
            } else {
                throw new SQLException("Erro ao editar edição.");
            }
        }
    }

    @Override
    public void delete(Long id) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(deleteQuery);) {
            statement.setLong(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: edição não encontrada.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao excluir: edição não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir edição.");
            }
        }
    }

    @Override
    public List<Edicoes> all() throws SQLException {
        List<Edicoes> edicoesList = new ArrayList<>();
        
        // Edicao completa
        //   (id, nome, idlocal, nomelocal, idevento, preco, formas_pgmnto)
        try (PreparedStatement statement = connection.prepareStatement(allQuery);
                ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                Edicoes edicoes = new Edicoes();
                edicoes.setId(result.getLong("id"));
                edicoes.setNome(result.getString("nome"));
                edicoes.setIdLocal(result.getLong("idLocal"));
                edicoes.setNomeLocal(result.getString("nomeLocal"));
                edicoes.setIdEvento(result.getLong("idEvento"));
                edicoes.setPreco(result.getFloat("preco"));
               /* String[] data2 = result.getString("dataInicio").split("-");
                edicoes.setDataInicio(data2[2]+"/"+ data2[1]+"/"+data2[0]);
                */
                edicoes.setIdFormas_Pagamento(result.getLong("idformas_pagamento"));
                edicoesList.add(edicoes);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao listar edições.");
        }
       
        return edicoesList;
    }
    
    public Long getIdLocalEd(String nome) throws SQLException {
        long idLocalEd = 0;
        
        try (PreparedStatement statement = connection.prepareStatement(getIdLocalEdQuery);) {
            statement.setString(1, nome);
            
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    idLocalEd= Long.parseLong(result.getString("id"));
                } else {
                    throw new SQLException("Erro ao visualizar: idlocal não encontrada.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: idLocalEd não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar idlocal.");
            }
        }
        
        return idLocalEd;
    }
 
    public Long getEstatisticas(Long id, int tipo) throws SQLException {
        long resultado = 0;
        String query = null;
        
        switch (tipo) {
            case 0:
                query = estTotal;
                break;
            case 1:
                query = estSexoMasc;
                break;
            case 2:
                query = estSexoFem;
                break;
            case 3:
                query = estSexoOutro;
                break;
            case 5:
                query = estFaixa10;
                break;
            case 6:
                query = estFaixa1020;
                break;
            case 7:
                query = estFaixa2030;
                break;
            case 8:
                query = estFaixa30;
                break;
            default:
                break;
        }
        
        try (PreparedStatement statement = connection.prepareStatement(query);) {
            statement.setLong(1, id);
            
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    resultado = Long.parseLong(result.getString("count"));
                } else {
                    throw new SQLException("Erro ao visualizar: EstTotal não encontrada.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: EstTotal não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar EstTotal.");
            }
        }
        
        return resultado;
    }
    
    public Long getEstatisticasInst_Origem(Long id, String chave, int tipo) throws SQLException {
        long resultado = 0;
        
        try (PreparedStatement statement = connection.prepareStatement(estInstituicao_origem);) {
            statement.setLong(1, id);
            statement.setString(2, chave);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    resultado = Long.parseLong(result.getString("count"));
                } else {
                    throw new SQLException("Erro ao visualizar: inst_origem não encontrada.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: inst_origem não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar inst_origem.");
            }
        }
        
        return resultado;
    }
    
    public Long getEstatisticasComb(Long id, String sexo, int faixa) throws SQLException {
        long resultado = 0;
        
        String query = null;
        switch(faixa){
            case 1:
                query = combFaixa10;
                break;
            case 2:
                query = combFaixa1020;
                break;
            case 3:
                query = combFaixa2030;
                break;
            case 4:
                query = combFaixa30;
                break;
            default:
                break;
        }
        
        
        try (PreparedStatement statement = connection.prepareStatement(query);) {
            statement.setLong(1, id);
            statement.setString(2, sexo);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    resultado = Long.parseLong(result.getString("count"));
                } else {
                    throw new SQLException("Erro ao visualizar: inst_origem não encontrada.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: inst_origem não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar inst_origem.");
            }
        }
        
        return resultado;
    }
    
}
