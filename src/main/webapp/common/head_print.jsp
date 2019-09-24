<%
if(session.getAttribute( "userName")==null){
	 response.sendRedirect("index.html");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>RTECH  Admin Panel</title>
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
    jQuery(".color").colorbox();        
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

<div class="mainwrapper">
    
 
    
    <div class="leftpanel">
        
         <ul class="nav nav-tabs nav-stacked">
         
            	<li class="nav-header"><a class="btn btn-primary  alertinfo"><small onclick="tableToExcel('exportCSV', 'export Table')">Export</small></a></li>
            	<li class="nav-header"><a href="client.jsp?cid=<%=request.getParameter("cid") %>" class="btn btn-primary  alertinfo"><small>Back to Client</small></a></li>
          </ul>

    </div><!-- leftpanel -->
    