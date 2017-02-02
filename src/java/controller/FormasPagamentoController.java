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
import model.FormasPagamento;
import model.EntPromotora;

@WebServlet(
        name = "FormasPagamentoController",
        urlPatterns = {
            "/formas_pagamento",
            "/formas_pagamento/create",
            "/formas_pagamento/update",
            "/formas_pagamento/delete"})
public class FormasPagamentoController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher;

        switch (request.getServletPath()) {
            case "/formas_pagamento":
                listFormasPagamento(request, response);
                break;
            
            case "/formas_pagamento/create":
                dispatcher = request.getRequestDispatcher("/view/formaspagamento/create.jsp");
                dispatcher.forward(request, response);
                break;
                
            case "/formas_pagamento/delete":
                deleteFormasPagamento(request, response);
                break;
                
            case "/formas_pagamento/update":
                updateFormasPagamento(request, response);
                break;    
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        switch (request.getServletPath()) {            
            case "/formas_pagamento/create":
                createFormasPagamento(request, response);
                break;
                
            case "/formas_pagamento/update":
                updateFormasPagamentoPost(request, response);
                break;
        }

    }
       
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private void createFormasPagamento(HttpServletRequest request, HttpServletResponse response) throws IOException {
        FormasPagamento formasPagamento = new FormasPagamento();
        
        formasPagamento.setFormas_pagamento(request.getParameter("formas_pagamento"));
        
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getFormasPagamentoDAO();
            
            dao.create(formasPagamento);

            response.sendRedirect(request.getContextPath() + "/formas_pagamento");
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            HttpSession session = request.getSession();
            session.setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/formas_pagamento/create");
        }

    }
    
    private void deleteFormasPagamento(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getFormasPagamentoDAO();

            dao.delete(Long.parseLong(request.getParameter("id")));
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/formas_pagamento");

    }
    
    private void updateFormasPagamento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getFormasPagamentoDAO();

            FormasPagamento formasPagamento = (FormasPagamento) dao.read(Long.parseLong(request.getParameter("id")));
            
            request.setAttribute("formas", formasPagamento);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/formaspagamento/update.jsp");
            dispatcher.forward(request, response);
            
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/formas_pagamento");
        }
    }
    
    private void updateFormasPagamentoPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        FormasPagamento formasPagamento = new FormasPagamento();
        formasPagamento.setId(Long.parseLong(request.getParameter("id")));
        formasPagamento.setFormas_pagamento(request.getParameter("formas_pagamento"));

        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getFormasPagamentoDAO();

            dao.update(formasPagamento);

            response.sendRedirect(request.getContextPath() + "/formas_pagamento");
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            HttpSession session = request.getSession();
            session.setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/formas_pagamento/update");
        }
    }
    
    
    private void listFormasPagamento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getFormasPagamentoDAO();
            
            List<FormasPagamento> formasPagamentoList = dao.all();
            request.setAttribute("formasPagamentoList", formasPagamentoList);
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }
       
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/formaspagamento/index.jsp");
        dispatcher.forward(request, response);
    }
}