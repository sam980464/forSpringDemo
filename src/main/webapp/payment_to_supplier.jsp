<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<%
Client client=new Client();
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>
<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Payment To Supplier For Expenses ID : <%=request.getParameter("exid") %>  for <b><%=client.getClientNameById(Integer.parseInt(request.getParameter("cid"))) %></b></h4>
		
<%
Double total=0.0;
Double due=0.0;
int exid=Integer.parseInt(request.getParameter("exid"));
Expenses expenses= new Expenses();
total=expenses.getTotalAmountByExID(exid);
due=expenses.getTotalDueByExpId(exid);

Estimate estimate = new Estimate();
int estimate_id= expenses.getEstimateIdByExpensesId(exid);
Payment payment = new Payment();


%>		
		
		
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet" onsubmit="return checkOverflow() && dateCompare()" >
				<table width="1000px" border="1" class="tbl">
					<tr>
						<td><span>Amount</span>
							<div>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" placeholder="0.00" name="amount_received" id="amount_received" required="required">
							</div>
						</td>
						<td>
						<span>Payment Method</span>
							<div>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<select name="payment_method" id="payment_method_pop"   onchange="loadBank()" >
								<option value="CASH">CASH</option>
								<option value="CHEQUE">CHEQUE</option>
							</select>
							</div>
						</td>
					</tr>
		  		</table>
				<table width="1000px" border="1" class="tbl" id="cheque_id_pop">
				<tr>
						<td><span>Cheque Number</span>
							<div>
								<input type="text" placeholder="Cheque No."  name="cheque_no"  id="cheque_no" class="input-small"  />
							</div>
						</td>
						<td><span>Bank</span>
							<div>
							<select id="bank_list_pop" name="bank_list" style="width: 277px;" ></select>
							</div>
						</td>
					</tr>
				</table>
				<table width="1000px" border="1" class="tbl" id="cheque_id">
					<tr>
						<td>
							<span>Date</span>
							<div>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%= df.format(new java.util.Date()) %>" class="input-small datepicker hasDatepicker" name="datecreated" id="demo" /><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
							<b>[YYYY-MM-DD]</b>
							</div>
						</td>
						<td>
							<span>Expensed Date</span>
							<div>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%=request.getParameter("expdate")%>" class="input-small datepicker hasDatepicker" name="datecreated1" id="demo1" readonly />
							<b>[YYYY-MM-DD]</b>
							</div>
						</td>
						<td>

						</td>
					</tr>
				</table>
				<table width="1000px" border="1" class="tbl">
					<tr>
						<td>
							<div><span>Total Expenses</span>
								<input type="text"  name="total"  id="total" placeholder="total" readonly="readonly"  value="<%=String.format("%.2f", total)%>">
							</div>
						</td>
						<td>
							<div><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Due Expenses</span>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="due" id="due" placeholder="due"  readonly="readonly"  value="<%=String.format("%.2f", due)%>" >
								
							</div>
						</td>
					</tr>
					
				</table>
				
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addExpensesPayment"> 
					<input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
					<input type="hidden" name="cid" value="<%=request.getParameter("cid")%>">
					<input type="hidden" name="expid" value="<%=request.getParameter("exid") %>">
					<button class="btn btn-primary" >Pay</button>
					<button type="reset" class="btn">Reset Button</button>
					
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->

<table width=100% id='account_status'>
	<tr>
		<th>Total Estimate</th>
		<th>Total Received</th>
		<th>Total Ordered</th>
		<th>Total Actual Paid</th>
		<th>Current In Hand</th>
</tr>

<%
ExpensesPayment  expensesPayment= new ExpensesPayment();
%>
<tr>
	<td>
		<input type='text' class="input-small" name='total_estimate' id='total_estimate' readonly value='<%=String.format("%.2f", estimate.getAmountByEstimateId(estimate_id)) %>'>
	</td>
	<td>
		<input type='text' class="input-small" name='total_received' id='total_received' readonly value='<%=String.format("%.2f", payment.getTotalAmountReceivedByEstimateId(estimate_id)) %>'>
	</td>
	<td>
		<input type='text' class="input-small" name='total_ordered' id='total_ordered' readonly value='<%= String.format("%.2f", expenses.getTotalOrderedByExpId(estimate_id)) %>'>
	</td>
	<td>
		<input type='text' class="input-small" name='total_actual_paid' id='total_actual_paid' readonly value='<%= String.format("%.2f", expensesPayment.getTotalPaidAmountByExpensesIdUsingEstimate(exid)) %>'>
	</td>
	<td>
		<input type='text' class="input-small" name='current_in_hand' id='current_in_hand' readonly value='<%=String.format("%.2f", payment.getTotalAmountReceivedByEstimateId(estimate_id)-expensesPayment.getTotalPaidAmountByExpensesIdUsingEstimate(exid)) %>'>
	</td>
</tr>
</table>
                
 <script type="text/javascript">

 document.getElementById("cheque_id_pop").style.display= "none";
 function dateCompare(){
 var demo=document.getElementById("demo").value;
 var demo1=document.getElementById("demo1").value;
 
 var firstValue = demo.split('-');
var secondValue = demo1.split('-');

 var firstDate=new Date();
 firstDate.setFullYear(firstValue[0],(firstValue[1] - 1 ),firstValue[2]);

 var secondDate=new Date();
 secondDate.setFullYear(secondValue[0],(secondValue[1] - 1 ),secondValue[2]);     

  if (firstDate < secondDate)
  {
   alert("You Can not Pay before Expense Date");
  return false;
   }
 else
  {
  //alert("First Date  is greater than Second Date"); 
  return true;
    
  }
 
 
 }
 
 function loadBank()
 {
 	var payment_method=document.getElementById("payment_method_pop").value;
 	//alert(payment_method);
 	
 	
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
	 		 	if(payment_method=="CHEQUE"){
	 	 			document.getElementById("cheque_id_pop").style.display= "block";
	 	 			
	 		  		document.getElementById("bank_list_pop").innerHTML=xmlhttp.responseText;
	 		 	}
	 		 	else{
	 		 		document.getElementById("cheque_id_pop").style.display= "none";
	 		 		
	 		 	}
	 	    }
	 	  }
	 	xmlhttp.open("GET","ActionServlet?todo=getBankList",true);
	 	xmlhttp.send();
 	
 }
 function checkOverflow()
 {
 	
 	var current_in_hand=parseInt(document.getElementById("current_in_hand").value);
 	var amount_received=document.getElementById("amount_received").value;
 	var total=parseInt(document.getElementById("total").value);
 	
 	
 	//alert(amount_received+"__"+current_in_hand);
 	//return false;
 	
 	 if(amount_received>=current_in_hand || amount_received>total)
 		{
 		alert('You Have Not Much Amount In Hand For The Estimate Or You Are Paying More Then Deal!');
 		return false;
 		}
 	else
 		{
 		return true;
 		}

 }

</script>