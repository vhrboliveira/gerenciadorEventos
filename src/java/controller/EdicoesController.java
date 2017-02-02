package controller;

import dao.DAO;
import dao.DAOFactory;
import dao.EdicoesDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.LocalEd;
import model.Evento;
import model.Edicoes;
import model.FormasPagamento;


@WebServlet(
        name = "EdicoesController",
        urlPatterns = {
            "/edicoes",
            "/edicoes/create",
            "/edicoes/delete",
            "/edicoes/update",
            "/edicoes/renda"})
public class EdicoesController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        switch (request.getServletPath()) {
            case "/edicoes":
                listEdicoes(request, response);
                break;
                
            case "/edicoes/create":
                listTudo(request, response);
                break;
                
            case "/edicoes/delete":
                deleteEdicoes(request, response);
                break;
                
            case "/edicoes/update":
                updateEdicoes(request, response);
                break;
            case "/edicoes/renda":
                rendaEdicoes(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        switch (request.getServletPath()) {
            case "/edicoes/create":
                createEdicoes(request, response);
                break;
            case "/edicoes/update":
                updateEdicoesPost(request, response);
                break;
        }

    }
       
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
   
    private void createEdicoes(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Edicoes edicoes = new Edicoes();
        //(id, nome, idlocal, nomelocal, idevento, preco, idformas_pagamento)
        edicoes.setNome(request.getParameter("nome"));
        edicoes.setNomeLocal(request.getParameter("nomeLocal"));
        edicoes.setIdEvento(Long.parseLong(request.getParameter("idEvento")));
        edicoes.setPreco(Float.parseFloat(request.getParameter("preco")));
        //edicoes.setDataInicio(request.getParameter("dataInicio"));
        edicoes.setIdFormas_Pagamento(Long.parseLong(request.getParameter("idformas_pagamento")));
        
        // Periodo (id,idEdicao,tipo,dataInicio,dataTermino,horaInicio,horaTermino)
        // Unico - tipo 0
        System.out.println("tipo- "+request.getParameter("tipo"));
        if(Long.parseLong(request.getParameter("tipo")) == 0){
            edicoes.setTipo(0);
            edicoes.setDataInicio(request.getParameter("dataInicio"));
            edicoes.setDataTermino(request.getParameter("dataInicio"));
            edicoes.setHoraInicio(request.getParameter("horaInicio"));
            edicoes.setHoraTermino(request.getParameter("horaTermino"));
            System.out.println(edicoes.getDataInicio()+"  "+edicoes.getDataTermino()+"  "+
                    edicoes.getHoraInicio()+"  "+edicoes.getHoraTermino()+" fim");
        // Periodico - 2
        //// Periodo - (id,idEdicao,tipo,dias,dataInicio,dataTermino,horaInicio,horaTermino)
        }else if(Long.parseLong(request.getParameter("tipo")) == 2){
            edicoes.setTipo(2);
            edicoes.setDataInicio(request.getParameter("dataInicio"));
            edicoes.setDataTermino(request.getParameter("dataTermino"));
            edicoes.setHoraInicio(request.getParameter("horaInicio"));
            edicoes.setHoraTermino(request.getParameter("horaTermino"));
            edicoes.setDias(request.getParameterValues("dias"));
        }
        
        // Local - Edições
        try (DAOFactory daoFactory = new DAOFactory();) {
            // Local
            EdicoesDAO daoEd = daoFactory.getEdicoesDAO();
            edicoes.setIdLocal(daoEd.getIdLocalEd(edicoes.getNomeLocal()));
            
            // Edicoes
            DAO daoEdicoes = daoFactory.getEdicoesDAO();
            daoEdicoes.create(edicoes);

            response.sendRedirect(request.getContextPath() + "/evento");
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            HttpSession session = request.getSession();
            session.setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/edicoes/create");
        }
    }
    
    private void deleteEdicoes(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEdicoesDAO();

            dao.delete(Long.parseLong(request.getParameter("id")));
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/evento");

    }
    
