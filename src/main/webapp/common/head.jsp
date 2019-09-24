<%
if(session.getAttribute( "userName")==null){
	 response.sendRedirect("index.html");
}
%>
<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Home Construction Portal  Admin Panel</title>
<link rel="stylesheet" href="resources/css/style.default.css" type="text/css" />
<link rel="stylesheet" href="resources/css/bootstrap-fileupload.min.css" type="text/css" />
<link rel="stylesheet" href="resources/css/bootstrap-timepicker.min.css" type="text/css" />
<link rel="stylesheet" href="resources/css/responsive-tables.css">

<script type="text/javascript" src="resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="resources/js/modernizr.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.cookie.js"></script>
<script type="text/javascript" src="resources/js/bootstrap-fileupload.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.tagsinput.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.autogrow-textarea.js"></script>
<script type="text/javascript" src="resources/js/charCount.js"></script>
<script type="text/javascript" src="resources/js/colorpicker.js"></script>
<script type="text/javascript" src="resources/js/ui.spinner.min.js"></script>
<script type="text/javascript" src="resources/js/chosen.jquery.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.uniform.min.js"></script>
<script type="text/javascript" src="resources/js/flot/jquery.flot.min.js"></script>
<script type="text/javascript" src="resources/js/flot/jquery.flot.resize.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/js/responsive-tables.js"></script>
<script type="text/javascript" src="resources/js/custom.js"></script>
<script type="text/javascript" src="resources/js/modernizr.min.js"></script>
<script type="text/javascript" src="resources/js/forms.js"></script>
<script type="text/javascript" src="resources/js/jquery.colorbox-min.js"></script>


<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="resources/js/excanvas.min.js"></script><![endif]-->



<script type="text/javascript">

jQuery(document).ready(function(){
	jQuery('.accordion').accordion({heightStyle: "content"});
   jQuery(".color").colorbox();
//   jQuery(".datepicker,.hasDatepicker").datepicker({dateFormat: "yy-mm-dd"});
   
});

</script>

<script type='text/javascript'>

var tableToExcel = (function() {
	  var uri = 'data:application/vnd.ms-excel;base64,'
	    , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
	    , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
	    , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
	  return function(table, name) {
	    if (!table.nodeType) table = document.getElementById(table)
	    var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
	    window.location.href = uri + base64(format(template, ctx))
	  }
	})()

</script>

</head>

<body>

<div class="mainwrapper" style="background-color:darkslategray">
    
    <div class="header">
        <div class="logo">
            <a href="dashboard.jsp"><img src="resources/images/logo1.png" alt=""  style="width: 200px; height: 99px;"/></a>
        </div>
        <div class="headerinner">
            <ul class="headmenu">
               
               <li class="dropdown-toggle"> 
                    <a href="dashboard.jsp" class="dropdown-toggle" >
                    <span class="head-icon head-bar"></span>
                    <span class="headmenu-label">Dashboard</span>
                    </a>
                </li>
                <li>
                    <a class="dropdown-toggle color" href="add_client.jsp">
                    <span class="head-icon head-users"></span>
                    <span class="headmenu-label">New Client</span>
                    </a>
                </li>
                <li>
                    <a class="dropdown-toggle color" href="switch_client.jsp">
                    <span class="head-icon head-users"></span>
                    <span class="headmenu-label">Switch Client</span>
                    </a>
                </li>
                
                <li>
                    <a class="dropdown-toggle color" href="add_scheme.jsp">
                    <span class="head-icon head-message"></span>
                    <span class="headmenu-label">New Scheme</span>
                    </a>
                </li>
                 
                <li>
                    <a class="dropdown-toggle color" href="add_project.jsp">
                    <span class="head-icon head-message"></span>
                    <span class="headmenu-label">New Project</span>
                    </a>
                </li>  
<!--                 <li class="odd"> -->
<!--                     <a class="dropdown-toggle" data-toggle="dropdown" href="#"> -->
<!--                         <span class="head-icon head-message"></span> -->
<!--                         <span class="headmenu-label">Payment Alert</span> -->
<!--                     </a> -->
<!--                 </li> -->
                
<!--                 <li class="odd"> -->
<!--                     <a class="dropdown-toggle" data-toggle="dropdown" data-target="#"> -->
<!--                     <span class="head-icon head-bar"></span> -->
<!--                     <span class="headmenu-label">Payment Statistics</span> -->
<!--                     </a> -->
<!--                 </li> -->

				<li class="odd">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                    <span class="count">10</span>
                    <span class="head-icon head-exp"></span>
                    <span class="headmenu-label">Latest Expenses</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="nav-header">Clients</li>
                        
<%
ArrayList<ClientBO> clientList=null;
Iterator<ClientBO> clientIt;
ClientBO clientBO;
try{
	Client client= new Client();
	clientList=client.getAllLatestItem(10);
	
	if(clientList != null){
		clientIt = clientList.iterator();
		while(clientIt.hasNext()){
			clientBO = (ClientBO)clientIt.next();
%>                        
                        <li><a href="client.jsp?cid=<%=clientBO.getId() %>"><span class="icon-align-left"></span><%=client.getClientNameById(clientBO.getId()) %> <strong>Date</strong> <small class="muted"><%=clientBO.getDateCreated() %></small>   (Rs. <%=clientBO.getTotal_amount() %>)</a></li>
                        
<%
	}
}}
catch(Exception e){
	
	e.printStackTrace();
}
%>                        
                    </ul>
                </li>
                
                <li class="right">
                    <div class="userloggedinfo">
                        <img src="resources/images/photos/thumb1.png" alt="" />
                        <div class="userinfo">
                            <h5 style="color:black"><%=session.getAttribute("userName") %><small style="color:black">- test@gmail.com</small></h5>
                            <ul>
                                <li><a href="" style="color:black">Edit Profile</a></li>
                               <!--  <li><a href="">Account Lock</a></li> -->
                                <li><a href="ActionServlet?todo=logout" style="color:black">Sign Out</a></li>
                            </ul>
                        </div>
                    </div>
                </li>
            </ul><!--headmenu-->
        </div>
    </div>
    
    <div class="leftpanel">
        
          <%@ include file="menu.jsp" %>
        
    </div><!-- leftpanel -->
 