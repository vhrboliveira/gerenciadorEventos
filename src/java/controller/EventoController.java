package controller;

import dao.DAO;
import dao.DAOFactory;
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
import model.Edicoes;
import model.EntPromotora;
import model.Evento;
import model.Usuario;

@WebServlet(
        name = "EventoController",
        urlPatterns = {
            "/evento",
            "/evento/create",
            "/evento/delete",
            "/evento/update",
            "/evento/inscricaoadm",
            "/evento/estatisticas"})
public class EventoController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       // RequestDispatcher dispatcher;

        switch (request.getServletPath()) {
            case "/evento":
                listEvento(request, response);
                break;
                
            case "/evento/create":
                listEntPromotora_Evento(request, response);
                break;
                
            case "/evento/delete":
                deleteEvento(request, response);
                break;
                
            case "/evento/update":
                updateEvento(request, response);
                break;
                
            case "/evento/inscricaoadm":
                habilitarInscricao(request, response);
                break;
                
            case "/evento/estatisticas":
                estatisticas(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        switch (request.getServletPath()) {
            case "/evento/create":
                createEvento(request, response);
                break;
            case "/evento/update":
                updateEventoPost(request, response);
                break;
        }

    }
       
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void createEvento(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Evento evento = new Evento();
        
        evento.setDescricao(request.getParameter("descricao"));
        evento.setInf_importantes(request.getParameter("inf_importantes"));
        evento.setId_entidadepromotora(Long.parseLong(request.getParameter("id_entidadepromotora")));
        evento.setTitulo(request.getParameter("titulo"));
        
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEventoDAO();

            dao.create(evento);

            response.sendRedirect(request.getContextPath() + "/evento");
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            HttpSession session = request.getSession();
            session.setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/evento/create");
        }

    }
    
    private void deleteEvento(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEventoDAO();

            dao.delete(Long.parseLong(request.getParameter("id")));
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/evento");

    }
    
    private void updateEvento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Entidade Promotora - Evento
        try (DAOFactory daoFactory = new DAOFactory();) {
            //Entidade Promotor
            DAO daoEntPromotora = daoFactory.getEntPromotoraDAO();
            List<EntPromotora> entPromotoraList = daoEntPromotora.all();
            request.setAttribute("entPromotoraList", entPromotoraList);
            
            //Evento
            DAO daoEvento = daoFactory.getEventoDAO();
            Evento evento = (Evento) daoEvento.read(Long.parseLong(request.getParameter("id")));
            request.setAttribute("e", evento);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/evento/update.jsp");
            dispatcher.forward(request, response);
            
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/usuario");
        }
    }
    
    private void updateEventoPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Evento evento = new Evento();
        
        evento.setDescricao(request.getParameter("descricao"));
        evento.setId(Long.parseLong(request.getParameter("id")));
        evento.setId_entidadepromotora(Long.parseLong(request.getParameter("id_entidadepromotora")));
        evento.setInf_importantes(request.getParameter("inf_importantes"));
        evento.setTitulo(request.getParameter("titulo"));
        evento.setStatus(Long.parseLong("0"));
        
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEventoDAO();

            dao.update(evento);

            response.sendRedirect(request.getContextPath() + "/evento");
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            HttpSession session = request.getSession();
            session.setAttribute("error", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/evento/update");
        }
    }
    
    
    private void listEvento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);//obtém a sessão sem forçar criá-la (false)
        try (DAOFactory daoFactory = new DAOFactory();) {
            // Entidade Promotora
            DAO daoEntPromotora = daoFactory.getEntPromotoraDAO();
            List<EntPromotora> entPromotoraList = daoEntPromotora.all();
            request.setAttribute("entPromotoraList", entPromotoraList);
            
            // INSCREVER A PARTIR DA LISTA DE USUARIO
            if(request.getParameter("id") != null){
                DAO dao2 = daoFactory.getUsuarioDAO();
                Usuario usuario = (Usuario) dao2.read(Long.parseLong(request.getParameter("id")));
                session.setAttribute("usuarioInscricao", usuario);
            }
           
            // Evento
            DAO daoEvento = daoFactory.getEventoDAO();
            List<Evento> eventoList = daoEvento.all();
            request.setAttribute("eventoList", eventoList);
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/evento/index.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listEntPromotora_Evento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (DAOFactory daoFactory = new DAOFactory();) {
            DAO dao = daoFactory.getEntPromotoraDAO();

            List<EntPromotora> entPromotoraList = dao.all();
            request.setAttribute("entPromotoraList", entPromotoraList);
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/evento/create.jsp");
        dispatcher.forward(request, response);

    }
    
    private void habilitarInscricao(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        
        HttpSession session = request.getSession(false);//obtém a sessão sem forçar criá-la (false)
        RequestDispatcher dispatcher;

        if (session != null && session.getAttribute("usuarioLogado") != null) {
            Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
            if(usuario.getTipoUser() != 3){
                //Logado e não é participante, redireciona para página inicial
                Evento evento = new Evento();
                evento.setId(Long.parseLong(request.getParameter("id")));
                evento.setStatus(Long.parseLong(request.getParameter("status")));

                try (DAOFactory daoFactory = new DAOFactory();) {
                    DAO dao = daoFactory.getEventoDAO();

                    dao.update(evento);

                    response.sendRedirect(request.getContextPath() + "/evento");
                } catch (ClassNotFoundException | IOException | SQLException ex) {
                    //HttpSession session = request.getSession();
                    session.setAttribute("error", ex.getMessage());
                    response.sendRedirect(request.getContextPath() + "/evento/update");
                }
            }else{
                dispatcher = request.getRequestDispatcher("/welcome.jsp");
                dispatcher.forward(request, response);  
            }
        } else {
            //Não logado, redireciona para página de login
            dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void estatisticas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //HttpSession session = request.getSession(false);//obtém a sessão sem forçar criá-la (false)
        
        try (DAOFactory daoFactory = new DAOFactory();) {           
            // Evento
            DAO daoEvento = daoFactory.getEventoDAO();
            List<Evento> eventoList = daoEvento.all();
            request.setAttribute("eventoList", eventoList);
            
            // Edicoes
            DAO daoEdicoes = daoFactory.getEdicoesDAO();
            List<Edicoes> edicoesList = daoEdicoes.all();
            request.setAttribute("edicoesList", edicoesList);
            
        } catch (ClassNotFoundException | IOException | SQLException ex) {
            request.getSession().setAttribute("error", ex.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/estatisticas/index.jsp");
        dispatcher.forward(request, response);
    }
}