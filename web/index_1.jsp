<%@page contentType="text/html"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
       
        <title>Gerenciador de Eventos</title>
    </head>
    <body style="background-color: #eeeeee">
        <div class="container-fluid" style="background-color:#02528b; padding-bottom:30px;">
            <form class="form-inline" action="${pageContext.servletContext.contextPath}/login" method="POST">
                <input type="hidden" name="tipoUser">
                <h2 class="form-horizontal" style="color: #FFFFFF;">Faça login ou cadastre-se.</h2>
                <div class="form-group">
                    <input class="form-control" type="text" name="login" placeholder="Usuário" required autofocus>
                </div>
                <div class="form-group">
                    <input class="form-control" type="password" name="senha" placeholder="Senha" required>
                </div>
                <button class="btn btn-default" type="submit">Login</button>
                <a class="btn btn-success" href="${pageContext.servletContext.contextPath}/usuario/create" >
                                    Cadastrar
                                </a>
            </form>
        </div>
        <div class="container">
            </br>
            <a class="btn btn-success btn-block btn-lg" href="${pageContext.servletContext.contextPath}/evento">Lista de Eventos</a>              
        </div>
    </body>
    
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
