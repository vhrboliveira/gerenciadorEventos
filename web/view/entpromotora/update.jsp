<%@include file="/view/include/loginCheck.jsp"%>

<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" %> 


<c:if test="${((usuarioLogado.tipoUser == 3) && (u.uid != usuarioLogado.uid)) || ( (usuarioLogado.tipoUser == 2) && (u.tipoUser == 1))}">
    <c:redirect context="${pageContext.servletContext.contextPath}" url="/welcome.jsp"/>
</c:if>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/cep.js">            
        </script>
        <title>Editar Entidade Promotora</title>
    </head>
    <body style="background-color: #eeeeee;">
        <div class="container-fluid">
            <div class="container">
                <h2 class="text-primary">Editar Entidade Promotora</h2>
                <p class="hr"></p>
            </div>
            <form class="form-horizontal" name="formEventoEntPro" method="POST" action="${pageContext.servletContext.contextPath}/entidade_promotora/update">
                <%--// Nome, descrição  --%>
                <input type="hidden" name="id" value="${ent.id}">
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
                        <textarea class="form-control" rows="4"  name="descricao" value="${ent.descricao}" required><c:out value="${ent.descricao}" /></textarea> 
                        <br/><br/>
                        <button class="btn btn-primary" type="submit">Atualizar</button>
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
