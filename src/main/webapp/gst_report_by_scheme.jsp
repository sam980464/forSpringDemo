<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>

    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>GST Report</li>
        </ul>

<%
String from= request.getParameter("from");
String to=request.getParameter("to");
int scheme_id=0;
if(from==null)from="";
if(to==null)to="";


if(request.getParameter("scheme_child_id")==null){
	if(request.getParameter("scheme_parent_id")!=null)
		{
		scheme_id=Integer.parseInt(request.getParameter("scheme_parent_id"));
		}
	else
		{
		scheme_id=0;		
		}
}
else{
	scheme_id=Integer.parseInt(request.getParameter("scheme_child_id"));
	
}

%>
        <div class="maincontent">
            <div class="maincontentinner">
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Search</h4>
         <div class="widgetcontent">
          <form>
<table  class="tbl" width="100%" border="1">
<tr>
<td colspan="2"><span>For Scheme</span>
<div id="scheme_p" style="float:left;">
	<select style="width:233px;" name="scheme_parent_id" id="scheme_parent_id"
		class="uniformselect" required="required" onchange="getChildList(this)">
		<option value="0">Select Parent Scheme</option>


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
	<div id="scheme_child_div" style="float:right;">
	
	</div>

</div></td>
<td>
	<span>From Date</span>
	<div>
	<input id="datepicker1" type="text" name="from" class="input-small datepicker" value="<%=from %>" />
	</div>	
</td>
<td>
	<span>To Date</span>
	<div>
	<input id="datepicker2" type="text" name="to" class="input-small datepicker" value="<%=to %>" />
	</div>
</td>



<td><input type="submit" value="Search" class="alertdanger btn btn-danger alertdanger"></td>
 </tr>
 
</table>
</form>

<!-- <input type="submit" value="Export" class="alertdanger btn btn-danger alertdanger" onclick="tableToExcel('exportCSV', 'export Table')"> -->
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
              	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
              	<th class="head0">No.</th>
              	<th class="head1">Client Name</th>
              	<th class="head0">Scheme Name</th>
              	<th class="head1">GST %</th>
              	<th class="head0">Amount Received</th>
              	<th class="head1">GST Amount</th>
              	<th class="head0">Amount Received Date</th>              	
          	</tr>
           </thead>
                           
 <%

ArrayList<PaymentBO> payment_List=null;
Iterator<PaymentBO> payment_It;
PaymentBO payment_BO;
int  client_id;
int i=1;
double total_gst=0.0;
try{
	Client client= new Client();
	client.setFromDate(from);
	client.setToDateExp(to);
	
	client.setScheme_id(scheme_id);
	payment_List=client.getAllItemForGSTReport();
	
	
	if(payment_List != null){
		payment_It = payment_List.iterator();
		while(payment_It.hasNext()){
			payment_BO = (PaymentBO)payment_It.next();
			
			
			
%>	
    	<tr>
    		<td class="aligncenter"><span class="center"><input type="checkbox" /></span></td>
    		<td><%=i %></td>
    		
    		<td><%=payment_BO.getClientName() %></td>
    		
    		<td>    		
    		<%=payment_BO.getSchemeName()%>
    		</td>		
    		<td>
    		<%=payment_BO.getGstPercentage()%>
    		</td>
    		<td>
    		<%=payment_BO.getAmountReceived()%>
    		</td>
    		<%
    		total_gst=total_gst+payment_BO.getGstAmount();
    		%>
    		<td>
    		
    		<%=payment_BO.getGstAmount()%>
    		
    		
    		</td>	
    		<td>
    		
    		<%=payment_BO.getDateReceived()%>
    		</td>
    			
    	</tr>
				    							
<%
i++;
	}
}}
catch(Exception e){
	
	e.printStackTrace();
}
%>                     
</table>
    	</div><!--widgetcontent-->
</div>


<div class="amountdue">
	<h1><span><b>Total GST: </b> <%=String.format("%.2f", total_gst)%> </span></h1> <br />
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

