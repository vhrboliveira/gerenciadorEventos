<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.CreateFBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
        <title>Gerenciador de Eventos</title>
    </head>
    <body>
        <%
            CreateFBConnection fbConnection = new CreateFBConnection();
        %>
        <div class="form">

            <ul class="tab-group">
                <li class="tab active"><a href="${pageContext.servletContext.contextPath}/usuario/create">Cadastro</a></li>
                <li class="tab"><a href="${pageContext.servletContext.contextPath}/evento">Eventos</a></li>
            </ul>

            <div class="tab-content">

                <div id="login">   
                    <h1>Fazer Login</h1>

                    <form action="${pageContext.servletContext.contextPath}/login" method="post">

                        <div class="field-wrap">
                            <h2>Usuário</h2>
                            <input type="text" name="login" required autofocus>
                        </div>

                        <div class="field-wrap">
                            <h2>Senha</h2>
                            <input type="password" name="senha" required>
                        </div>

                        <button class="button button-block" type="submit"/>Entrar</button>                       
                    </form>
                         <a href="<%=fbConnection.getFBAuthUrl()%>" class="button button"><h6>Login pelo facebook</h6></a>
                         
                </div>
                         

                <div id="redireciona">   
                    <!-- Redireciona -->
                </div>


            </div><!-- tab-content -->

        </div> <!-- /form -->
    </body>  
</html>
