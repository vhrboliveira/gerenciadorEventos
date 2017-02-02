<%@include file="/view/include/loginCheck.jsp"%>
<%@page contentType="text/html"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <title>Inscrição em evento</title>
    </head>
    <body style="background-color: #eeeeee;">
        <div class="container-fluid">
            <div class="container">
                <h2 class="text-primary">Pagamento da inscrição</h2>
                <p class="hr"></p>
            </div>
            <form class="form-horizontal" method="POST" action="${pageContext.servletContext.contextPath}/inscricao/update">
                <%--/ ///(id, idUsuario, idEdicao, valor_inscricao, conhecimento_evento, acompanhante  --%>
                <input type="hidden" name="idUsuario" value="${usuario.uid}" >
                <input type="hidden" name="idEdicao" value="${inscricao.idEdicao}" >
                <input type="hidden" name="valor_inscricao" value="${edicoes.preco}" >
                <input type="hidden" name="id" value="${inscricao.id}">
                                
                <!-- Valor inscricao -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Valor Inscrição:</label>
                    <div class="col-sm-4">
                        <p class="form-control-static"><strong>${inscricao.valor_inscricao}</strong></p>                        
                    </div>
                </div>
                
                <!-- Valor pago -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Valor Pago:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="valor_pago" placeholder="Valor pago com ou sem desconto" autofocus required>
                    </div>
                </div>    
                
                <!-- Desconto -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Desconto:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="desconto" placeholder="Desconto">
                    </div>
                </div>  
                    
                <!-- forma de pagamento -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Forma de Pagamento:</label>
                    <div class="col-sm-4">
                        <p class="form-control-static"><strong>${inscricao.formas_pagamento}</strong></p>
                        <br/>
                        <button class="btn btn-primary" type="submit">Confirmar</button>
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