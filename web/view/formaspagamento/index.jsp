<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/view/include/loginCheck.jsp"%>
<%@page import="java.util.List"%>
<%@page import="model.FormasPagamento"%>
<%@page contentType="text/html"%>

<c:if test="${(usuarioLogado.tipoUser == 3) }">
    <c:redirect context="${pageContext.servletContext.contextPath}" url="/welcome.jsp"/>
</c:if>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <title>Formas de Pagamento</title>
    </head>
    <body style="background-color: #eeeeee;">

        <div class="container">
            <h3 class="text-primary">Formas de Pagamento</h3>
            <div class="table-responsive">          
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <%--// id, formas_pagamento--%>
                        <th>Formas de Pagamento</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                
                <c:forEach var="formas" items="${formasPagamentoList}">
                    <tr>                        
                        <th><c:out value="${formas.formas_pagamento}"/></th>
                        <c:if test="${!empty sessionScope.usuarioLogado}" >
                            <c:if test="${usuarioLogado.tipoUser != 3}" >
                            <td>
                                <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/formas_pagamento/update?id=${formas.id}" >
                                    Editar
                                </a> 
                                <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/formas_pagamento/delete?id=${formas.id}">
                                    Excluir
                                </a>                            
                            </td>
                            </c:if>
                        </c:if>
                    </tr>                    
                </c:forEach>
                
                </tbody>
            </table>
            </div>
            <c:if test="${!empty sessionScope.usuarioLogado}" >  
                <c:if test="${usuarioLogado.tipoUser != 3}" >
                    <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/formas_pagamento/create">Inserir nova forma de pagamento</a>
                </c:if>
            </c:if>
            <a class="btn btn-default " href="${pageContext.servletContext.contextPath}/welcome.jsp">Voltar</a>

               
            
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
