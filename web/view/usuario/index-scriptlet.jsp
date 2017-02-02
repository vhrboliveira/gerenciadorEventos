<%-- 
    Document   : index
    Created on : 19/09/2016, 10:59:46
    Author     : dskaster
--%>

<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuários</title>
    </head>
    <body>

        <div class="container">
            
            <table>
                <thead>
                    <th>Login</th>
                    <th>Nome</th>
                    <th>Ações</th>
                </thead>
                <tbody>
                    
                    <%
                        
                        List<Usuario> usuarioList = (List<Usuario>) request.getAttribute("usuarioList");
                        for (Usuario u : usuarioList) {
                            out.println("<tr>");
                            out.println("<td>" + u.getLogin() + "</td>");
                            out.println("<td>" + u.getNome() + "</td>");
                            out.println("<td></td>");
                            out.println("</tr>");
                        }
                        
                        %>
                    
                </tbody>
            </table>
               
            
        </div>

    </body>
</html>
