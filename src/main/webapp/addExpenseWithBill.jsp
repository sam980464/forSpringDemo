<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>
<style>
.tbl span {
    float: left;
    font-weight: bold;
    min-width: 0px !important;
    padding: 0px;
}
</style>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Add More Item For Same Bill</li>
        </ul>
<br>
<% java.text.DateFormat df1 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>		 
<div class="maincontent">
<div class="maincontentinner">
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Add More Item For Same Bill</h4>
         <div class="widgetcontent">
<form method="post" action="ProjectServlet">
<input type="hidden" name="supplier_id" value="<%=request.getParameter("sup_id")%>">
<input type="hidden" name="todo" value="addProjectExpense">
<input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
<input type="hidden" name="more_item_on_bill" value="0">
<input type="hidden" name="status" value="on">
<input type="hidden" name="note" value="">
<table  class="tbl" width="100%" border="1">
<tr>
<td>
	<span>Bill Number</span>
	<div>
	<input id="bill_no" type="text" name="bill_no" class="input-small" readonly value="<%=request.getParameter("bill_no")%>" />
	</div>	
</td>
<td>
	<span>Supplier</span>
	<div>
	<select readonly name="supplier" > 
<%
	ArrayList<SupplierBO> supplierList=null;
	Iterator<SupplierBO> supplierIt;
	SupplierBO supplierItem;
	try{
		Supplier supplier= new Supplier();
		supplierList=supplier.getAllItem();
		
		if(supplierList != null){
			supplierIt = supplierList.iterator();
			while(supplierIt.hasNext()){
				supplierItem = (SupplierBO)supplierIt.next();
%>	
<option  value="<%=supplierItem.getId()%>" <% if(supplierItem.getId()==Integer.parseInt(request.getParameter("sup_id"))){out.print("selected=selected");} %>><%=supplierItem.getSupplierName() %></option>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>	
	</select>
	</div>
</td>



<td>
	<span>Service</span>
	<div>
	<select name="service" >
<%
	
	try{
		Supplier supplier= new Supplier();
		supplierList=supplier.getAllServiceBySupplier(Integer.parseInt(request.getParameter("sup_id")));
		
		if(supplierList != null){
			supplierIt = supplierList.iterator();
			while(supplierIt.hasNext()){
				supplierItem = (SupplierBO)supplierIt.next();
%>

<option value="<%=supplierItem.getId() %>"><%=supplierItem.getSupplierName() %></option>

<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%> 	
	
	</select>
	</div>	
</td>


<td>
	<span>Date</span>
	<div>
	<input id="datepicker" class="input-small datepicker hasDatepicker" readonly="readonly" type="text" name="date" value="<%= request.getParameter("date1") %>">
	</div>	
</td>
<td>
	<span>Quantity</span>
	<div>
	<input id="quan" type="text" placeholder="0.00" name="qty"  class="input-small "  onkeyup="calculate(0)" />
	</div>	
</td>
<td>
	<span>Per Unit Price</span>
	<div>
	<input id="unit_price" type="text" placeholder="0.00"  name="per_unit_price" class="input-small" onkeyup="calculate(0)" />
	</div>	
</td>
<td>
	<span>Amount</span>
	<div>
	<input id="total_amount" type="text" placeholder="0.00" name="total_amount" class="input-small" required="required"  onkeyup="calculate(1)" />
	</div>	
</td>
</tr>
<tr>
<td><input type="submit" value="Add To Bill" class="alertdanger btn btn-danger alertdanger"></td>
<td>
	<a href="projects.jsp?proid=<%=session.getAttribute("project_id")%>">
	<input type="button" value="Go To Project Dashboard" class="alertdanger btn btn-danger alertdanger">
	</a>
</td>
</tr>
</table>
			<%
				ProjectDAO pdao1=new ProjectDAO();
				Project project=pdao1.getProjectFundAmount(session.getAttribute("project_id").toString());
				 %>
				 <table width="1200px" border="1" class="tbl">
				 <tr>
				 <td>Total Investment</td>
				 <td>Total Buyers' Payment</td>
				 <td>Total Expensed Payment</td>
				 <td>Total Investor Refund</td>
				 <td>Total Fund Amount</td>
				 </tr>
				 <tr>
				 <td>
				 <input type="text" readonly="readonly" value="<%=project.getInvestment_sum() %>"/>
				
				 </td>
				 <td>
				 <input type="text" readonly="readonly" value="<%=project.getBuyer_payment_sum() %>"/>
				 </td>
				 <td>
				 <input type="text" readonly="readonly" value="<%=project.getExpensed_sum() %>"/>
				 </td>
				 <td>
				 <input type="text" readonly="readonly" value="<%=project.getRefund_sum() %>"/>
				 </td>
				 <td>
				 <input type="text" name="fund_amount" id="fund_amount" readonly="readonly" value="<%=Long.parseLong(project.getBuyer_payment_sum())+Long.parseLong(project.getInvestment_sum())-Long.parseLong(project.getExpensed_sum())-Long.parseLong(project.getRefund_sum()) %>"/>
				 </td>
				 </tr>
				 </table>
				
</form>
</div>              
    	</div><!--widgetcontent-->
</div>
         <h4 class="widgettitle">Expenses List for Current Month</h4>
         <div class="widgetcontent">
            <table id="dyntable" class="table table-bordered table-invoice-full">
                    <!-- <colgroup>
                        <col class="con0" />
                        <col class="con0" />
                        <col class="con0" />
                        <col class="con0" />
                    </colgroup> -->
                    <thead>
                        <tr>
                          	<th class="head0">Date</th>
                            <th class="head0">Expense ID</th>
							<th class="head0">Expensed Amount</th>
							<th class="head0">Option</th>
                        </tr>
                    </thead>
                    <tbody>
<%
 ProjectDAO pdao=new ProjectDAO();
 ArrayList<ArrayList<String>> expenseDetails=pdao.getExpenseListByBillNo((String)session.getAttribute("project_id"),request.getParameter("sup_id"),request.getParameter("bill_no"));
 for(int i=0;i<expenseDetails.size();i++){
 %>
                        <tr class="gradeX">
                         <td>
                             <%=expenseDetails.get(i).get(0) %> 	
                            </td>
                         <td>
                             EXP_00<%=expenseDetails.get(i).get(1) %>                     
                         </td>
                            <td>
	                        <%=expenseDetails.get(i).get(2) %>[DUE:<%=Float.parseFloat(expenseDetails.get(i).get(2))-Float.parseFloat(expenseDetails.get(i).get(3))%>]
                            <input type="hidden" name="due_amount" id="due_amount" value="<%=Float.parseFloat(expenseDetails.get(i).get(2))-Float.parseFloat(expenseDetails.get(i).get(3))%>"> 
                            <input type="hidden" name="paid_amount" id="paid_amount" value="<%=Float.parseFloat(expenseDetails.get(i).get(3))%>"> 
                            </td>
							<td>
							<b> 
								<a Title="Payment" href="ProjectSupplierPayment.jsp?exp_id=<%=expenseDetails.get(i).get(1) %>&sup_id=<%=request.getParameter("sup_id") %>&exp_amount=<%=expenseDetails.get(i).get(2) %>&total_amount=<%=expenseDetails.get(i).get(3) %>&due_amount=<%=Float.parseFloat(expenseDetails.get(i).get(2))-Float.parseFloat(expenseDetails.get(i).get(3))%>&bill_no=<%=request.getParameter("bill_no") %>&p_id=<%=expenseDetails.get(i).get(4)%>" class="color cboxElement">Pay</a> | 
								<a Title="Payment History" href="ProjectSupplierPaymentHistory.jsp?exp_id=<%=expenseDetails.get(i).get(1) %>" class="color cboxElement">History</a> |
								</b>
							</td>
                        </tr>
  <%} %>
                    </tbody> 
                </table>
     </div>           
<form action="ProjectServlet" method="post">
<input type="hidden" name="sup_id" value="<%=request.getParameter("sup_id")%>">
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Pay The Bill Now</h4>
         <div class="widgetcontent">
         Bill Number <input type="text" class="input-small"  name="bill_no" value="<%=request.getParameter("bill_no")%>" readonly="readonly">
         Date <input type="text" name="datecreated" class="input-small" value="<%= df1.format(new java.util.Date()) %>">
         Payment Method <select name="payment_method" class="input-small" id="payment_method"  onchange="loadBank1()" >
								<option value="CASH">CASH</option>
								<option value="CHEQUE">CHEQUE</option>
							</select>		
         <table  border="1" class="tbl" id="cheque_id" >
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
		<input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
		<input type="hidden" name="todo" value="addProjectExpensesPaymentByBill">
		<input type="hidden" name="cid" value="<%=request.getParameter("cid")%>">
         <input type="submit" value="Pay Full" class="alertdanger btn btn-danger alertdanger">
         </div>
 </div>

 </form>
 
<%@ include file="common/foot.jsp" %>
<script type="text/javascript">
document.getElementById("cheque_id").style.display= "none";
function calculate(val){
if(val==0){
var quan=parseFloat(document.getElementById("quan").value);
var unit_price=parseFloat(document.getElementById("unit_price").value);
var total_amount=quan*unit_price;
}else{
var total_amount=parseFloat(document.getElementById("total_amount").value);
}
var total_fund=parseFloat(document.getElementById("fund_amount").value);
//alert(total_amount+":"+total_fund);
if(total_amount>=0){
if(total_fund>=(total_amount)){
document.getElementById("total_amount").value=""+(total_amount);
}else{
alert("Your Expense Amount exceeds project fund!!!!");
document.getElementById("total_amount").value="";
}
}
}

 function loadBank1()
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