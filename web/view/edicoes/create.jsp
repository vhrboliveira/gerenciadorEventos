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
        <!-- JQUERY -->
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script src="${pageContext.request.contextPath}/resources/accordionScript.js"></script>
        <script src="${pageContext.request.contextPath}/resources/disablePeriodoScript.js"></script>
        <!-- JQUERY -->
        
        <title>Inserir Edições</title>
    </head>
    <body style="background-color: #eeeeee;">
        <div class="container-fluid">
            <div class="container">
                <h2 class="text-primary">Inserção de edição para o evento: <c:out value="${evento.titulo}"/></h2>
                <p class="hr"></p>
            </div>
            <form class="form-horizontal" method="POST" action="${pageContext.servletContext.contextPath}/edicoes/create">
                <%--//   (id, idlocal, nomelocal, idevento, preco) --%>
                <input type="hidden" name="idEvento" value="${evento.id}">
                <!-- Nome -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Nome:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="nome" placeholder="Nome edição" value="${edicoes.nome}" required autofocus>
                    </div>
                </div>
                
                <!-- Preco -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Preço:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="preco" placeholder="Preço" value="${edicoes.preco}" required>
                    </div>
                </div>    
                    
                <!-- Local -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Local:</label>
                    <div class="col-sm-4">
                    <%-- IdLocal está vindo do controller --%>
                    <select name="nomeLocal">
                        <c:forEach var="l" items="${localEdList}">
                            <option value="${l.nome}"><c:out value="${l.nome}"/></option>                                                            
                        </c:forEach>    
                    </select> 
                        
                    </div>
                </div>
                
                <%-- <!-- Data Inicio -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Data:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="dataInicio" placeholder="Data" value="${edicoes.dataInicio}" required>
                    </div>
                </div>--%>
                    
                <!-- formas de pagamento-->  
                <div class="form-group">
                    <label class="col-sm-2 control-label">Forma de Pagamento:</label>
                    <div class="col-sm-4">
                        <select name="idformas_pagamento">
                            <c:forEach var="formas" items="${formasPagamentoList}">
                                <option value="${formas.id}" ><c:out value="${formas.formas_pagamento}"/></option>
                            </c:forEach>
                        </select>                        
                    </div>
                </div>
                    
                <!-- PERIDO -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Período:</label>
                    <div class="col-sm-4">
                        <div id="accordion">
                            <h3 id="enable-unico">Único</h3>
                            <div id="unico">
                                <input type="hidden" name="tipo" value="0" >
                                <p>Data de Inicio:</p>
                                <input class="form-control" type="text" name="dataInicio" id="dataInicioU" placeholder="Data de Incio">                                  
                                <br/><p>Hora de Inicio:</p>
                                <input class="form-control" type="text" name="horaInicio" id="horaInicioU" placeholder="Hora de Incio">                                  
                                <br/><p>Hora de Termino:</p>
                                <input class="form-control" type="text" name="horaTermino" id="horaTerminoU" placeholder="Hora de Termino">                                  
                            </div>
                            <!--<h3 id="enable-multiplo">Múltiplo</h3>
                            <div id="multiplo">
                                <p></p>
                            </div>-->
                            <h3 id="enable-periodico">Periódico</h3>
                            <div id="periodico">
                                <input type="hidden" name="tipo" value="2" disabled>
                                <p>Data de Inicio:</p>
                                <input class="form-control" type="text" name="dataInicio" placeholder="Data de Incio" disabled>                                  
                                <br/><p>Data de Termino:</p>
                                <input class="form-control" type="text" name="dataTermino" placeholder="Data de Termino" disabled>                                  
                                <br/><p>Hora de Inicio:</p>
                                <input class="form-control" type="text" name="horaInicio" placeholder="Hora de Incio" disabled>                                  
                                <br/><p>Hora de Termino:</p>
                                <input class="form-control" type="text" name="horaTermino" placeholder="Hora de Termino" disabled>                                  
                                <br/><p>Dias da Semana:</p>
                                <ul>
                                    <li><input type="checkbox" name="dias" value="Segunda-feira" disabled>Segunda-feira</li>
                                    <li><input type="checkbox" name="dias" value="Terça-feira" disabled>Terça-feira</li>
                                    <li><input type="checkbox" name="dias" value="Quarta-feira" disabled>Quarta-feira</li>
                                    <li><input type="checkbox" name="dias" value="Quinta-feira" disabled>Quinta-feira</li>
                                    <li><input type="checkbox" name="dias" value="Sexta-feira" disabled>Sexta-feira</li>
                                    <li><input type="checkbox" name="dias" value="Sábado" disabled>Sábado</li>
                                    <li><input type="checkbox" name="dias" value="Domingo" disabled>Domingo</li>
                                </ul>
                            </div>
                        </div> 
                        <br/>
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