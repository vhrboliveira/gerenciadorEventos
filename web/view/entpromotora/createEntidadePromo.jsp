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
        <title>Inserir Entidade Promotora</title>
    </head>
    <body style="background-color: #eeeeee;">
        <div class="container-fluid">
            <div class="container">
                <h2 class="text-primary">Inserção de uma nova entidade promotora</h2>
                <p class="hr"></p>
            </div>
            <form class="form-horizontal" name="formEventoEntPro" method="POST" action="${pageContext.servletContext.contextPath}/entidade_promotora/create">
                <%--// Nome, descrição  --%>
                <!-- Nome -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Nome:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="nome" placeholder="Nome entidade promotora" value="${ent.nome}" required autofocus>
                    </div>
                </div>
                <!-- Descricao -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Descrição:</label>
                    <div class="col-sm-4">
                        <textarea rows="4" class="form-control" placeholder="Descrição" name="descricao" value="${ent.descricao}" required></textarea> 
                        <br/><br/>
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