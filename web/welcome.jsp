<%@include file="/view/include/loginCheck.jsp"%>

<%@page contentType="text/html"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <title>Gerenciador de Eventos</title>
    </head>
    <body style="background-color: #eeeeee;">

        <div class="container">
            <h1>Bem-vindo, <c:out value="${usuarioLogado.nome}"/>!</h1>
            <p>
                <c:if test="${usuarioLogado.tipoUser == 3}">
                    <br/>
                    <a class="btn btn-primary btn-block btn-lg" href="${pageContext.servletContext.contextPath}/usuario/update?id=${usuarioLogado.uid}">Alterar dados pessoais</a>
                    <br/>
                    <a class="btn btn-warning btn-block btn-lg" href="${pageContext.servletContext.contextPath}/usuario/info?id=${usuarioLogado.uid}">Visualizar dados pessoais</a>
                    <br/>                    
                    <a class="btn btn-success btn-block btn-lg" href="${pageContext.servletContext.contextPath}/evento">Lista de Eventos</a>
                </c:if>
                <c:if test="${usuarioLogado.tipoUser != 3}">
                    <br/>
                    <a class="btn btn-primary btn-block btn-lg" href="${pageContext.servletContext.contextPath}/usuario">Gerenciar Usuários</a>
                    <br/>
                    <a class="btn btn-success btn-block btn-lg" href="${pageContext.servletContext.contextPath}/evento">Gerenciar Eventos</a>
                    <br/>
                    <a class="btn btn-danger btn-block btn-lg" href="${pageContext.servletContext.contextPath}/local">Gerenciar Local</a>
                    <br/>
                    <a class="btn btn-warning btn-block btn-lg" href="${pageContext.servletContext.contextPath}/entidade_promotora">Gerenciar Entidade Promotora</a>                    
                    <br/>
                    <a class="btn btn-primary btn-block btn-lg" href="${pageContext.servletContext.contextPath}/formas_pagamento">Gerenciar Formas de Pagamento</a>
                </c:if>    
                <br/>
                <a class="btn btn-default btn-block btn-lg" href="${pageContext.servletContext.contextPath}/logout">Logout</a>
            </p>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
