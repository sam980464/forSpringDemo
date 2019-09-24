<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<%@page import="java.text.SimpleDateFormat"%>
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
Calendar cal = Calendar.getInstance();
Date today = cal.getTime();
cal.add(Calendar.YEAR, -1); // to get previous year add -1
Date nextYear = cal.getTime();

SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

if(from==null) from=format.format( nextYear  );
if(to==null) to=format.format( new Date()  );


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

<!-- <input type="submit" value="Export" class="alertdanger btn btn-danger alertdanger" onclick="tableToExcel('exportCSV', 'export Table')"> -->
</div>      
           
    	</div><!--widgetcontent-->
</div>

<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Search Result</h4>
         <div class="widgetcontent">
            
 <table id="exportCSV" class="table table-bordered responsive" style="width:80%">
	 
	<thead>
            <tr>
              	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
              	<th class="head0">No.</th>
              	<th class="head1">Client Name</th>
              	<th class="head0">Total Estimated <br /> Amount</th>
              	<th class="head1">Before Date <br /> Payment</th>
              	<th class="head1">Due Payment</th>
              	<th class="head0">Payment Received <br />With In Date</th>
              	<th class="head1">Before Date <br /> Expenses</th>              	
              	<th class="head0">Expenses Paid <br /> With In Date</th>              	
              	<th class="head1">Actual Amount <br /> in hand </th>
              	
          	</tr>
           </thead>
                           
<%

ArrayList<ClientBO> client_List=null;
Iterator<ClientBO> client_It;
ClientBO client_BO;
int  client_id;
int i=1;

double total_due_payment=0.0;
double total_payment_received=0.0;
double total_expence_paid=0.0;
double total_amount_in_hand=0.0;
try{
	Client client= new Client();
	System.out.println("From:::"+from);
	System.out.println("to:::"+to);
	client.setFromDate(from);
	client.setToDateExp(to);	
	client.setScheme_id(scheme_id);
	
	client_List=client.getClientDetailsByPaymentDate();
	
	
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
    		double before_date_payment_received=0.0;
    		double payment_received=0.0;
    		double total_exp=0.0;
    		double before_date_exp=0.0;
    		double actual_exp=0.0;
    		
    		Estimate estimate= new Estimate();
    		
    		if(scheme_id==0){
	    		estimate_amount=estimate.getTotalEstimateByClientId(client_BO.getId());
	    		
    		}
    		else{
    			estimate_amount=estimate.getTotalEstimateByClientId(client_BO.getId(),scheme_id);
    			  			
    		}
    		
    		%>
    		<%=String.format("%.2f",estimate_amount)%>
    		</td>		
    		<td>
    		<%
    		if(scheme_id==0){ 
    			before_date_payment_received=client.getTotalPaidCid(client_BO.getId(),from);
    		} else{ 
    			before_date_payment_received= client.getTotalPaidCid(client_BO.getId(),scheme_id,from);
    		} 
    		
    		%>
    		
    		<%=String.format("%.2f", before_date_payment_received)%>
    		</td>
    		
    		<td><%-- <%=String.format("%.2f",client.getTotalDueCid(client_BO.getId()) )%> --%>
    		<%=String.format("%.2f",estimate_amount-before_date_payment_received )%>
    		</td>
    		<%	
    		total_due_payment = total_due_payment + (estimate_amount-before_date_payment_received);
    		if(scheme_id==0){ 
    			payment_received=client.getTotalPaidByDateRange(client_BO.getId(),from,to);
    		} else{ 
    			payment_received= client.getTotalPaidByDateRange(client_BO.getId(),scheme_id,from,to);
    		} 
    		total_payment_received = total_payment_received + payment_received;
    		%>
    		<td>
    		<%=String.format("%.2f", payment_received)%>
    		</td>
    		<td>
    		
    		<%
    		if(scheme_id==0){ 
    			before_date_exp=client.getBeforeDateExpByCid(client_BO.getId(),from);
    		} else{ 
    			before_date_exp=client.getBeforeDateExpByCid(client_BO.getId(),scheme_id,from);
    		} 
    		
    		%>
    		<%=String.format("%.2f", before_date_exp)%>  		
    		
    		</td>	
    		<td>
    		
    		<%
    		if(scheme_id==0){ 
    			actual_exp=client.getActualExpenseByDateRange(client_BO.getId(),from,to);
        		} else{ 
        		actual_exp=client.getActualExpenseByDateRange(client_BO.getId(),scheme_id,from,to);
        		} 
    		total_expence_paid = total_expence_paid + actual_exp;
    		%>
    		<%=String.format("%.2f", actual_exp)%>
    		</td>
    		<td>
    		
    		<%=String.format("%.2f", (payment_received-actual_exp))%>
    		<% total_amount_in_hand = total_amount_in_hand +(payment_received-actual_exp); %>
    		</td>
    		<td>    		
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
		<td><span><b>Total Due Amount: </b><%=String.format("%.2f", total_due_payment)%></span> </td>
		<td><span><b>Total Payment Received: </b><%=String.format("%.2f", total_payment_received)%></span></td>
		
	</tr>
	<tr>
		<td><span><b>Total Expenses Paid: </b><%=String.format("%.2f", total_expence_paid)%></span></td>
		<td><span><b>Total Amount In Hand: </b><%=String.format("%.2f",total_amount_in_hand)%></span></td>
		
	</tr>
</table>

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

