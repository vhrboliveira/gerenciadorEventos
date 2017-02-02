package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.LocalEd;

public class LocalEdDAO extends DAO<LocalEd> {
    //id,nome,logradouro,complemento,bairro,cep,cidade,estado,tel_tipo,tel_ddd,tel_num,latitude,longitude
    static String allQuery = "SELECT * FROM local_ed";
     
    static String createQuery = "INSERT INTO local_ed(nome, logradouro, complemento, bairro, "+
            " cep, cidade, estado, tel_tipo, tel_ddd, tel_num, latitude, longitude) " 
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id";
    
    static String deleteQuery = "DELETE FROM local_ed WHERE id=?";
    
    static String readQuery = "SELECT * FROM local_ed WHERE id=?";
    //id,nome,logradouro,complemento,bairro,cep,cidade,estado,tel_tipo,tel_ddd,tel_num,latitude,longitude
    static String updateQuery = "UPDATE local_ed SET nome=?, logradouro=?, complemento=?, bairro=?, "+
            "cep=?, cidade=?, estado=?, tel_tipo=?, tel_ddd=?, tel_num=?, latitude=?, longitude=? WHERE id=?";
   
    public LocalEdDAO(Connection connection) {
        super(connection);
    }

    @Override
    public void create(LocalEd localEd) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(createQuery);) {
  
//id,nome,logradouro,complemento,bairro,cep,cidade,estado,tel_tipo,tel_ddd,tel_num,latitude,longitude
    
            statement.setString(1, localEd.getNome());
            statement.setString(2, localEd.getLogradouro());
            statement.setString(3, localEd.getComplemento());
            statement.setString(4, localEd.getBairro());
            statement.setString(5, localEd.getCep());
            statement.setString(6, localEd.getCidade());
            statement.setString(7, localEd.getEstado());
            statement.setString(8, localEd.getTel_tipo());
            statement.setString(9, localEd.getTel_ddd());
            statement.setString(10,localEd.getTel_num());
            statement.setString(11,localEd.getLatitude() );
            statement.setString(12,localEd.getLongitude());
           
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                localEd.setId(result.getLong("id"));
            }

            result.close();

        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().contains("local_ed_nome_key")) {
                throw new SQLException("Erro ao inserir local: nome já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao inserir local: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao inserir local.");
            }
        }
    }

    @Override
    public LocalEd read(Long id) throws SQLException {
        LocalEd localEd = new LocalEd();
        
        try (PreparedStatement statement = connection.prepareStatement(readQuery);) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    //id,nome,logradouro,complemento,bairro,cep,cidade,estado,tel_tipo,tel_ddd,tel_num,latitude,longitude
                    localEd.setId(id);
                    localEd.setNome(result.getString("nome"));
                    localEd.setLogradouro(result.getString("logradouro"));
                    localEd.setComplemento(result.getString("complemento"));
                    localEd.setBairro(result.getString("bairro"));
                    localEd.setCep(result.getString("cep"));
                    localEd.setCidade(result.getString("cidade"));
                    localEd.setEstado(result.getString("estado"));
                    localEd.setTel_tipo(result.getString("tel_tipo"));
                    localEd.setTel_ddd(result.getString("tel_ddd"));
                    localEd.setTel_num(result.getString("tel_num"));
                    localEd.setLatitude(result.getString("latitude"));
                    localEd.setLongitude(result.getString("longitude"));
               
                    
                } else {
                    throw new SQLException("Erro ao visualizar: local não encontrado.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: local não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar local.");
            }
        }
        
        return localEd;
    }

    @Override
    public void update(LocalEd localEd) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(updateQuery);) {
 //id,nome,logradouro,complemento,bairro,cep,cidade,estado,tel_tipo,tel_ddd,tel_num,latitude,longitude            
            statement.setString(1, localEd.getNome());
            statement.setString(2, localEd.getLogradouro());
            statement.setString(3, localEd.getComplemento());
            statement.setString(4, localEd.getBairro());
            statement.setString(5, localEd.getCep());
            statement.setString(6, localEd.getCidade());
            statement.setString(7, localEd.getEstado());
            statement.setString(8,localEd.getTel_tipo());
            statement.setString(9,localEd.getTel_ddd());
            statement.setString(10,localEd.getTel_num());
            statement.setString(11,localEd.getLatitude());
            statement.setString(12,localEd.getLongitude());
            statement.setLong(13, localEd.getId());
            
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: local não encontrada.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao editar: local não encontrada.")) {
                throw ex;
            } else if (ex.getMessage().contains("local_ed_nome_key")) {
                throw new SQLException("Erro ao editar local: nome já existente.");
            } else {
                throw new SQLException("Erro ao editar local.");
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
    public List<LocalEd> all() throws SQLException {
        List<LocalEd> localEdList = new ArrayList<>();
        
        try (PreparedStatement statement = connection.prepareStatement(allQuery);
                ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                LocalEd localEd = new LocalEd();
                localEd.setId(result.getLong("id"));
                localEd.setLogradouro(result.getString("logradouro"));
                localEd.setBairro(result.getString("bairro"));
                localEd.setCep(result.getString("cep"));
                localEd.setCidade(result.getString("cidade"));
                localEd.setComplemento(result.getString("complemento"));
                localEd.setEstado(result.getString("estado"));
                localEd.setLatitude(result.getString("latitude"));
                localEd.setLongitude(result.getString("longitude"));
                localEd.setNome(result.getString("nome"));
                localEd.setTel_ddd(result.getString("tel_ddd"));
                localEd.setTel_num(result.getString("tel_num"));
                localEd.setTel_tipo(result.getString("tel_tipo"));
                
                localEdList.add(localEd);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao listar local.");
        }
       
        return localEdList;
    }
    
}
