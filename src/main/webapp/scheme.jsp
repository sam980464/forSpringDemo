<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Scheme List</li>
        </ul>

<script type="text/javascript">
    jQuery(document).ready(function(){
        // dynamic table
        jQuery('#dyntable').dataTable({
            "sPaginationType": "full_numbers",
            "aaSortingFixed": [[0,'asc']],
            "fnDrawCallback": function(oSettings) {
                jQuery.uniform.update();
            }
        });
        
        jQuery('#dyntable2').dataTable( {
            "bScrollInfinite": true,
            "bScrollCollapse": true,
            "sScrollY": "300px"
        });
        
    });
</script>        
  <div class="maincontent">
      <div class="maincontentinner">
<div class="widget" id="client_not_selected">
		 <%
				if (session.getAttribute("message")!=null){
				%>
				<div class="alert alert-info" style="background-color:yellow">
				<%=session.getAttribute("message") %>
				<% session.setAttribute("message",null); %>
				</div>
				<% } %> 
         <h4 class="widgettitle">Choose Scheme To Go Dashboard</h4>
         <div class="widgetcontent">
             <form class="stdform" action="scheme_dashboard.jsp" method="get">
        
<p id="scheme_p">
<select style="width:200px;" name="scheme_parent_id" id="scheme_parent_id" class="uniformselect" required="required" onchange="getChildList(this)">
<option value="">Select Parent Scheme</option>
<%
	ArrayList<SchemeBO> schemeList = null;
	Iterator<SchemeBO> schemeIt;
	SchemeBO schemeBO;
	try {
		Scheme scheme = new Scheme();
		schemeList = scheme.getAllParentItem();

		if (schemeList != null) {
			schemeIt = schemeList.iterator();
			while (schemeIt.hasNext()) {
				schemeBO = (SchemeBO) schemeIt.next();
%>

<option value="<%=schemeBO.getId()%>"><%=schemeBO.getSchemeName()%></option>


<%
	}
		}
	} catch (Exception e) {

		e.printStackTrace();
	}
%>


</select>

<div id="scheme_child_div">
								
</div>



&nbsp;
</p>   
<input type="submit" class="btn btn-primary" value="Go To Scheme Dashboard" >


<a href="add_scheme.jsp" class="dropdown-toggle color cboxElement">
<input type="submit" class="btn btn-primary" value="New Scheme" >
</a>
                    
 
    </form>
</div><!--widgetcontent-->
</div>



<script>
document.getElementById("pp").style.display="none";
function editMe()
{
	document.getElementById("pp").style.display="block";
}


function getChildList(){
	
	//alert(document.getElementById("scheme_id").value);
	var scheme_id= document.getElementById("scheme_parent_id").value;
	//alert(scheme_id);
	 var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    document.getElementById("scheme_child_div").innerHTML=xmlhttp.responseText;
	   
	    }
	  }
	xmlhttp.open("GET","ActionServlet?todo=getChildScheme&parent="+scheme_id+"&selectedchild=0",true);
	xmlhttp.send(); 
}

</script>


      

  <%@ include file="common/foot.jsp" %>