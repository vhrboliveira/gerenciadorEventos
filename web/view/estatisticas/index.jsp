<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/view/include/loginCheck.jsp"%>
<%@page import="java.util.List"%>
<%@page import="model.FormasPagamento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${(usuarioLogado.tipoUser == 3) }">
    <c:redirect context="${pageContext.servletContext.contextPath}" url="/welcome.jsp"/>
</c:if>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <title>Evento</title>
    </head>
    <body style="background-color: #eeeeee;">

        <div class="container">
            <h3 class="text-primary">Evento Específico</h3>
            <div class="table-responsive">          
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Titulo</th>
                    </tr>
                </thead> 
                <tbody>
                
                <c:forEach var="e" items="${eventoList}">
                    <c:if test="${(!empty sessionScope.usuarioLogado) && (usuarioLogado.tipoUser != 3)}" >
                        <tr>                        
                            <td><b><c:out value="${e.titulo}"/></b>
                                <table class="table table-bordered" style="margin-top:10px;"> 
                                    <c:forEach var="ed" items="${edicoesList}">
                                        <tr>
                                            <c:if test="${e.id == ed.idEvento}" >
                                                <td><c:out value="${ed.nome}"/></td>                                                
                                                <td><a class="btn btn-primary " href="${pageContext.servletContext.contextPath}/estatisticas?id=${ed.id}">Estatísticas</a></td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                
                </tbody>
            </table>
                
                <br><br>
            <h3 class="text-primary">Vários Eventos</h3>
            <div class="table-responsive">  
             <form class="form-horizontal" method="POST" action="${pageContext.servletContext.contextPath}/estatisticastotal">
                <table class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>Titulo</th>
                        </tr>
                    </thead> 
                    <tbody>
                        <c:set var="i" value="0"/>
                       
                        <c:forEach var="e" items="${eventoList}">
                            <c:if test="${(!empty sessionScope.usuarioLogado) && (usuarioLogado.tipoUser != 3)}" >
                                <tr>                        
                                    <td><b><c:out value="${e.titulo}"/></b>
                                        <table class="table table-bordered" style="margin-top:10px;"> 
                                            <c:forEach var="ed" items="${edicoesList}">
                                                <tr>
                                                    <c:if test="${e.id == ed.idEvento}" >
                                                        <td><input type="checkbox" name="ids${i}" value="${ed.id}"><c:out value="${ed.nome}"/><c:set var="i" value="${i+1}" /></td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>        
                    </tbody>
                </table>
                        <input type="hidden" name="cont" value="${i}" >        
                <button class="btn btn-primary" type="submit">Estatísticas</button>
                <a class="btn btn-warning " href="${pageContext.servletContext.contextPath}/evento">Voltar</a><br><br>
                </form>
            </div>                        
            

               
            
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
