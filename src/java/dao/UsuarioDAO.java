package dao;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Usuario;


public class UsuarioDAO extends DAO<Usuario> {

    static String allQuery = "SELECT uid, tipoUser ,login, nome FROM usuario";

    static String createQuery = "INSERT INTO usuario"
            +"(login, senha, nome, cpf, rg_num, rg_org, nome_cracha, email, cep, estado, cidade, bairro, "
            +" logradouro, complemento, tel_tipo, tel_ddd, tel_num, data_nasc, estado_civil, "
            +" escolaridade, profissao, instituicao_origem, sexo, foto, idFace) " 
            + "VALUES (?, md5(?), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, TO_DATE(?, 'DD-MM-YYYY'), ?, ?, ?, ?, ?, ?, ?) RETURNING uid";

    static String deleteQuery = "DELETE FROM usuario WHERE uid=?";

    static String readQuery = "SELECT * FROM usuario WHERE uid=?";
    
    static String readEmailQuery = "SELECT * FROM usuario WHERE email=?";
    
    static String fotoQuery = "SELECT foto, nome FROM usuario WHERE uid=?";
    
    static String updateQuery = "UPDATE usuario SET login=?, nome=?, cpf=?, rg_num=?, rg_org=?, nome_cracha=?, email=?, "
            + "cep=?, estado=?, cidade=?, bairro=?, logradouro=?, complemento=?, tel_tipo=?, tel_ddd=?, tel_num=?, data_nasc=TO_DATE(?, 'DD-MM-YYYY'), "
            + "estado_civil=?, escolaridade=?, profissao=?, instituicao_origem=?, tipoUser=?, sexo=? WHERE uid=?";
    
    static String updateQueryFoto = "UPDATE usuario SET login=?, nome=?, cpf=?, rg_num=?, rg_org=?, nome_cracha=?, email=?, "
            + "cep=?, estado=?, cidade=?, bairro=?, logradouro=?, complemento=?, tel_tipo=?, tel_ddd=?, tel_num=?, data_nasc=TO_DATE(?, 'DD-MM-YYYY'), "
            + "estado_civil=?, escolaridade=?, profissao=?, instituicao_origem=?, tipoUser=?, sexo=?, foto=? WHERE uid=?";

    static String updateWithPasswordQuery = "UPDATE usuario "
            + "SET login=?, nome=?, senha=md5(?), cpf=?, rg_num=?, rg_org=?, nome_cracha=?, email=?, "
            + "cep=?, estado=?, cidade=?, bairro=?, logradouro=?, complemento=?, tel_tipo=?, tel_ddd=?, tel_num=?, data_nasc=TO_DATE(?, 'DD-MM-YYYY'), "
            + "estado_civil=?, escolaridade=?, profissao=?, instituicao_origem=?, tipoUser=?, sexo=? WHERE uid=?";

    static String updateWithPasswordQueryFoto = "UPDATE usuario "
            + "SET login=?, nome=?, senha=md5(?), cpf=?, rg_num=?, rg_org=?, nome_cracha=?, email=?, "
            + "cep=?, estado=?, cidade=?, bairro=?, logradouro=?, complemento=?, tel_tipo=?, tel_ddd=?, tel_num=?, data_nasc=TO_DATE(?, 'DD-MM-YYYY'), "
            + "estado_civil=?, escolaridade=?, profissao=?, instituicao_origem=?, tipoUser=?, sexo=?, foto=? WHERE uid=?";        
    
    static String authenticateQuery = "SELECT uid, nome, tipoUser FROM usuario WHERE login=? AND senha=md5(?)";

    public UsuarioDAO(Connection connection) {
        super(connection);
    }

