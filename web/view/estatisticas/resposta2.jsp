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
            <h3 class="text-primary">Estatsíticas vários eventos</h3>
            <div class="table-responsive">
            <c:forEach var="edicoes" items="${edicoesList}">    
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Número de participantes: <c:out value="${edicoes.nome}"/></th>
                        <th>Resultado</th>
                    </tr>
                </thead> 
                <tbody>
                
                    <tr>
                        <c:if test="${edicoes.aux == 'total'}">
                            <td>Total: </td><td><c:out value="${edicoes.total}" /></td>
                        </c:if>                        
                    </tr>
                    <tr>
                        <c:if test="${edicoes.aux == 'masculino'}">
                            <td>Masculino:</td><td><c:out value="${edicoes.masculino}" /></td>
                        </c:if>
                    </tr>
                    <tr>
                        <c:if test="${edicoes.aux == 'feminino'}">
                            <td>Feminino:</td><td><c:out value="${edicoes.feminino}" /></td>
                        </c:if>
                    </tr>
                    <tr>
                        <c:if test="${edicoes.aux == 'outro'}">
                            <td>Outro:</td><td> <c:out value="${edicoes.outro}" /></td>
                        </c:if>
                    </tr>
                    <tr>
                        <c:if test="${edicoes.aux == 'inst_origem'}">
                            <td>Instituição de origem:</td><td><c:out value="${edicoes.inst_origem}" /></td>
                        </c:if>    
                    </tr>
                    <tr>
                        <c:if test="${edicoes.aux == 'faixa'}">
                            <td>Faixa etária:</td><td><c:out value="${edicoes.faixa}" /></td>
                        </c:if>    
                    </tr>
                    <tr>
                        <c:if test="${edicoes.aux == 'faixa-sexo'}">
                            <td>Faixa etária + sexo:</td><td><c:out value="${edicoes.faixa}" /></td>
                        </c:if>    
                    </tr>
                </tbody>
            </table>
            </c:forEach>
            </div>
            <a class="btn btn-default " href="${pageContext.servletContext.contextPath}/estatisticastotal">Voltar</a>

               
            
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
