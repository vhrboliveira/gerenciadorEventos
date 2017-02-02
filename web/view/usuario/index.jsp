<%@include file="/view/include/loginCheck.jsp"%>

<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html"%>



<c:if test="${usuarioLogado.tipoUser == 3}">
    <c:redirect context="${pageContext.servletContext.contextPath}" url="/welcome.jsp"/>
</c:if>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <title>Usuários</title>
    </head>
    <body style="background-color: #eeeeee;">

        <div class="container">
            <h3 class="text-primary">Usuários</h3>
            <div class="table-responsive">          
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Login</th>
                        <th>Nome</th>
                        <th>Tipo de Usuário</th>
                        <c:if test="${usuarioLogado.tipoUser != 3}">  
                        <th>Ações</th>
                        </c:if>
                    </tr>
                </thead>
                <tbody>
                
                <!-- ADMINISTRADOR -->    
                <c:if test="${usuarioLogado.tipoUser == 1}">
                <c:forEach var="u" items="${usuarioList}">
                    <tr>
                        
                            <td><c:out value="${u.login}"/></td>
                            <td>
                                <a href="${pageContext.servletContext.contextPath}/usuario/info?id=${u.uid}">
                                    <c:out value="${u.nome}"/>
                                </a>
                            </td>
                            <c:choose>
                            <c:when test="${u.tipoUser == 1}">
                                <td>Adminstrador</td>
                            </c:when>
                            <c:when test="${u.tipoUser == 2}">
                                <td>Membro</td>
                            </c:when>
                            <c:when test="${u.tipoUser == 3}">
                                <td>Participante</td>
                            </c:when>
                            </c:choose> 
                            <td>
                                <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/usuario/update?id=${u.uid}" >
                                    Editar
                                </a> 
                                <a class="btn btn-default link_excluir_usuario" href="${pageContext.servletContext.contextPath}/usuario/delete?id=${u.uid}">
                                    Excluir
                                </a>
                                <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/evento?id=${u.uid}">
                                    Inscrever em evento
                                </a>    
                            </td>
                    </tr>                    
                </c:forEach>
                </c:if>
                
                <!-- MEMBRO -->
                <c:if test="${(usuarioLogado.tipoUser == 2)}">
                    <c:forEach var="u" items="${usuarioList}">
                        <tr>
                            <c:if test="${(u.tipoUser != 1)}">
                                <td><c:out value="${u.login}"/></td>
                                <td>
                                <a href="${pageContext.servletContext.contextPath}/usuario/info?id=${u.uid}">
                                    <c:out value="${u.nome}"/>
                                </a>
                                </td>
                                <c:choose>
                                <c:when test="${u.tipoUser == 2}">
                                    <td>Membro</td>
                                </c:when>
                                <c:when test="${u.tipoUser == 3}">
                                    <td>Participante</td>
                                </c:when>
                                </c:choose>
                                <td>
                                    <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/usuario/update?id=${u.uid}" >
                                       Editar
                                    </a>
                                    <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/evento?id=${u.uid}">
                                    Inscrever em evento
                                    </a>       
                                </td>
                            </c:if>
                        </tr>                    
                    </c:forEach>
                </c:if>
                
                </tbody>
            </table>
            </div>
            <a class="btn btn-primary " href="${pageContext.servletContext.contextPath}/usuario/create">
                Inserir novo usuário
            </a>
            <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/welcome.jsp">Voltar</a>    

               
            
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