    @Override
    public void create(Usuario usuario) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(createQuery);) {          
            statement.setString(1, usuario.getLogin());
            statement.setString(2, usuario.getSenha());
            statement.setString(3, usuario.getNome());
            statement.setString(4, usuario.getCpf());
            statement.setString(5, usuario.getRg_num());
            statement.setString(6, usuario.getRg_org());
            statement.setString(7, usuario.getNome_cracha());
            statement.setString(8, usuario.getEmail());
            statement.setString(9, usuario.getCep());
            statement.setString(10, usuario.getEstado());
            statement.setString(11, usuario.getCidade());
            statement.setString(12, usuario.getBairro());
            statement.setString(13, usuario.getLogradouro());
            statement.setString(14, usuario.getComplemento());
            statement.setString(15, usuario.getTel_tipo());
            statement.setString(16, usuario.getTel_ddd());
            statement.setString(17, usuario.getTel_num());
            statement.setString(18, usuario.getData_nasc());
            statement.setString(19, usuario.getEstado_civil());
            statement.setString(20, usuario.getEscolaridade());
            statement.setString(21, usuario.getProfissao());
            statement.setString(22, usuario.getInstituicao_origem());
            statement.setString(23, usuario.getSexo());
            statement.setBytes(24, usuario.getFoto());
            statement.setString(25, usuario.getIdFace());

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                usuario.setUid(result.getLong("uid"));
            }

            result.close();

        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().contains("uk_usuario_login")) {
                throw new SQLException("Erro ao inserir usuário: login já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao inserir usuário: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao inserir usuário.");
            }
        } 
    }

    @Override
    public Usuario read(Long id) throws SQLException {
        Usuario usuario = new Usuario();

        try (PreparedStatement statement = connection.prepareStatement(readQuery);) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    usuario.setUid(id);
                    usuario.setTipoUser(Long.parseLong(result.getString("tipoUser")));
                    usuario.setLogin(result.getString("login"));
                    usuario.setNome(result.getString("nome"));
                    usuario.setCpf(result.getString("cpf"));
                    usuario.setRg_org(result.getString("rg_org"));
                    usuario.setRg_num(result.getString("rg_num"));
                    usuario.setNome_cracha(result.getString("nome_cracha"));
                    usuario.setEmail(result.getString("email"));
                    usuario.setLogradouro(result.getString("logradouro"));
                    usuario.setComplemento(result.getString("complemento"));
                    usuario.setBairro(result.getString("bairro"));
                    usuario.setCep(result.getString("cep"));
                    usuario.setCidade(result.getString("cidade"));
                    usuario.setEstado(result.getString("estado"));
                    usuario.setTel_tipo(result.getString("tel_tipo"));
                    usuario.setTel_ddd(result.getString("tel_ddd"));
                    usuario.setTel_num(result.getString("tel_num"));
                    
                    String[] data2 = result.getString("data_nasc").split("-");
                    usuario.setData_nasc(data2[2]+"/"+ data2[1]+"/"+data2[0]);
                    
                    usuario.setEstado_civil(result.getString("estado_civil"));
                    usuario.setEscolaridade(result.getString("escolaridade"));
                    usuario.setProfissao(result.getString("profissao"));
                    usuario.setInstituicao_origem(result.getString("instituicao_origem"));
                    usuario.setSexo(result.getString("sexo"));
                    
                } else {
                    throw new SQLException("Erro ao visualizar: usuário não encontrado.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: usuário não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar usuário.");
            }
        }

        return usuario;
    }

    @Override
    public void update(Usuario usuario) throws SQLException {
        String query;
        
        if (usuario.getFoto() != null && usuario.getSenha() == null){
            query = updateQueryFoto;
        }else if (usuario.getFoto() != null && usuario.getSenha() != null){
            query = updateWithPasswordQueryFoto;
        }else if (usuario.getSenha() == null) {
            query = updateQuery;
        } else {
            query = updateWithPasswordQuery;
        }

        try (PreparedStatement statement = connection.prepareStatement(query);) {
            statement.setString(1, usuario.getLogin());
            statement.setString(2, usuario.getNome());
            
            if(usuario.getFoto() != null && usuario.getSenha() == null){
                statement.setString(3, usuario.getCpf());
                statement.setString(4, usuario.getRg_num());
                statement.setString(5, usuario.getRg_org());
                statement.setString(6, usuario.getNome_cracha());
                statement.setString(7, usuario.getEmail());
                statement.setString(8, usuario.getCep());
                statement.setString(9, usuario.getEstado());
                statement.setString(10, usuario.getCidade());
                statement.setString(11, usuario.getBairro());
                statement.setString(12, usuario.getLogradouro());
                statement.setString(13, usuario.getComplemento());
                statement.setString(14, usuario.getTel_tipo());
                statement.setString(15, usuario.getTel_ddd());
                statement.setString(16, usuario.getTel_num());
                statement.setString(17, usuario.getData_nasc());
                statement.setString(18, usuario.getEstado_civil());
                statement.setString(19, usuario.getEscolaridade());
                statement.setString(20, usuario.getProfissao());
                statement.setString(21, usuario.getInstituicao_origem());
                statement.setLong(22, usuario.getTipoUser());
                statement.setString(23, usuario.getSexo());
                statement.setBytes(24, usuario.getFoto());
                statement.setLong(25, usuario.getUid());
            }else if (usuario.getFoto() != null && usuario.getSenha() != null){
                statement.setString(3, usuario.getSenha());
                statement.setString(4, usuario.getCpf());
                statement.setString(5, usuario.getRg_num());
                statement.setString(6, usuario.getRg_org());
                statement.setString(7, usuario.getNome_cracha());
                statement.setString(8, usuario.getEmail());
                statement.setString(9, usuario.getCep());
                statement.setString(10, usuario.getEstado());
                statement.setString(11, usuario.getCidade());
                statement.setString(12, usuario.getBairro());
                statement.setString(13, usuario.getLogradouro());
                statement.setString(14, usuario.getComplemento());
                statement.setString(15, usuario.getTel_tipo());
                statement.setString(16, usuario.getTel_ddd());
                statement.setString(17, usuario.getTel_num());
                statement.setString(18, usuario.getData_nasc());
                statement.setString(19, usuario.getEstado_civil());
                statement.setString(20, usuario.getEscolaridade());
                statement.setString(21, usuario.getProfissao());
                statement.setString(22, usuario.getInstituicao_origem());
                statement.setLong(23, usuario.getTipoUser());
                statement.setString(24, usuario.getSexo());
                statement.setBytes(25, usuario.getFoto());
                statement.setLong(26, usuario.getUid());
            } else if (usuario.getSenha() == null) {
                statement.setString(3, usuario.getCpf());
                statement.setString(4, usuario.getRg_num());
                statement.setString(5, usuario.getRg_org());
                statement.setString(6, usuario.getNome_cracha());
                statement.setString(7, usuario.getEmail());
                statement.setString(8, usuario.getCep());
                statement.setString(9, usuario.getEstado());
                statement.setString(10, usuario.getCidade());
                statement.setString(11, usuario.getBairro());
                statement.setString(12, usuario.getLogradouro());
                statement.setString(13, usuario.getComplemento());
                statement.setString(14, usuario.getTel_tipo());
                statement.setString(15, usuario.getTel_ddd());
                statement.setString(16, usuario.getTel_num());
                statement.setString(17, usuario.getData_nasc());
                statement.setString(18, usuario.getEstado_civil());
                statement.setString(19, usuario.getEscolaridade());
                statement.setString(20, usuario.getProfissao());
                statement.setString(21, usuario.getInstituicao_origem());
                statement.setLong(22, usuario.getTipoUser());
                statement.setString(23, usuario.getSexo());
                statement.setLong(24, usuario.getUid());
            } else {
                statement.setString(3, usuario.getSenha());
                statement.setString(4, usuario.getCpf());
                statement.setString(5, usuario.getRg_num());
                statement.setString(6, usuario.getRg_org());
                statement.setString(7, usuario.getNome_cracha());
                statement.setString(8, usuario.getEmail());
                statement.setString(9, usuario.getCep());
                statement.setString(10, usuario.getEstado());
                statement.setString(11, usuario.getCidade());
                statement.setString(12, usuario.getBairro());
                statement.setString(13, usuario.getLogradouro());
                statement.setString(14, usuario.getComplemento());
                statement.setString(15, usuario.getTel_tipo());
                statement.setString(16, usuario.getTel_ddd());
                statement.setString(17, usuario.getTel_num());
                statement.setString(18, usuario.getData_nasc());
                statement.setString(19, usuario.getEstado_civil());
                statement.setString(20, usuario.getEscolaridade());
                statement.setString(21, usuario.getProfissao());
                statement.setString(22, usuario.getInstituicao_origem());
                statement.setLong(23, usuario.getTipoUser());
                statement.setString(24, usuario.getSexo());
                statement.setLong(25, usuario.getUid());
            }

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: usuário não encontrado.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao editar: usuário não encontrado.")) {
                throw ex;
            } else if (ex.getMessage().contains("uk_usuario_login")) {
                throw new SQLException("Erro ao editar usuário: login já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao editar usuário: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao editar usuário.");
            }
        }
    }

    @Override
    public void delete(Long id) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(deleteQuery);) {
            statement.setLong(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: usuário não encontrado.");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao excluir: usuário não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir usuário.");
            }
        }

    }

    @Override
    public List<Usuario> all() throws SQLException {
        List<Usuario> usuarioList = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(allQuery);
                ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                Usuario usuario = new Usuario();
                usuario.setUid(result.getLong("uid"));
                usuario.setTipoUser(result.getLong("tipoUser"));
                usuario.setLogin(result.getString("login"));
                usuario.setNome(result.getString("nome"));
                                      
                usuarioList.add(usuario);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao listar usuários.");
        }

        return usuarioList;

    }

    public void authenticate(Usuario usuario) throws SQLException, SecurityException {
        try (PreparedStatement statement = connection.prepareStatement(authenticateQuery);) {
            statement.setString(1, usuario.getLogin());
            statement.setString(2, usuario.getSenha());         

            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    usuario.setUid(result.getLong("uid"));
                    usuario.setNome(result.getString("nome"));
                    usuario.setTipoUser(result.getLong("tipoUser"));
                } else {
                    throw new SecurityException("Login ou senha incorretos.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
            throw new SQLException("Erro ao autenticar usuário.");
        }
    }  
    
    public String foto(Long id, String path) throws SQLException, FileNotFoundException, IOException {
        Usuario usuario = new Usuario();
        String dir;
        File f = null;
        try (PreparedStatement statement = connection.prepareStatement(fotoQuery);) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    usuario.setUid(id);
                    byte[] bytes = result.getBytes("foto");
                    String nome = result.getString("nome");
                    //converte o array de bytes em file
                    f = new File(path+nome+".jpg");
                    FileOutputStream fos = new FileOutputStream(f);
                    fos.write(bytes);
                    fos.close();
                    dir = nome+".jpg";
                    
                } else {
                    throw new SQLException("Erro ao visualizar: foto não encontrado.");
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: foto não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar foto.");
            }
        }

        return dir;
    }
    
    public Usuario readEmail(String email) throws SQLException {
        Usuario usuario = new Usuario();

        try (PreparedStatement statement = connection.prepareStatement(readEmailQuery);) {
            statement.setString(1, email);
            try (ResultSet result = statement.executeQuery();) {
                if (result.next()) {
                    usuario.setUid(Long.parseLong(result.getString("uid")));
                    usuario.setIdFace(result.getString("idFace"));
                    usuario.setTipoUser(Long.parseLong(result.getString("tipoUser")));
                    usuario.setLogin(result.getString("login"));
                    usuario.setNome(result.getString("nome"));
                    usuario.setCpf(result.getString("cpf"));
                    usuario.setRg_org(result.getString("rg_org"));
                    usuario.setRg_num(result.getString("rg_num"));
                    usuario.setNome_cracha(result.getString("nome_cracha"));
                    usuario.setEmail(result.getString("email"));
                    usuario.setLogradouro(result.getString("logradouro"));
                    usuario.setComplemento(result.getString("complemento"));
                    usuario.setBairro(result.getString("bairro"));
                    usuario.setCep(result.getString("cep"));
                    usuario.setCidade(result.getString("cidade"));
                    usuario.setEstado(result.getString("estado"));
                    usuario.setTel_tipo(result.getString("tel_tipo"));
                    usuario.setTel_ddd(result.getString("tel_ddd"));
                    usuario.setTel_num(result.getString("tel_num"));
                    
                    String[] data2 = result.getString("data_nasc").split("-");
                    usuario.setData_nasc(data2[2]+"/"+ data2[1]+"/"+data2[0]);
                    
                    usuario.setEstado_civil(result.getString("estado_civil"));
                    usuario.setEscolaridade(result.getString("escolaridade"));
                    usuario.setProfissao(result.getString("profissao"));
                    usuario.setInstituicao_origem(result.getString("instituicao_origem"));
                    usuario.setSexo(result.getString("sexo"));
                    
                } else {
                    //throw new SQLException("Erro ao visualizar: usuário não encontrado.");
                    return null;
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            if (ex.getMessage().equals("Erro ao visualizar: usuário não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar usuário.");
            }
        }

        return usuario;
    }
}
