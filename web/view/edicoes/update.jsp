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
        <title>Editar Edições</title>
    </head>
    <body style="background-color: #eeeeee;">
        <div class="container-fluid">
            <div class="container">
                <h2 class="text-primary">Editar edição do evento: 
                    <c:forEach var="e" items="${eventoList}">    
                        <c:if test="${e.id == edicoes.idEvento}">
                            <c:out value="${e.titulo}"/>
                        </c:if>        
                    </c:forEach>  
                </h2>
                <p class="hr"></p>
            </div>
            <form class="form-horizontal" method="POST" action="${pageContext.servletContext.contextPath}/edicoes/update">
                <%--//   (id, idlocal, nomelocal, idevento, preco) --%>
                <input type="hidden" name="id" value="${edicoes.id}">
                <input type="hidden" name="idEvento" value="${edicoes.idEvento}">
                <!-- Nome -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Nome:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="nome" placeholder="Nome edição" value="${edicoes.nome}" required autofocus>
                    </div>
                </div>
                <!-- Local -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Local:</label>
                    <div class="col-sm-4">
                        <select name="nomeLocal">
                            <c:forEach var="l" items="${localEdList}">
                                <option value="${l.nome}" ${l.nome == edicoes.nomeLocal ? 'selected' : ''} ><c:out value="${l.nome}"/></option>                                                            
                            </c:forEach>    
                        </select> 
                    </div>
                </div>                
                <!-- Data Inicio -->
                <!-- <div class="form-group">
                    <label class="col-sm-2 control-label">Data:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="dataInicio" placeholder="Data" value="${edicoes.dataInicio}" required>
                    </div>
                </div> -->
                
                <!-- Preco -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Preço:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="preco" placeholder="Preço" value="${edicoes.preco}" required>
                    </div>
                </div>
                    
                <!-- formas de pagamento-->  
                <div class="form-group">
                    <label class="col-sm-2 control-label">Forma de Pagamento:</label>
                    <div class="col-sm-4">
                        <select name="idformas_pagamento">
                            <c:forEach var="formas" items="${formasPagamentoList}">
                                <option value="${formas.id}" ${formas.id == edicoes.idFormas_Pagamento ? 'selected' : ''} ><c:out value="${formas.formas_pagamento}"/></option>
                            </c:forEach>
                        </select>
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