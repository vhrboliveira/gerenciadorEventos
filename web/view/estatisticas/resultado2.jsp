<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/view/include/loginCheck.jsp"%>
<%@page import="java.util.List"%>
<%@page import="model.FormasPagamento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${(usuarioLogado.tipoUser == 3) }">
    <c:redirect context="${pageContext.servletContext.contextPath}" url="/welcome.jsp"/>
</c:if>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css"> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
        <title>Evento</title>
    </head>
    <body style="background-color: #eeeeee;">

        <div class="container">
            <h3 class="text-primary">Estatsíticas Vários Eventos </h3>
            <div class="table-responsive">          
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Número de participantes</th>
                        <th>Ações</th>
                    </tr>
                    
                </thead> 
                <tbody>
                
                    <tr>                        
                        <td>Total: </td><td><a class="btn btn-success" href="${pageContext.servletContext.contextPath}/estatisticastotal/resposta?tipo=0">Exibir</a></td>
                    </tr>
                    <tr>
                        <td>Masculino:</td><td> <a class="btn btn-success" href="${pageContext.servletContext.contextPath}/estatisticastotal/resposta?tipo=1">Exibir</a></td>
                    </tr>
                    <tr>
                        <td>Feminino:</td><td> <a class="btn btn-success" href="${pageContext.servletContext.contextPath}/estatisticastotal/resposta?tipo=2">Exibir</a></td>
                    </tr>
                    <tr>
                        <td>Outro:</td><td> <a class="btn btn-success" href="${pageContext.servletContext.contextPath}/estatisticastotal/resposta?tipo=3">Exibir</a></td>
                    </tr>
                    <tr>
                        <td>Instituição de origem:</td>
                        <td>
                            <form class="form-horizontal" method="GET" action="${pageContext.servletContext.contextPath}/estatisticastotal/resposta">
                                <input type="text" name="inst_origem" required>
                                <input type="hidden" name="tipo" value="4" >
                                <button class="btn btn-success" type="submit">Exibir</button>
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td>Faixa etária:</td>
                        <td>
                            <form class="form-horizontal" method="GET" action="${pageContext.servletContext.contextPath}/estatisticastotal/resposta">
                                <input type="radio" name="faixa" value="1"> Até 10 Anos  
                                <input type="radio" name="faixa" value="2"> 10-20 Anos  
                                <input type="radio" name="faixa" value="3"> 20-30 Anos  
                                <input type="radio" name="faixa" value="4"> Mais de 30 Anos<br>
                                <input type="hidden" name="tipo" value="5" >
                                <button class="btn btn-success" type="submit">Exibir</button>
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td>Faixa etária + Sexo:</td>
                        <td>
                            <form class="form-horizontal" method="GET" action="${pageContext.servletContext.contextPath}/estatisticastotal/resposta">
                                <input type="hidden" name="tipo" value="6" >
                                Sexo:  
                                <input type="radio" name="sexo" value="masculino">Masculino        
                                <input type="radio" name="sexo" value="feminino">Feminino                
                                    <input type="radio" name="sexo" value="oturo">Outro <br>            
                                        <!-- -----------------------------<br>    -->
                                Faixa etária:             
                                <input type="radio" name="faixa" value="1"> Até 10 Anos 
                                <input type="radio" name="faixa" value="2"> 10-20 Anos 
                                <input type="radio" name="faixa" value="3"> 20-30 Anos 
                                <input type="radio" name="faixa" value="4"> Mais de 30 Anos
                                    <br>       
                                <button class="btn btn-success" type="submit">Exibir</button>
                            </form>
                        </td>
                    </tr>            
                </tbody>
            </table>
            </div>
            <a class="btn btn-default " href="${pageContext.servletContext.contextPath}/evento">Voltar</a>
            <br>
               
            
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/npm.js"></script>
</html>
