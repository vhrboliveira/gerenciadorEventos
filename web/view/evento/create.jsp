<%@include file="/view/include/loginCheck.jsp"%>
<%@page contentType="text/html"%>

<c:if test="${(usuarioLogado.tipoUser == 3) }">
    <c:redirect context="${pageContext.servletContext.contextPath}" url="/welcome.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <title>Inserir Evento</title>
    </head>
    <body style="background-color: #eeeeee;">
        <div class="container-fluid">
            <div class="container">
                <h2 class="text-primary">Inserção de um novo evento</h2>
                <p class="hr"></p>
            </div>
            <form class="form-horizontal" name="formEvento" method="POST" action="${pageContext.servletContext.contextPath}/evento/create">
                <%--// titulo, descricao, inf_importantes  --%>
                <!-- TITULO -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Titulo:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="titulo" placeholder="Titulo do evento" value="${e.titulo}" required autofocus>
                    </div>
                </div>
                <!-- descricao -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Descriçao:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="descricao" placeholder="Descricao" value="${e.descricao}" required>
                    </div>
                </div>
                    
                <!-- Entidade Promotora -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Entidade Promotora:</label>
                    <div class="form-inline">
                        <div class="col-sm-4">
                            <select name="id_entidadepromotora">
                                <c:forEach var="ent" items="${entPromotoraList}">
                                    <option value="${ent.id}"><c:out value="${ent.nome}"/></option>                                                            
                                </c:forEach>    
                            </select> 
                        </div>
                    </div>
                </div>                        
                    
                <!-- INF_IMPORTATNES -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Informaçoes Importantes:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="inf_importantes" placeholder="Informaçoes Importantes" value="${e.inf_importantes}" required>
                        </br>
                        <button class="btn btn-primary" type="submit">Inserir</button>
                        <a href="${pageContext.servletContext.contextPath}/welcome.jsp" class="btn btn-default" type="submit">Cancelar</a>
                    </div>
                </div>
                 
            </form>
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>