<%-- 
    Document   : Welcome
    Created on : 07.12.2015, 12:42:46
    Author     : Sergey
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
              <div class="navbar-header">
                <a class="navbar-brand" href="#">
                  <img alt="MyServ" src="...">
                </a>
              </div>
            </div>
        </nav>
        
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <h1>My Servlet</h1>  
            </div>
            <div class="col-md-2"></div>
        </div>
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Первая</th>
                                    <th>Вторая</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                                <%Iterator itr;%>
                                <% List data= (List)request.getAttribute("data");
                                    for (itr=data.iterator(); itr.hasNext(); ) {
                                %>
                                    <tr>
                                        <td><a class="sender" href="#" data-toggle="modal" data-target="#myModal"><%=itr.next()%></a></td>
                                        <td><%=itr.next()%></td>
                                    </tr>
                                <%}%>
                            </tbody> 
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-2"></div>
        </div>
        
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Сообщение</h4>
              </div>
              <div class="modal-body">
                  <h2>Спасибо!</h2>
                  <div class="progress">
                    <div id="prog" class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                      <span class="sr-only">45% Complete</span>
                    </div>
                  </div>
                  <h4 id="label"></h4>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default closer" data-dismiss="modal" >Close</button>
              </div>
            </div>
          </div>
        </div>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script>
            $('.sender').on('click', function(event) {
                var loc = window.location.host + window.location.pathname;
                $("#label").html("Sending email...");
                $.get( "http://"+loc+"?action=mail",function(data) {
                    var obj = jQuery.parseJSON(data);
                    if (obj.status === 'OK') {
                        $( "#prog" ).removeClass( "progress-bar progress-bar-striped active" ).addClass( "progress-bar progress-bar-success" );
                        $("#label").html(obj.text);
                    } else {
                        $( "#prog" ).removeClass( "progress-bar progress-bar-striped active" ).addClass( "progress-bar progress-bar-danger" );
                        $("#label").html(obj.text);
                    }
                });
            });                      
            $('.closer').on('click', function(event) {
                $( "#prog" ).removeClass("progress-bar progress-bar-success").addClass("progress-bar progress-bar-striped active");
            });
        </script>
    </body>
</html>
