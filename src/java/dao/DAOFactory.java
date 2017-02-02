package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import jdbc.ConnectionFactory;

public class DAOFactory implements AutoCloseable {

    private Connection connection = null;

    public DAOFactory() throws ClassNotFoundException, IOException, SQLException {
        connection = ConnectionFactory.getInstance().getConnection();
    }

    public void beginTransaction() throws SQLException {
        try {
            connection.setAutoCommit(false);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao abrir transação.");
        }
    }


   public void commitTransaction() throws SQLException {
        try {
            connection.commit();
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao finalizar transação.");
        }
    }

    public void rollbackTransaction() throws SQLException {
        try {
            connection.rollback();
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao executar transação.");
        }
    }

    public void endTransaction() throws SQLException {
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao finalizar transação.");
        }
    }

    public void closeConnection() throws SQLException {
        try {
            connection.close();
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao fechar conexão ao banco de dados.");
        }
    }

    // Factory para Usuario    
    public UsuarioDAO getUsuarioDAO() {
        return new UsuarioDAO(connection);
    }
    
    // Factory para Evento
    public EventoDAO getEventoDAO(){
        return new EventoDAO(connection);
    }
    
    // Factory para Entidade Promotora
    public EntPromotoraDAO getEntPromotoraDAO(){
        return new EntPromotoraDAO(connection);
    }

    // Factory para local da edição
    public LocalEdDAO getLocalEdDAO(){
        return new LocalEdDAO(connection);
    }
    
    // Factory para edicoes
    public EdicoesDAO getEdicoesDAO(){
        return new EdicoesDAO(connection);
    }
    
    // Factory para formas de pagamento
    public FormasPagamentoDAO getFormasPagamentoDAO(){
        return new FormasPagamentoDAO(connection);
    }
    
    // Factory para inscrição
    public InscricaoDAO getInscricaoDAO(){
        return new InscricaoDAO(connection);
    }
    
    @Override
    public void close() throws SQLException {
        closeConnection();
    }
}