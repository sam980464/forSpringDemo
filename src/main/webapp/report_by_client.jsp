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
try{
	Client client= new Client();
	client.setFromDate(from);
	client.setToDateExp(to);
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
    		Estimate estimate= new Estimate();
    		total_estimate=total_estimate+estimate.getTotalEstimateByClientId(client_BO.getId());
    		%>
    		<%=String.format("%.2f",estimate.getTotalEstimateByClientId(client_BO.getId()) )%>
    		</td>		
    		<td><%=String.format("%.2f", client.getTotalPaidCid(client_BO.getId()))%>
    		</td>
    		<td><%=String.format("%.2f",client.getTotalDueCid(client_BO.getId()) )%></td>	
    		<td><%=String.format("%.2f",client.getTotalExpByCid(client_BO.getId()) )%></td>	
    		<td><%=String.format("%.2f", client.getTotalExpPaidByCid(client_BO.getId()))%></td>
    		<td><%=String.format("%.2f", client.getTotalPaidCid(client_BO.getId())-client.getTotalExpPaidByCid(client_BO.getId()))%></td>	
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
	<h1><span><b>Total Estimate: </b><%=String.format("%.2f", total_estimate)%></span></h1> <br />
</div>
<br>


<%@ include file="common/foot.jsp" %>