    private void updateEdicoes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Formas Pagamento - Local
        try (DAOFactory daoFactory = new DAOFactory();) {
            // Formas Pagamento
            DAO daoFormasPagamento = daoFactory.getFormasPagamentoDAO();
            List<FormasPagamento> formasPagamentoList = daoFormasPagamento.all();
            request.setAttribute("formasPagamentoList", formasPagamentoList);
            
            // Local
            DAO daoLocal = daoFactory.getLocalEdDAO();
            List<LocalEd> localEdList = daoLocal.all();
            request.setAttribute("localEdList", localEdList);
            
            // Evento
            DAO daoEvento = daoFactory.getEventoDAO();
            List<Evento> eventoList = daoEvento.all();
            request.setAttribute("eventoList", eventoList);
            
            // Edicoes
            DAO daoEdicoes = daoFactory.getEdicoesDAO();
            Edicoes edicoes = (Edicoes) daoEdicoes.read(Long.parseLong(request.getParameter("id")));
            request.setAttribute("edicoes", edicoes);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/edicoes/update.jsp");
            dispatcher.forward(request, response);
            
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/evento");
        }
    }
    
    private void updateEdicoesPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Edicoes edicoes = new Edicoes();
        
        edicoes.setId(Long.parseLong(request.getParameter("id")));
        edicoes.setIdEvento(Long.parseLong(request.getParameter("idEvento")));
        edicoes.setNome(request.getParameter("nome"));
        edicoes.setNomeEvento(request.getParameter("nomeEvento"));
        edicoes.setNomeLocal(request.getParameter("nomeLocal"));
        edicoes.setPreco(Float.parseFloat(request.getParameter("preco")));
        edicoes.setDataInicio(request.getParameter("dataInicio"));
        edicoes.setIdFormas_Pagamento(Long.parseLong(request.getParameter("idformas_pagamento")));
       
        try (DAOFactory daoFactory = new DAOFactory();) {
             // Local
            EdicoesDAO daoEd = daoFactory.getEdicoesDAO();
            edicoes.setIdLocal(daoEd.getIdLocalEd(edicoes.getNomeLocal()));
            
            // Edicoes
            DAO daoEdicoes = daoFactory.getEdicoesDAO();
            daoEdicoes.update(edicoes);

            response.sendRedirect(request.getContextPath() + "/evento");
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            HttpSession session = request.getSession();
            session.setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/edicoes/update");
        }
    }
    
    private void listEdicoes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Formas Pagamento - Edicoes - Evento
        try (DAOFactory daoFactory = new DAOFactory();) {
            // Formas Pagamento
            DAO daoFormasPagamento = daoFactory.getFormasPagamentoDAO();
            List<FormasPagamento> formasPagamentoList = daoFormasPagamento.all();
            request.setAttribute("formasPagamentoList", formasPagamentoList);
            
            // Edicoes
            DAO daoEdicoes = daoFactory.getEdicoesDAO();
            List<Edicoes> edicoesList = daoEdicoes.all();
            request.setAttribute("edicoesList", edicoesList);
            
            // Evento
            DAO daoEvento = daoFactory.getEventoDAO();
            Evento evento = (Evento) daoEvento.read(Long.parseLong(request.getParameter("id")));
            request.setAttribute("evento", evento);
            
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/edicoes/index.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listTudo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Formas de Pagamento - Local - Evento
        try (DAOFactory daoFactory = new DAOFactory();) {
            // Formas de Pagamento
            DAO daoFormasPagamento = daoFactory.getFormasPagamentoDAO();
            List<FormasPagamento> formasPagamentoList = daoFormasPagamento.all();
            request.setAttribute("formasPagamentoList", formasPagamentoList);
            
            // Local
            DAO daoLocal = daoFactory.getLocalEdDAO();
            List<LocalEd> localEdList = daoLocal.all();
            request.setAttribute("localEdList", localEdList);
            
            //Evento
            DAO dao = daoFactory.getEventoDAO();
            Evento evento = (Evento) dao.read(Long.parseLong(request.getParameter("id")));
            request.setAttribute("evento", evento);
            
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/edicoes/create.jsp");
        dispatcher.forward(request, response);

    }
    
    private void rendaEdicoes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {    
        // Edicoes
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEdicoesDAO();
            
            long id = Long.parseLong(request.getParameter("evento"));
            Edicoes edicao = (Edicoes) dao.read(Long.parseLong(request.getParameter("id")));
            request.setAttribute("edicao", edicao);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/edicoes?id="+id);
            dispatcher.forward(request, response);
            
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/evento");
        }
    }
}