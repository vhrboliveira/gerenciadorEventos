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
        <title>Inserir Forma de Pagamento</title>
    </head>
    <body style="background-color: #eeeeee;">
        <div class="container-fluid">
            <div class="container">
                <h2 class="text-primary">Inserção de uma nova forma de pagamento</h2>
                <p class="hr"></p>
            </div>
            <form class="form-horizontal" method="POST" action="${pageContext.servletContext.contextPath}/formas_pagamento/create">
                <%--// id , formas_pagamento  --%>
                <!-- Nome -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Forma de Pagamento:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="formas_pagamento" placeholder="Forma de pagamento" value="${formas.formas_pagamento}" required autofocus>
                        <br/>
                        <button class="btn btn-primary" type="submit">Inserir</button>
                        <a href="${pageContext.servletContext.contextPath}/formas_pagamento" class="btn btn-default" type="submit">Cancelar</a>
                
                    </div>
                </div>
            </form>
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>