<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/view/include/loginCheck.jsp"%>
<%@page import="java.util.List"%>
<%@page import="model.Evento"%>
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
        <title>Entidade Promotora</title>
    </head>
    <body style="background-color: #eeeeee;">

        <div class="container">
            <h3 class="text-primary">Entidades Promotoras</h3>
            <div class="table-responsive">          
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <%--// Nome, descricao--%>
                        <th>Nome</th>
                        <th>Descrição</th>
                        <c:if test="${!empty sessionScope.usuarioLogado}" >
                            <c:if test="${usuarioLogado.tipoUser != 3 }">
                                <th>Açoes</th>
                            </c:if>
                        </c:if>
                    </tr>
                </thead>
                <tbody>
                
                <c:forEach var="ent" items="${entPromotoraList}">
                    <tr>                        
                        <td><c:out value="${ent.nome}"/></td>
                        <td><c:out value="${ent.descricao}"/></td>
                        
                        <c:if test="${!empty sessionScope.usuarioLogado}" >
                            <c:if test="${usuarioLogado.tipoUser != 3}" >
                            <td>
                                <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/entidade_promotora/update?id=${ent.id}" >
                                    Editar
                                </a> 
                                <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/entidade_promotora/delete?id=${ent.id}">
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
                    <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/entidade_promotora/create">Inserir nova entidade promotora</a>
                </c:if>
            </c:if>
            <a class="btn btn-default " href="${pageContext.servletContext.contextPath}/welcome.jsp">Voltar</a>

               
            
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
