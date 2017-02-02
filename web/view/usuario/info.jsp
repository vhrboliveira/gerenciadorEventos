<%@include file="/view/include/loginCheck.jsp"%>

<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" %> 

<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="java.math.BigInteger"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.awt.image.BufferedImage"%>


<c:if test="${ ((u.uid != usuarioLogado.uid) && (usuarioLogado.tipoUser == 3))|| ( (usuarioLogado.tipoUser == 2) && (u.tipoUser == 1)) }">
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
                    <title>Cadastro do Usuário</title>
                    </head>
                    <body>
                        <div class="container-fluid" style="background-color: #eeeeee;">
                            <div class="container">
                                <h2 class="text-primary">Cadastro do Usuário</h2>
                                <p class="hr"></p>
                            </div>
                            <form class="form-horizontal" name="formUsuario" method="POST" action="">                    
                                <input type="hidden" name="id" value="${u.uid}">
                                    
                                    <%
                                     
                                    //write image
                                    try{
                                        String imgName=(String) request.getAttribute("dir");
                                        BufferedImage bImage = ImageIO.read(new File(imgName));//give the path of an image
                                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                                        ImageIO.write( bImage, "jpg", baos );
                                        baos.flush();
                                        byte[] imageInByteArray = baos.toByteArray();
                                        baos.close();                                   
                                        String b64 = DatatypeConverter.printBase64Binary(imageInByteArray);
                                    %>
                                    <div class="text-center">
                                        
                                        <div class="col-sm-4">
                                            <img class="img-thumbnail" src="data:image/jpg;base64, <%=b64%>" width="200" height="200"/>                            
                                        </div>
                                    </div>
                                        <br><br><br><br><br><br><br><br>
                                    
                                    <% 
                                    }catch(IOException e){
                                        System.out.println("Error: "+e);
                                    }%>
                                    
                                        <!-- LOGIN -->
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Login:</label>
                                            <div class="col-sm-4">
                                                <input class="form-control" type="text" name="login" value="${u.login}" disabled>
                                            </div>
                                        </div>
                                        <%-- TIPO USER --%>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Tipo Usuário:</label>
                                            <div class="col-sm-4">
                                                <c:if test="${u.tipoUser == 3}">
                                                    <input class="form-control" type="text" name="tipoUser" value="Participante" disabled>
                                                    </c:if>
                                                    <c:if test="${u.tipoUser == 2}">
                                                        <input class="form-control" type="text" name="tipoUser" value="Membro" disabled>
                                                        </c:if>
                                                        <c:if test="${u.tipoUser == 1}">
                                                            <input class="form-control" type="text" name="tipoUser" value="Administrador" disabled>
                                                            </c:if>   
                                                            </div>
                                                            </div>        
                                                            <!-- NOME COMPLETO-->
                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">Nome:</label>
                                                                <div class="col-sm-4">
                                                                    <input class="form-control" type="text" name="nome" value="${u.nome}" disabled>
                                                                </div>
                                                            </div>
                                                            <!-- CPF -->
                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">CPF:</label>
                                                                <div class="col-sm-4">
                                                                    <input class="form-control" type="text" name="cpf" value="${u.cpf}" disabled>
                                                                </div>
                                                            </div>
                                                            <!-- RG -->
                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">RG:</label>
                                                                <div class="form-inline">
                                                                    <div class="col-sm-4">
                                                                        <input class="form-control" type="text" name="rg_num"  size="17" value="${u.rg_num}" disabled>
                                                                            <input class="form-control" type="text" name="rg_org"  size="18" value="${u.rg_org}" disabled>
                                                                                </div> 
                                                                                </div>
                                                                                </div>
                                                                                <!-- NOME CRACHA -->
                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">Cracha:</label>
                                                                                    <div class="col-sm-4">
                                                                                        <input class="form-control" type="text" name="nome_cracha" value="${u.nome_cracha}" disabled>
                                                                                    </div>
                                                                                </div>
                                                                                <!-- EMAIL -->
                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">Email:</label>
                                                                                    <div class="col-sm-4">
                                                                                        <input class="form-control" type="text" name="email" value="${u.email}" disabled>
                                                                                    </div>
                                                                                </div>
                                                                                <!-- CEP -->
                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">CEP:</label>
                                                                                    <div class="col-sm-4">
                                                                                        <input class="form-control" type="text" name="cep" value="${u.cep}" disabled>
                                                                                    </div>
                                                                                </div>
                                                                                <!-- ESTADO -->
                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">Estado:</label>
                                                                                    <div class="col-sm-4">
                                                                                        <input class="form-control" type="text" name="estado" value="${u.estado}" disabled>
                                                                                    </div>
                                                                                </div>
                                                                                <!-- CIDADE -->
                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">Cidade:</label>
                                                                                    <div class="col-sm-4">
                                                                                        <input class="form-control" type="text" name="cidade" value="${u.cidade}" disabled>
                                                                                    </div>
                                                                                </div>
                                                                                <!-- BAIRRO -->
                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">Bairro:</label>
                                                                                    <div class="col-sm-4">
                                                                                        <input class="form-control" type="text" name="bairro" value="${u.bairro}" disabled>
                                                                                    </div>
                                                                                </div>
                                                                                <!-- LOGRADOURO -->
                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">Logradouro:</label>
                                                                                    <div class="col-sm-4">
                                                                                        <input class="form-control" type="text" name="logradouro" value="${u.logradouro}" disabled>
                                                                                    </div>
                                                                                </div>
                                                                                <!-- COMPLEMENTO -->
                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">Complemento:</label>
                                                                                    <div class="col-sm-4">
                                                                                        <input class="form-control" type="text" name="complemento" value="${u.complemento}" disabled>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">Telefone:</label>
                                                                                    <div class="form-inline">
                                                                                        <div class="col-sm-4">
                                                                                            <c:if test="${u.tel_tipo == "residencial"}">
                                                                                                <input class="form-control" type="text" name="tel_tipo" size="12" value="residencial" disabled>
                                                                                                </c:if>
                                                                                                <c:if test="${u.tel_tipo == "celular"}">
                                                                                                    <input class="form-control" type="text" name="tel_tipo" size="12" value="celular" disabled>
                                                                                                    </c:if>
                                                                                                    <c:if test="${u.tel_tipo == "comercial"}">
                                                                                                        <input class="form-control" type="text" name="tel_tipo" size="12" value="comercial" disabled>
                                                                                                        </c:if>
                                                                                                        <c:if test="${u.tel_tipo == "recado"}">
                                                                                                            <input class="form-control" type="text" name="tel_tipo" size="12" value="recado" disabled>
                                                                                                            </c:if>
                                                                                                            <input class="form-control" type="text" name="tel_ddd" size="4" value="${u.tel_ddd}" disabled>
                                                                                                                <input class="form-control" type="text" name="tel_num" size="17" value="${u.tel_num}" disabled>
                                                                                                                    </div>
                                                                                                                    </div>
                                                                                                                    </div>
                                                                                                                    <!-- Sexo -->        
                                                                                                                    <div class="form-group">
                                                                                                                        <label class="col-sm-2 control-label">Sexo:</label>
                                                                                                                        <div class="form-inline">
                                                                                                                            <div class="col-sm-4">
                                                                                                                                <c:if test="${u.sexo == "feminino"}">
                                                                                                                                    <input class="form-control" type="text" name="sexo" value="feminino" disabled>
                                                                                                                                    </c:if>
                                                                                                                                    <c:if test="${u.sexo == "masculino"}">
                                                                                                                                        <input class="form-control" type="text" name="sexo" value="masculino" disabled>
                                                                                                                                        </c:if>
                                                                                                                                        <c:if test="${u.sexo == "outro"}">
                                                                                                                                            <input class="form-control" type="text" name="sexo" value="outro" disabled>
                                                                                                                                            </c:if>
                                                                                                                                            </div>
                                                                                                                                            </div>
                                                                                                                                            </div>                    
                                                                                                                                            <!-- DATA NASCIMENTO -->
                                                                                                                                            <div class="form-group">
                                                                                                                                                <label class="col-sm-2 control-label">Data de Nascimento:</label>
                                                                                                                                                <div class="col-sm-4">
                                                                                                                                                    <input class="form-control" type="text" name="data_nasc" value="${u.data_nasc}" disabled>
                                                                                                                                                </div>
                                                                                                                                            </div>
                                                                                                                                            <!-- ESTADO CIVIL -->
                                                                                                                                            <div class="form-group">
                                                                                                                                                <label class="col-sm-2 control-label">Estado Civil:</label>
                                                                                                                                                <div class="col-sm-4">
                                                                                                                                                    <input class="form-control" type="text" name="estado_civil" value="${u.estado_civil}" disabled>
                                                                                                                                                </div>
                                                                                                                                            </div>
                                                                                                                                            <!-- ESCOLARIDADE -->
                                                                                                                                            <div class="form-group">
                                                                                                                                                <label class="col-sm-2 control-label">Escolaridade:</label>
                                                                                                                                                <div class="col-sm-4">
                                                                                                                                                    <input class="form-control" type="text" name="escolaridade" value="${u.escolaridade}" disabled>                                
                                                                                                                                                </div>
                                                                                                                                            </div>
                                                                                                                                            <!-- PROFISSAO -->    
                                                                                                                                            <div class="form-group">
                                                                                                                                                <label class="col-sm-2 control-label">Profissão:</label>
                                                                                                                                                <div class="col-sm-4">
                                                                                                                                                    <input class="form-control" type="text" name="profissao" value="${u.profissao}" disabled>
                                                                                                                                                </div>
                                                                                                                                            </div>
                                                                                                                                            <!-- INSTITUICAO DE ORIGEM -->
                                                                                                                                            <div class="form-group">
                                                                                                                                                <label class="col-sm-2 control-label">Instituição de Origem:</label>
                                                                                                                                                <div class="col-sm-4">
                                                                                                                                                    <input class="form-control" type="text" name="instituicao_origem" value="${u.instituicao_origem}" disabled>
                                                                                                                                                        </br>
                                                                                                                                                        <a href="${pageContext.servletContext.contextPath}/usuario" class="btn btn-default" type="submit">Voltar</a>
                                                                                                                                                </div>
                                                                                                                                            </div>
                                                                                                                                            </form>
                                                                                                                                            </div>

                                                                                                                                            </body>
                                                                                                                                            <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
                                                                                                                                            <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
                                                                                                                                            <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
                                                                                                                                            </html>
