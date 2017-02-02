package controller;

import dao.DAO;
import dao.DAOFactory;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.EntPromotora;

@WebServlet(
        name = "EntPromotoraController",
        urlPatterns = {
            "/entidade_promotora",
            "/entidade_promotora/create",
            "/entidade_promotora/update",
            "/entidade_promotora/delete"})
public class EntPromotoraController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher;

        switch (request.getServletPath()) {
            case "/entidade_promotora":
                listEntPromotora(request, response);
                break;
            
            case "/entidade_promotora/create":
                dispatcher = request.getRequestDispatcher("/view/entpromotora/createEntidadePromo.jsp");
                dispatcher.forward(request, response);
                break;
                
            case "/entidade_promotora/delete":
                deleteEntPromotora(request, response);
                break;
                
            case "/entidade_promotora/update":
                updateEntPromotora(request, response);
                break;    
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        switch (request.getServletPath()) {            
            case "/entidade_promotora/create":
                createEntidadePromotora(request, response);
                break;
                
            case "/entidade_promotora/update":
                updateEntPromotoraPost(request, response);
                break;
        }

    }
       
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private void createEntidadePromotora(HttpServletRequest request, HttpServletResponse response) throws IOException {
        EntPromotora entPromotora = new EntPromotora();
        
        entPromotora.setNome(request.getParameter("nome"));
        entPromotora.setDescricao(request.getParameter("descricao"));
        
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEntPromotoraDAO();
            
            dao.create(entPromotora);

            response.sendRedirect(request.getContextPath() + "/entidade_promotora");
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            HttpSession session = request.getSession();
            session.setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/entidade_promotora/create");
        }

    }
    
    private void deleteEntPromotora(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEntPromotoraDAO();

            dao.delete(Long.parseLong(request.getParameter("id")));
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/entidade_promotora");

    }
    
    private void updateEntPromotora(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEntPromotoraDAO();

            EntPromotora entPromotora = (EntPromotora) dao.read(Long.parseLong(request.getParameter("id")));
            
            request.setAttribute("ent", entPromotora);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/entpromotora/update.jsp");
            dispatcher.forward(request, response);
            
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/entidade_promotora");
        }
    }
    
    private void updateEntPromotoraPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        EntPromotora entPromotora = new EntPromotora();
        entPromotora.setId(Long.parseLong(request.getParameter("id")));
        entPromotora.setNome(request.getParameter("nome"));
        entPromotora.setDescricao(request.getParameter("descricao"));

        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEntPromotoraDAO();

            dao.update(entPromotora);

            response.sendRedirect(request.getContextPath() + "/entidade_promotora");
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            HttpSession session = request.getSession();
            session.setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/entidade_promotora/update");
        }
    }
    
    
    private void listEntPromotora(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEntPromotoraDAO();

            List<EntPromotora> entPromotoraList = dao.all();
            request.setAttribute("entPromotoraList", entPromotoraList);
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/entpromotora/index.jsp");
        dispatcher.forward(request, response);

    }
}