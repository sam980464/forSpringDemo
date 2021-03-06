<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>

    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Report By Project</li>
        </ul>

<%
ArrayList<Project> itemPartList=null;
Iterator<Project> clientIt2;
Project clientItem;

String from= request.getParameter("from");
String to=request.getParameter("to");
int scheme_id=0;
if(from==null)from="";
if(to==null)to="";
%>
        <div class="maincontent">
            <div class="maincontentinner">
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Search</h4>
         <div class="widgetcontent">
          <form>
<table  class="tbl" width="100%" border="1">
<tr>
<td colspan="2"><span>For Project</span>
<div id="scheme_p" style="float:left;">
	<select style="width:233px;" name="project_id" id="project_id"
		class="uniformselect" required="required">
		<option value="0">Select Project</option>


		<%
try{
	
	itemPartList=new ProjectDAO().getProjectName();
	
	if(itemPartList != null){
		clientIt2 = itemPartList.iterator();
		while(clientIt2.hasNext()){
			clientItem = (Project)clientIt2.next();
%>								
<option value="<%=clientItem.getId()%>"><%=clientItem.getPro_name()+"/"+clientItem.getSite_addr()%></option>
<%
	}
}}
catch(Exception e){
	
	e.printStackTrace();
}
%>
		
	</select>
	<div id="scheme_child_div" style="float:right;">	
	</div>

</div></td>

<td><input type="submit" value="Search" class="alertdanger btn btn-danger alertdanger"></td>
 </tr>
 
</table>
</form>

<input type="submit" value="Export" class="alertdanger btn btn-danger alertdanger" onclick="tableToExcel('exportCSV', 'export Table')">
</div>     
           
    	</div><!--widgetcontent-->
</div>

<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Search Result</h4>
         <div class="widgetcontent">
            
 <table id="exportCSV" class="table table-bordered responsive">
	 <colgroup>
	    <col class="con0" style="align: center; width: 4%" />
	    <col class="con1" />
	    <col class="con0" />
		<col class="con1" />
	</colgroup>
	<thead>
            <tr>
             <th class="head0">Investor ID</th>
             <th class="head0">Investor Name</th>
             <th class="head1">Invested Amount</th>
             <th class="head1">Refunded Amount</th>
             <th class="head0">Refund Due</th>
             <th class="head0">Promised Refund</th>
             <th class="head0">Date</th>
          	</tr>
           </thead>
                           
<%
float sum=0,refund_sum=0,due_sum=0;
if(request.getParameter("project_id")!=null){
 ProjectDAO pdao=new ProjectDAO();
 ArrayList<ArrayList<String>> investmentdetails= pdao.getInvestmentList(request.getParameter("project_id"));
 for(int i=0;i<investmentdetails.size();i++){
 sum+=Float.parseFloat(investmentdetails.get(i).get(2));
 refund_sum+=Float.parseFloat(investmentdetails.get(i).get(3));
 due_sum+=Float.parseFloat(investmentdetails.get(i).get(4))-Float.parseFloat(investmentdetails.get(i).get(3));
 %>
                        <tr class="gradeX">
                         <td>
                           INV_00<%=investmentdetails.get(i).get(0) %>                      
                         </td>
                            <td>
                              <%=investmentdetails.get(i).get(1) %> 	
                            </td>
                            <td>
	                            <%=investmentdetails.get(i).get(2) %>
                            </td>
                            <td>
                              <%=investmentdetails.get(i).get(3) %>
                            </td>
                            <td>
                            <%=Float.parseFloat(investmentdetails.get(i).get(4))-Float.parseFloat(investmentdetails.get(i).get(3)) %>
                            </td>
                            <td>
                            <%=investmentdetails.get(i).get(4) %>
                            </td>
                            <td>
                            <%=investmentdetails.get(i).get(5) %>
                            </td>
                                                    </tr>
  <%
  }
  } %>
                        
                    </tbody>
                </table>
<div class="amountdue">
	<h1><span><b>Total Investment: <%=sum %></b></span><span><b>Total Refunded: <%=refund_sum %></b></span><span><b>Total Due: <%=due_sum %></b></span></h1><br />
</div>
<br>


<%@ include file="common/foot.jsp" %>

<script>

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