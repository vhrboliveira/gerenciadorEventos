<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/view/include/loginCheck.jsp"%>
<%@page import="java.util.List"%>
<%@page import="model.LocalEd"%>
<%@page contentType="text/html"%>

<c:if test="${((usuarioLogado.tipoUser == 3) && (u.uid != usuarioLogado.uid)) || ( (usuarioLogado.tipoUser == 2) && (u.tipoUser == 1))}">
    <c:redirect context="${pageContext.servletContext.contextPath}" url="/welcome.jsp"/>
</c:if>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <title>Locais</title>
    </head>
    <body style="background-color: #eeeeee;">

        <div class="container">
            <h3 class="text-primary">Locais</h3>
            <div class="table-responsive">          
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
<%-- id,nome,logradouro,complemento,bairro,cep,cidade,estado,tel_tipo,tel_ddd,tel_num,latitude,longitude --%>
                        <th>Nome</th>
                        <th>Cep</th>
                        <th>Estado</th>
                        <th>Cidade</th>
                        <th>Bairro</th>
                        <th>Logradouro</th>
                        <th>Complemento</th>
                        <th>Tipo Telefone</th>
                        <th>DDD</th>
                        <th>Nº Telefone</th>
                        <th>Latitude</th>
                        <th>Longitude</th>
                        
                        <c:if test="${!empty sessionScope.usuarioLogado}" >
                            <c:if test="${usuarioLogado.tipoUser != 3 }">
                                <th>Açoes</th>
                            </c:if>
                        </c:if>
                    </tr>
                </thead>
                <tbody>
                
                <c:forEach var="l" items="${localEdList}">
                    <tr>                        
                        <td><c:out value="${l.nome}"/></td>
                        <td><c:out value="${l.cep}"/></td>
                        <td><c:out value="${l.estado}"/></td>
                        <td><c:out value="${l.cidade}"/></td>
                        <td><c:out value="${l.bairro}"/></td>
                        <td><c:out value="${l.logradouro}"/></td>
                        <td><c:out value="${l.complemento}"/></td>
                        <td><c:out value="${l.tel_tipo}"/></td>
                        <td><c:out value="${l.tel_ddd}"/></td>
                        <td><c:out value="${l.tel_num}"/></td>
                        <td><c:out value="${l.latitude}"/></td>
                        <td><c:out value="${l.longitude}"/></td>
                        <c:if test="${!empty sessionScope.usuarioLogado}" >
                            <c:if test="${usuarioLogado.tipoUser != 3}" >
                            <td>
                                <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/local/update?id=${l.id}" >
                                    Editar
                                </a> 
                                <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/local/delete?id=${l.id}">
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
                    <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/local/create">Inserir novo local</a>
                </c:if>
            </c:if>
            <a class="btn btn-default " href="${pageContext.servletContext.contextPath}/welcome.jsp">Voltar</a>

               
        </div>
        

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
