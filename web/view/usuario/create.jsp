<%@page contentType="text/html"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/cep.js">            
        </script>
        <title>Inserir Usuário</title>
    </head>
    <body>
        <div class="container-fluid" style="background-color: #eeeeee;">
            <div class="container">
                <h2 class="text-primary">Inserção de um novo usuário</h2>
                <p class="hr"></p>
            </div>
                    <form class="form-horizontal" method="POST" enctype="multipart/form-data" action="${pageContext.servletContext.contextPath}/usuario/create">                    
                        <input type="hidden" name="tipoUser" value="${u.tipoUser}">
                        <input type="hidden" name="idFace" value="${u.idFace}" >
                        <!-- FOTO -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Foto:</label>
                            <div class="col-sm-4">
                                <input type="file" name="file" accept="image/*" required="true"/> 
                            </div>
                        </div>
                        <!-- LOGIN -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Login:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="login" placeholder="Usuário" value="${u.login}" required autofocus>
                            </div>
                        </div>
                        <!-- SENHA -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Senha:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="password" name="senha" placeholder="Senha" value="${u.senha}" maxlength="20" required>
                            </div>
                        </div>   
                        <!-- NOME COMPLETO-->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Nome:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="nome" placeholder="Nome Completo" value="${u.nome}" required>
                            </div>
                        </div>
                        <!-- CPF -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">CPF:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="cpf" placeholder="CPF(opcional)" value="${u.cpf}">
                            </div>
                        </div>
                        <!-- RG style="margin-left: 7.3%; margin-bottom: 1%;" -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">RG:</label>
                            <div class="form-inline">
                                <div class="col-sm-4">
                                    <input class="form-control" type="text" name="rg_num" placeholder="Nº RG(opcional)" size="17" value="${u.rg_num}">
                                    <input class="form-control" type="text" name="rg_org" placeholder="Orgão Expedidor" size="18" value="${u.rg_org}">
                                </div> 
                            </div>
                        </div>
                        <!-- NOME CRACHA -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Cracha:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="nome_cracha" placeholder="Nome no cracha" value="${u.nome_cracha}" required>
                            </div>
                        </div>
                        <!-- EMAIL -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Email:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="email" placeholder="Email" value="${u.email}" required>
                            </div>
                        </div>
                        <!-- CEP -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">CEP:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="cep" id="cep" placeholder="CEP" value="${u.cep}" onblur="pesquisacep(this.value);" required>
                            </div>
                        </div>
                        <!-- ESTADO -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Estado:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="estado" id="uf" placeholder="Estado" value="${u.estado}" required>
                            </div>
                        </div>
                        <!-- CIDADE -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Cidade:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="cidade" id="cidade" placeholder="Cidade" value="${u.cidade}" required>
                            </div>
                        </div>
                        <!-- BAIRRO -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Bairro:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="bairro" id="bairro" placeholder="Bairro" value="${u.bairro}" required>
                            </div>
                        </div>
                        <!-- LOGRADOURO -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Logradouro:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="logradouro" id="rua" placeholder="Logradouro" value="${u.logradouro}" required>
                            </div>
                        </div>
                        <!-- COMPLEMENTO -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Complemento:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="complemento" placeholder="Complemento  (nº da casa ou apto)" value="${u.complemento}" required>
                            </div>
                        </div>
                        <!-- Telefone -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Telefone:</label>
                            <div class="form-inline">
                                <div class="col-sm-4">
                                    <select name="tel_tipo">
                                        <option value="residencial" selected>Residencial</option>
                                        <option value="celular">Celular</option>
                                        <option value="comercial">Comercial</option>
                                        <option value="recado">Recado</option>
                                    </select> 
                                    <input class="form-control" type="text" name="tel_ddd" placeholder="DDD" size="4" value="${u.tel_ddd}" required>
                                    <input class="form-control" type="text" name="tel_num" placeholder="Número" size="17" value="${u.tel_num}" required>
                                </div>
                            </div>
                        </div>
                        <!-- Sexo -->        
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Sexo:</label>
                            <div class="form-inline">
                                <div class="col-sm-4">
                                    <select name="sexo">
                                        <option value="feminino" ${u.sexo == "feminino" ? 'selected' : ''}>Feminino</option>
                                        <option value="masculino" ${u.sexo == "masculino" ? 'selected' : ''}>Masculino</option>
                                        <option value="outro" ${u.sexo == "outro" ? 'selected' : ''}>Outro</option>
                                    </select> 
                                </div>
                            </div>
                        </div>            
                        <!-- DATA NASCIMENTO -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Data de Nascimento:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="data_nasc" placeholder="Data de Nascimento (DD/MM/AAAA)" value="${u.data_nasc}" required>
                            </div>
                        </div>
                        <!-- ESTADO CIVIL -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Estado Civil:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="estado_civil" placeholder="Estado Civil" value="${u.estado_civil}" required>
                            </div>
                        </div>
                        <!-- ESCOLARIDADE -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Escolaridade:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="escolaridade" placeholder="Escolaridade" value="${u.escolaridade}" required>                                
                            </div>
                        </div>
                        <!-- PROFISSAO -->    
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Profissão:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="profissao" placeholder="Profissão" value="${u.profissao}" required>
                            </div>
                        </div>
                        <!-- INSTITUICAO DE ORIGEM -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Instituição de Origem:</label>
                            <div class="col-sm-4">
                                <input class="form-control" type="text" name="instituicao_origem" placeholder="Instituição de Origem" value="${u.instituicao_origem}" required>
                                </br>
                                <button class="btn btn-primary" type="submit">Inserir</button>
                                <a href="${pageContext.servletContext.contextPath}/usuario" class="btn btn-default" type="submit">Cancelar</a>
                                
                            </div>
                        </div>
                            
                    </form>
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>