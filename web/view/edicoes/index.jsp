<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="model.Edicoes"%>
<%@page contentType="text/html"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
<title>Edições</title>
</head>
<body style="background-color: #eeeeee;">
    <div class="container">
        <h3 class="text-primary">Edições</h3>
        <div class="table-responsive">          
            <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <%--//(id, nome ,idlocal, nomelocal, idevento, preco, formas_pagamento)--%>
                    <th>Nome</th>
                    <th>Evento</th>
                    <th>Local</th>
                    <th>Preço</th>
                    <th>Formas de Pagamento</th>
                    <c:if test="${!empty sessionScope.usuarioLogado}" >
                        <c:if test="${usuarioLogado.tipoUser != 3}">
                        <th>Renda Total</th>
                        </c:if>
                    <th>Ações</th>
                    </c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="edicoes" items="${edicoesList}">
                    <c:choose>
                        <c:when test="${evento.id == edicoes.idEvento}">
                        <tr>                        
                            <td><c:out value="${edicoes.nome}"/></td>
                            <td><c:out value="${evento.titulo}"/></td>
                            <td><c:out value="${edicoes.nomeLocal}"/></td>
                            <td><c:out value="${edicoes.preco}"/></td>
                            <c:forEach var="formas" items="${formasPagamentoList}">
                                <c:if test="${formas.id == edicoes.idFormas_Pagamento}">
                                    <td><c:out value="${formas.formas_pagamento}"/></td>
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${!empty sessionScope.usuarioLogado}" >
                                <c:if test="${usuarioLogado.tipoUser != 3}" >
                                <td>
                                    <c:if test="${(edicao != null) && (edicao.id == edicoes.id)}">
                                        <c:out value="${edicao.renda}"/>
                                    </c:if>
                                </td>
                                </c:if>
                                <td>
                                <c:if test="${usuarioLogado.tipoUser != 3}" >
                                    <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/edicoes/update?id=${edicoes.id}" >
                                        Editar
                                    </a> 
                                    <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/edicoes/delete?id=${edicoes.id}">
                                        Excluir
                                    </a>  
                                    <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/inscricao?id=${edicoes.id}" >
                                    Inscritos
                                </a>    
                                </c:if>
                                <c:if test="${evento.status == 1}">
                                    <a class="btn btn-success" href="${pageContext.servletContext.contextPath}/inscricao/create?id=${edicoes.id}" >
                                        Inscrever-se
                                    </a>     
                                </c:if>
                                <c:if test="${usuarioLogado.tipoUser != 3}" >
                                   <%-- <c:if test="${edicao == null}"> --%>
                                    <a class="btn btn-danger" href="${pageContext.servletContext.contextPath}/edicoes/renda?id=${edicoes.id}&evento=${edicoes.idEvento}" >
                                        Renda
                                    </a>
                                </c:if>
                                </td>
                            </c:if>
                        </tr>   
                        </c:when>
                    </c:choose>
                </c:forEach>
            </tbody>
            
            </table>
        </div>
        <c:if test="${!empty sessionScope.usuarioLogado}" >  
            <c:if test="${usuarioLogado.tipoUser != 3}" >
                <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/edicoes/create?id=${evento.id}">Inserir nova edição</a>
            </c:if>
        </c:if>
        <a class="btn btn-default " href="${pageContext.servletContext.contextPath}/evento">Voltar</a>               
    </div>
</body>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
