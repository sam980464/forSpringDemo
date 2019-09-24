<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<%


int payment_id= Integer.parseInt(request.getParameter("payment_id"));
ExpensesPayment expensesPayment= new ExpensesPayment();
expensesPayment.setId(payment_id);

double amount=expensesPayment.getPaidAmountForPaymentId(payment_id);
String paidDate=expensesPayment.getPaidDateByPaymentId(payment_id);

String[] datetime = paidDate.split(" ");
paidDate=datetime[0];
%>

<script type="text/javascript" src="resources/js/datetimepicker.js"></script>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Payment To Supplier</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet" onsubmit="return checkValidation();" style="width: 900px;height: 200px">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Amount</span>
							<div>
								<input type="text" value="<%=String.format("%.2f", amount) %>" name="amount_received" id="amount_received" required="required">
							</div>
						</td>
						<td><span>Payment Method</span>
							<div>
							<select name="payment_method" id="payment_method"  onchange="loadBank()" >
								<option value="CASH">CASH</option>
								<option value="CHEQUE">CHEQUE</option>
							</select>
							</div>
						</td>
					</tr>
				</table>
				<table width="100%" border="1" class="tbl" id="cheque_id">
					<tr>
						<td><span>Cheque Number</span>
							<div>
								<input type="text" placeholder="Cheque No."  name="cheque_no"  id="cheque_no" class="input-small"  />
							</div>
						</td>
						<td><span>Bank</span>
							<div>
							<select id="bank_list" name="bank_list" style="width: 277px;" ></select>
							</div>
						</td>
					</tr>
				</table>
				<table width="100%" border="1" class="tbl" id="cheque_id">
					<tr>
						<td><span>Date Paid</span>
							<div>
								<input type="text" value="<%=paidDate %>" placeholder="YYYY-MM-DD"  name="date_paid"  id="demo" /><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
							</div>
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<!-- <table width="100%" border="1" class="tbl">
					<tr>
						<td>
							<div><span>Total Expenses</span>
								<input type="text"  name="total"  id="total" placeholder="Total" readonly="readonly"  value="">
							</div>
						</td>
						<td>
							<div><span>Due Expenses</span>
								<input type="text" name="due" id="due" placeholder="Due"  readonly="readonly"  value="" >
								
							</div>
						</td>
					</tr>
					
				</table> -->
				
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="editExpensesPayment"> 
					<input type="hidden" name="payment_id" value="<%= payment_id%>">
					<input type="hidden" name="cid" value="<%= request.getParameter("cid")%>">
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
					
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->

                
 <script type="text/javascript">

 document.getElementById("cheque_id").style.display= "none";
 
 
 
 
 function loadBank()
 {
 	var payment_method= document.getElementById("payment_method").value;
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
	 	 			document.getElementById("cheque_id").style.display= "block";
	 	 			
	 		  		document.getElementById("bank_list").innerHTML=xmlhttp.responseText;
	 		 	}
	 		 	else{
	 		 		document.getElementById("cheque_id").style.display= "none";
	 		 		
	 		 	}
	 	    }
	 	  }
	 	xmlhttp.open("GET","ActionServlet?todo=getBankList",true);
	 	xmlhttp.send();
 	
 }

</script>