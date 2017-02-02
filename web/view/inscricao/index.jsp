<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="model.Edicoes"%>
<%@include file="/view/include/loginCheck.jsp"%>
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/tablesort/css/style.css">

<script src="${pageContext.request.contextPath}/resources/tablesort/jquery-latest.js"></script>
<script src="${pageContext.request.contextPath}/resources/tablesort/jquery.tablesorter.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/tablesort/scripts.js"></script>

<title>Inscrições</title>
</head>
<body style="background-color: #eeeeee;">
    <div class="container">
        <h3 class="text-primary">Lista de Inscritos</h3>
        <div class="table-responsive">          
            <table class="table table-hover table-bordered tablesorter">
            <thead>
                <tr>
                    <%--// //(id,idUsuario,idEdicao, valor_inscricao, data_inscricao 
                        // status_inscricao,status_pagamento, valor_pago--%>
                    <th> Usuário </th>
                    <th>Evento</th> <!-- Edição -->
                    <th>Valor da inscrição</th>
                    <th>Valor pago</th>
                    <th>Data da inscrição</th>
                    <th>Status da inscrição</th>
                    <c:if test="${!empty sessionScope.usuarioLogado}" >
                        <c:if test="${usuarioLogado.tipoUser != 3 }">
                        <th>Ações</th>
                        <th>Inscrição</th>
                        </c:if>
                    </c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="inscricao" items="${inscricaoList}">
                    <c:if test="${inscricao.idEdicao == edicoes.id}">
                    <tr> 
                        <c:forEach var="usuario" items="${usuarioList}">
                            <c:if test="${usuario.uid == inscricao.idUsuario}" >
                                <td>
                                    <a href="${pageContext.servletContext.contextPath}/usuario/info?id=${usuario.uid}">
                                        <c:out value="${usuario.nome}"/>
                                    </a>
                                </td>
                            </c:if>
                        </c:forEach>
                        <c:forEach var="evento" items="${eventoList}">
                            <c:if test="${evento.id == edicoes.idEvento}" >
                                <td><c:out value="${evento.titulo}"/></td>
                            </c:if>
                        </c:forEach>
                        <td><c:out value="${inscricao.valor_inscricao}"/></td>
                        <td>
                        <c:if test="${inscricao.status_pagamento == 1}">
                            <c:out value="${inscricao.valor_pago}"/>
                        </c:if>
                        </td>
                        <td><c:out value="${inscricao.data_inscricao}"/></td>
                        <c:if test="${inscricao.status_inscricao == 0}">
                            <td><strong style="color:#fd020e">Pendente</strong></td>
                        </c:if>
                        <c:if test="${inscricao.status_inscricao == 1}">
                            <td><strong style="color:#029317">Confirmada</strong></td>
                        </c:if>    
                        <c:if test="${!empty sessionScope.usuarioLogado}" >
                            <c:if test="${usuarioLogado.tipoUser != 3}" >
                                <td>
                                    <c:if test="${(inscricao.status_inscricao == 1)}">
                                        <c:if test="${inscricao.status_pagamento == 0}">
                                        <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/inscricao/update?id=${inscricao.id}" >
                                        Pagamento
                                        </a>
                                        </c:if>
                                        
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${inscricao.status_inscricao == 0}">
                                    <a class="btn btn-success" href="${pageContext.servletContext.contextPath}/inscricao/confirmar?id=${inscricao.id}&status_inscricao=1&idEdicao=${inscricao.idEdicao}" >
                                        Confirmar inscrição
                                    </a> 
                                    </c:if>
                                    <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/inscricao/delete?id=${inscricao.id}">
                                        Cancelar Inscrição
                                    </a>
                                    <%--<c:if test="${inscricao.status_pagamento == 1}" >
                                    <a class="btn btn-warning" href="${pageContext.servletContext.contextPath}/inscricao/recibo?id=${inscricao.id}">
                                        Emitir Recibo
                                    </a>    
                                    </c:if>    --%>
                                </td>
                            </c:if>
                        </c:if>
                    </tr> 
                    </c:if>
                </c:forEach>
            </tbody>
            
            </table>
        </div>
                    <%--
        <c:if test="${!empty sessionScope.usuarioLogado}" >  
            <c:if test="${usuarioLogado.tipoUser != 3}" >
                <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/edicoes/create?id=${evento.id}">Inscrição</a>
            </c:if>
        </c:if>--%>
        <a class="btn btn-default " href="${pageContext.servletContext.contextPath}/edicoes?id=${edicoes.idEvento}">Voltar</a>               
    </div>
</body>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>