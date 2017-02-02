<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="model.Evento"%>
<%@page contentType="text/html"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style2.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <title>Evento</title>
    </head>
    <body style="background-color: #eeeeee;">

        <div class="container">
            <h3 class="text-primary">Evento</h3>
            <div class="table-responsive">
                
            <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Digite o evento ou entidade promotora" >
                
            <table id="myTable" > <%--class="table table-hover table-bordered"> --%>
                <%--<thead>--%>
                    <tr class="header">
                        <%--// titulo, descricao, inf_importantes, preco  --%>
                        <th style="width:40%;">Titulo</th>
                        <th style="width:20%;">Entidade Promotora</th>
                        <th style="width:15%;">Status</th>
                        <th style="width:25%;">Ações</th>
                    </tr>
                <%--</thead> 
                <tbody>--%>
                
                <c:forEach var="e" items="${eventoList}">
                    <c:if test="${(!empty sessionScope.usuarioLogado) && (usuarioLogado.tipoUser != 3)}" >
                        <tr >                        
                            <td><c:out value="${e.titulo}"/></td>
                            <td>
                            <c:forEach var="ent" items="${entPromotoraList}" >
                                <c:if test="${ent.id == e.id_entidadepromotora}">
                                    <c:out value="${ent.nome}"/>    
                                </c:if>
                            </c:forEach>
                            </td>
                            
                            <td>
                                <c:choose>
                                    <c:when test="${e.status == 1}">
                                        <strong style="color: #029317">Inscrições abertas</strong>    
                                    </c:when>
                                    <c:otherwise>
                                        <strong style="color: #fd020e">Inscrições fechadas</strong>
                                    </c:otherwise>
                                </c:choose> 
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${e.status == 1}">    
                                        <a class="btn btn-danger" href="${pageContext.servletContext.contextPath}/evento/inscricaoadm?id=${e.id}&status=2">Encerrar</a>    
                                    </c:when>
                                    <c:otherwise>
                                        <a class="btn btn-success" href="${pageContext.servletContext.contextPath}/evento/inscricaoadm?id=${e.id}&status=1">Habilitar</a>    
                                    </c:otherwise>
                                </c:choose>
                                <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/edicoes?id=${e.id}">Edições</a>    
                                <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/evento/update?id=${e.id}" >
                                    Editar
                                </a> 
                                <a class="btn btn-default" href="${pageContext.servletContext.contextPath}/evento/delete?id=${e.id}">
                                    Excluir
                                </a>    
                            </td>
                        </tr>          
                    </c:if>
                    
                    <%-- EVENTOS ABERTOS PARA INSCRIÇÃO (MODO PARTICIPANTE OU VISITANTE) --%>
                    <c:if test="${(empty sessionScope.usuarioLogado) || (usuarioLogado.tipoUser == 3) }" >
                        <c:if test="${e.status == 1}">
                        <tr>                        
                            <td ><c:out value="${e.titulo}"/></td>
                            <td>
                            <c:forEach var="ent" items="${entPromotoraList}" >
                                <c:if test="${ent.id == e.id_entidadepromotora}">
                                    <c:out value="${ent.nome}"/>    
                                </c:if>
                            </c:forEach>
                            </td>
                            <td>
                                <c:if test="${(empty sessionScope.usuarioLogado)}" >
                                    <strong style="color: #029317">Inscrições abertas</strong>    
                                </c:if>
                                <c:if test="${(usuarioLogado.tipoUser == 3)}" >
                                    <strong style="color: #029317">Inscrições abertas</strong>  
                                </c:if>
                            </td>
                            <td>
                                <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/edicoes?id=${e.id}">Edições</a>    
                            </td>
                        </tr>
                        </c:if>
                    </c:if>
                </c:forEach>
                
                </tbody>
            </table>
            </div>
            <c:if test="${!empty sessionScope.usuarioLogado}" >  
                <c:if test="${usuarioLogado.tipoUser != 3}" >
                    <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/evento/create">Inserir novo Evento</a>
                    <a class="btn btn-success" href="${pageContext.servletContext.contextPath}/evento/estatisticas" >Estatísticas</a>
                </c:if>
            </c:if>
            <a class="btn btn-default " href="${pageContext.servletContext.contextPath}/welcome.jsp">Voltar</a>

               
            
        </div>
            <script>
function myFunction() {
  var input, filter, table, tr, td, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    td2 = tr[i].getElementsByTagName("td")[1];
    if (td || td2) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1 || td2.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}
            </script>
      
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
    </body>
</html>
