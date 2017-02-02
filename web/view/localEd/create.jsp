<%@page contentType="text/html"%>

<c:if test="${((usuarioLogado.tipoUser == 3) && (u.uid != usuarioLogado.uid)) || ( (usuarioLogado.tipoUser == 2) && (u.tipoUser == 1))}">
    <c:redirect context="${pageContext.servletContext.contextPath}" url="/welcome.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/cep.js">
        </script>
        <title>Inserir Local</title>
    </head>
    <body style="background-color: #eeeeee;">
        <div class="container-fluid">
            <div class="container">
                <h2 class="text-primary">Inserção de um novo local</h2>
                <p class="hr"></p>
            </div>
            <form class="form-horizontal" method="POST" action="${pageContext.servletContext.contextPath}/local/create">                    
                <!-- Nome -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Nome:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="nome" placeholder="Nome" value="${l.nome}" required autofocus>
                    </div>
                </div>
                
                <!-- CEP -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">CEP:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="cep" id="cep" placeholder="CEP" value="${l.cep}" onblur="pesquisacep(this.value);" required>
                    </div>
                </div>
                <!-- ESTADO -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Estado:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="estado" id="uf" placeholder="Estado" value="${l.estado}" required>
                    </div>
                </div>
                <!-- CIDADE -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Cidade:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="cidade" id="cidade" placeholder="Cidade" value="${l.cidade}" required>
                    </div>
                </div>
                <!-- BAIRRO -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Bairro:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="bairro" id="bairro" placeholder="Bairro" value="${l.bairro}" required>
                    </div>
                </div>
                <!-- LOGRADOURO -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Logradouro:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="logradouro" id="rua" placeholder="Logradouro" value="${l.logradouro}" required>
                    </div>
                </div>
                <!-- COMPLEMENTO -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Complemento:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="complemento" placeholder="Complemento  (nº da casa ou apto)" value="${l.complemento}" required>
                    </div>
                </div>
                <!-- Telefone -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Telefone:</label>
                    <div class="form-inline">
                        <div class="col-sm-4">
                            <select name="tel_tipo">
                                <option value="nenhum" selected>Nenhum</option>
                                <option value="residencial">Residencial</option>
                                <option value="celular">Celular</option>
                                <option value="comercial">Comercial</option>
                                <option value="recado">Recado</option>                                
                            </select> 
                            <input class="form-control" type="text" name="tel_ddd" placeholder="DDD" size="4" value="${l.tel_ddd}" >
                            <input class="form-control" type="text" name="tel_num" placeholder="Número" size="17" value="${l.tel_num}">
                        </div>
                    </div>
                </div>
                
                <!-- Latitude -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Latitude:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="latitude" placeholder="Latitude (opcional)" value="${l.latitude}">
                    </div>
                </div>        
                        
                <!-- Longitude -->
                <div class="form-group">
                    <label class="col-sm-2 control-label">Longitude:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="longitude" placeholder="Longitude (opcional)" value="${l.longitude}">
                        </br>
                        <button class="btn btn-primary" type="submit">Inserir</button>
                        <a href="${pageContext.servletContext.contextPath}/local" class="btn btn-default" type="submit">Cancelar</a>
                    </div>
                </div>
            </form>
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>