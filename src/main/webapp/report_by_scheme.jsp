<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>

    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Report By Client</li>
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
              	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
              	<th class="head0">No.</th>
              	<th class="head1">Client Name</th>
              	<th class="head0">Total Estimated Amount</th>
              	<th class="head1">Payment Received</th>
              	<th class="head0">Amount Unpaid</th>
              	<th class="head1">Total Expenses</th>
              	<th class="head0">Expenses Paid</th>
              	<th class="head0">Expenses UnPaid</th>
              	<th class="head1">Amount in hand</th>
          	</tr>
           </thead>
                           
<%

ArrayList<ClientBO> client_List=null;
Iterator<ClientBO> client_It;
ClientBO client_BO;
int  client_id;
int i=1;
double total_estimate=0.0;
double total_expence_unpaid=0.0;
double total_received=0.0;
double total_expence=0.0;
double total_expence_paid=0.0;
double total_in_hand=0.0;
try{
	Client client= new Client();
	client.setFromDate(from);
	client.setToDateExp(to);
	
	client.setScheme_id(scheme_id);
	client_List=client.getAllItemForReport();
	
	
	if(client_List != null){
		client_It = client_List.iterator();
		while(client_It.hasNext()){
			client_BO = (ClientBO)client_It.next();
			
			
			
%>	
    	<tr>
    		<td class="aligncenter"><span class="center"><input type="checkbox" /></span></td>
    		<td><%=i %></td>
    		<td><a  class="dropdown-toggle color" href="client_report_pop.jsp?cid=<%=client_BO.getId() %>"><%=client_BO.getClientName() %></td>
    		<td>
    		<%
    		double estimate_amount=0.0;
    		double payment_received=0.0;
    		double total_exp=0.0;
    		double actual_exp=0.0;
    		
    		Estimate estimate= new Estimate();
    		
    		if(scheme_id==0){
    		estimate_amount=estimate.getTotalEstimateByClientId(client_BO.getId());
    		total_estimate=total_estimate+estimate.getTotalEstimateByClientId(client_BO.getId());	
    		}
    		else{
    			estimate_amount=estimate.getTotalEstimateByClientId(client_BO.getId(),scheme_id);
    			total_estimate=total_estimate+estimate.getTotalEstimateByClientId(client_BO.getId(),scheme_id);
    			
    		}
    		
    		%>
    		<%=String.format("%.2f",estimate_amount)%>
    		</td>		
    		<td>
    		<%
    		if(scheme_id==0){ 
    		payment_received=client.getTotalPaidCid(client_BO.getId());
    		} else{ 
    		payment_received= client.getTotalPaidCid(client_BO.getId(),scheme_id);
    		} 
    		total_received = total_received+payment_received;
    		%>
    		
    		<%=String.format("%.2f", payment_received)%>
    		</td>
    		
    		<td><%-- <%=String.format("%.2f",client.getTotalDueCid(client_BO.getId()) )%> --%>
    		<%=String.format("%.2f",estimate_amount-payment_received )%>
    		</td>	
    		<td>
    		<%-- <%=String.format("%.2f",client.getTotalExpByCid(client_BO.getId()) )%> --%>
    		<%
    		if(scheme_id==0){ 
    		total_exp=client.getTotalExpByCid(client_BO.getId());
    		} else{ 
    			total_exp=client.getTotalExpByCid(client_BO.getId(),scheme_id);
    		} 
    		
    		%>
    		<%=String.format("%.2f", total_exp)%>
    		<%
    		  total_expence = total_expence +total_exp;
    		%>
    		
    		</td>	
    		<td>
    		<%-- <%=String.format("%.2f", client.getTotalExpPaidByCid(client_BO.getId()))%> --%>
    		<%
    		if(scheme_id==0){ 
    			actual_exp=client.getTotalExpPaidByCid(client_BO.getId());
        		} else{ 
        			actual_exp=client.getTotalExpPaidByCid(client_BO.getId(),scheme_id);
        		} 
    		//total_expence_paid = total_expence_paid + actual_exp;
    		%>
    		<%=String.format("%.2f", actual_exp)%>
    		</td>
    		<td>
    		<%
    		total_expence_paid = total_expence_paid + actual_exp;
    		double exp_unpaid = total_exp-actual_exp;
    		total_expence_unpaid = total_expence_unpaid + exp_unpaid;
    		%>
    		<%=String.format("%.2f", exp_unpaid)%>
    		</td>
    		<td>
    		<% total_in_hand = total_in_hand + (payment_received-actual_exp) ;%>
    		<%-- <%=String.format("%.2f", client.getTotalPaidCid(client_BO.getId())-client.getTotalExpPaidByCid(client_BO.getId()))%> --%>
    		<%=String.format("%.2f", payment_received-actual_exp)%>
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

<table class="table">
	<tr>
		<td><span><b>Total Estimate: </b><%=String.format("%.2f", total_estimate)%></span> </td>
		<td><span><b>Total Received: </b><%=String.format("%.2f", total_received)%></span></td>
		<td><span><b>Total Expenses: </b><%=String.format("%.2f", total_expence)%></span></td>
	</tr>
	<tr>
		<td><span><b>Total Expenses Paid: </b><%=String.format("%.2f",total_expence_paid)%></span></td>
		<td><span><b>Total Expenses Unpaid: </b><%=String.format("%.2f", total_expence_unpaid)%></span></td>
		<td><span><b>Total Amount In Hand: </b><%=String.format("%.2f", total_in_hand)%></span></td>
		<td></td>
	</tr>
</table>
<%-- <div class="amountdue" style="
    display: inline;
    float: left;
    padding-bottom: 15px;
    margin-left: 15% ;
    font-size:18px;" >
	<span><b>Total Estimate: </b><%=String.format("%.2f", total_estimate)%></span> <br />
</div>

<div class="amountdue" style="
    display: inline;
    float: left;
    padding-bottom: 15px;
    margin-left: 1%;
    font-size:18px;"  >
	<span><b>Total Received: </b><%=String.format("%.2f", total_received)%></span> <br />
</div>
<br>
<br>
<div class="amountdue" style="
    display: inline;
    
    /* position: relative; */
    padding-left: 1%;
    font-size:18px;" 
>
	<span><b>Total Expenses: </b><%=String.format("%.2f", total_expence)%></span> <br />
</div>
<div class="amountdue" style="
    display: inline;
    float: left;
    /* position: relative; */
    padding-left: 1%;
    font-size:18px;" 
>
	<span><b>Total Expenses Unpaid: </b><%=String.format("%.2f", total_expence_unpaid)%></span> <br />
</div>

<div class="amountdue" style="
    display: inline;
     padding-left: 31%;
    font-size:18px; "
>
<span><b>Total Amount In Hand: </b><%=String.format("%.2f", total_in_hand)%></span> <br />
</div> --%>
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

