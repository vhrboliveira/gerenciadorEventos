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
                <h2 class="text-primary">Inscrição no evento:
                    <c:forEach var="e" items="${eventoList}">    
                        <c:if test="${e.id == edicoes.idEvento}">
                            <c:out value="${e.titulo}"/>
                        </c:if>        
                    </c:forEach> 
                    - <c:out value="${edicoes.nome}" />
                </h2>
                <p class="hr"></p>
            </div>
            <form class="form-horizontal" method="POST" action="${pageContext.servletContext.contextPath}/inscricao/create">
                <%--/ ///(id, idUsuario, idEdicao, valor_inscricao, conhecimento_evento, acompanhante  --%>
                <input type="hidden" name="idUsuario" value="${usuario.uid}" >
                <input type="hidden" name="idEdicao" value="${edicoes.id}" >
                <input type="hidden" name="valor_inscricao" value="${edicoes.preco}" >
                
                <!-- Nome Usuario -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Usuário:</label>
                    <div class="col-sm-4">
                        <%--<input class="form-control" type="text" value="${usuario.nome}" disabled> --%>
                        <p class="form-control-static"><strong>${usuario.nome}</strong></p>
                    </div>
                </div> 
                
                <!-- Valor inscricao -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Valor Inscrição:</label>
                    <div class="col-sm-4">
                        <%-- <input class="form-control" type="text" value="${edicoes.preco}" disabled> --%>
                        <p class="form-control-static"><strong>${edicoes.preco}</strong></p>                        
                    </div>
                </div>          
                    
                <!-- Como ficou sabendo do evento? -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Informações:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="conhecimento_evento" placeholder="Como ficou sabendo do evento?" value="${inscricao.conhecimento_evento}" required>
                    </div>
                </div>
                <!-- Acompanhante  -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Observação:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="acompanhante" placeholder="Participará do evento juntamente com outra pessoa?" value="${inscricao.acompanhante}" required>
                        <br/>
                        <button class="btn btn-primary" type="submit">Inscrever</button>
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