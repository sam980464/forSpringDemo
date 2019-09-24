<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
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

<script type="text/javascript">
function cal(){
var amnt=document.getElementById("unit_price").value;
var qnty=document.getElementById("qty").value;
//alert(qnty*amnt);

document.getElementById("amount").value=amnt*qnty;
}
</script>

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
<form method="post" action="ActionServlet">


<input type="hidden" name="client" value="<%=request.getParameter("cid")%>">
<input type="hidden" name="bill_number" value="<%=request.getParameter("billno")%>">
<input type="hidden" name="estimate" value="<%=request.getParameter("eid")%>">
<input type="hidden" name="supplier_id" value="<%=request.getParameter("supplier_id")%>">
<input type="hidden" name="todo" value="addOrder">
<input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
<input type="hidden" name="more_item_on_bill" value="0">



<table  class="tbl" width="100%" border="1">
<tr>
<td>
	<span>Bill Number</span>
	<div>
	<input id="bill_no" type="text" name="bill_no" class="input-small" readonly value="<%=request.getParameter("billno")%>" />
	</div>	
</td>
<td>
	<span>Supplier</span>
	<div>
	<select readonly name="supplier" > 
<%
String sup=request.getParameter("supplier_id");
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
<option  value="<%=supplierItem.getId()%>" <% if(supplierItem.getId()==Integer.parseInt(request.getParameter("supplier_id"))){out.print("selected=selected");} %>><%=supplierItem.getSupplierName() %></option>

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
<input type="hidden" value="<%=request.getParameter("sid") %>"> 
	<span>Service</span>
	<div>
	<select name="service" id="serviceId">
<%
	
	try{
		Supplier supplier= new Supplier();
		supplierList=supplier.getAllServiceBySupplier(Integer.parseInt(request.getParameter("supplier_id")));
		
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
	<input id="datepickerReadOnly" class="input-small datepicker" type="text" readonly name="datecreated"   value="<%= request.getParameter("date") %>">
		
	</div>	
</td>
<td>
	<span>Quantity</span>
	<div>
	<input id="qty" type="text" placeholder="0.00" name="qty" class="input-small " value="" autocomplete="off" onkeyup="cal()"/>
	</div>	
</td>
<td>
	<span>Per Unit Price</span>
	<div>
	<input id="unit_price" type="text" placeholder="0.00" name="per_unit_price" class="input-small " autocomplete="off" value="" onkeyup="cal()"/>
	</div>	
</td>
<td>
	<span>Amount</span>
	<div>
	<input id="amount" type="text" placeholder="0.00" required="required" name="amount" class="input-small " value="" />
	</div>	
</td>
</tr>

<tr>
<td><input type="submit" value="Add To Bill" class="alertdanger btn btn-danger alertdanger"></td>
<td>
	<a href="client.jsp?cid=<%=request.getParameter("cid")%>">
	<input type="button" value="Go To Client Dashboard" class="alertdanger btn btn-danger alertdanger">
	</a>
</td>
</tr>
 
</table>
</form>
</div>     
           
    	</div><!--widgetcontent-->
</div>

<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Expenses List for Current Month</h4>
         <div class="widgetcontent">
         
   



         
         
            <table id="dyntable" class="table table-bordered responsive">
                   <!--  <colgroup>
                        <col class="con0" style="align: center; width: 4%" />
                        <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                        <col class="con0" />
                    </colgroup> -->
                    <thead>
                        <tr>
                          	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
                          	<th class="head1">Date</th>
                            <th class="head0">Expenses For</th>
							<th class="head0">QTY</th>
							<th class="head1">Per Unit Price</th>
							<th class="head0">Amount</th>
							<th class="head0">Option</th>
							
                        </tr>
                    </thead>
                    <tbody>

<%
	int cid=Integer.parseInt(request.getParameter("cid"));
	String billno=request.getParameter("billno");
	int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));	
	ArrayList<ExpensesBO> expensesList=null;
	Iterator<ExpensesBO> expIt;
	
	ExpensesBO expensesBO;
	double total=0.0; 
	try{
		Expenses expenses= new Expenses();
		expenses.setClientId(cid);
		expenses.setBillNumber(billno);
		expenses.setSupplierId(supplier_id);
		expensesList=expenses.getAllItemForBill();
		//expensesList=expenses.getAllItemByCid(cid);
		if(expensesList != null){
			expIt = expensesList.iterator();
			while(expIt.hasNext()){
				expensesBO = (ExpensesBO)expIt.next();
%>	
                    
                     <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                          	<td><%=expensesBO.getExpDate() %></td>
                          	<td class="expenseFor">
                          	<%
                          	Service service= new Service();
                          	%>
                          	<%=service.getServiceNameById(expensesBO.getServices_id())%></td>        
                            <td><%=String.format("%.2f", expensesBO.getQty()) %></td>                            
                            <td><%=String.format("%.2f", expensesBO.getUnitPrice()) %></td>
                            <td><%=String.format("%.2f", expensesBO.getTotalAmount()) %>  [Due : <%=String.format("%.2f", expenses.getTotalDueByExpId(expensesBO.getId())) %>]</td>
                             <td>
                             <a href="edit_order_to_supplier.jsp?exid=<%=expensesBO.getId() %>&supid=<%=sup %>&srid=<%=expensesBO.getServices_id() %>" class="color cboxElement">Edit<!-- <img src="resources/images/edit.png" /> --></a>

<%
if(expenses.getTotalDueByExpId(expensesBO.getId())!=0.0){
%>
|<a href="ActionServlet?todo=deleteExpenses&exid=<%=expensesBO.getId() %>&cid=<%=expensesBO.getClientId() %>&billno=<%=expensesBO.getBillNumber() %>&supplier_id=<%=expensesBO.getSupplierId()%>&eid=<%=expensesBO.getEstimateId() %>"  onclick="return confirm('Are you sure?');">Delete<!-- <img src="resources/images/delete.png" /> --></a> 					
|<a href="payment_to_supplier.jsp?cid=<%=request.getParameter("cid") %>&exid=<%=expensesBO.getId() %>&expdate=<%=expensesBO.getExpDate() %>" class="color cboxElement" >Payment To Supplier</a> 						 
<% } %>						
						
						<%-- <a target="_bank" Title="Paymnt" href="voucher.jsp?exid=<%=expensesBO.getId() %>" >Voucher<!-- <img src="resources/images/money.png" /> --></a> --%>
                             </td>
                        </tr>                      
                     
  <%
  total=total+expensesBO.getTotalAmount();
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>                   
                     
                     <tr class="gradeX">
                          <td class="aligncenter"><span class="center"></td>
                          <td></td>
                          <td></td>        
                          <td></td>                            
                          <td></td>
                          <td> <b>Total = <%=String.format("%.2f", total) %></b></td>
                        </tr>   
                     </tbody>
                </table> 
                
               
    	</div><!--widgetcontent-->
</div>
<div class="col-md-4 text-center"> 
<a href="client.jsp?cid=<%=request.getParameter("cid")%>&isSuccess=true">
    <button id="singlebutton" name="singlebutton" class="btn btn-primary btn-sx" style="background: green">Save</button> 
</a>
</div>
<form action="ActionServlet" method="post">
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Pay The Bill Now</h4>
         <div class="widgetcontent">
         Bill Number <input type="text" class="input-small"  name="bill_number" value="<%=request.getParameter("billno")%>">
         Date <input type="text" name="datecreated" class="input-small datepicker" id="datepicker">	<b>(YYYY-MM-DD)</b>
         Payment Method <select name="payment_method" class="input-small" id="payment_method"  onchange="loadBank()" >
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
		<input type="hidden" name="todo" value="addExpensesPaymentByBill">
		<input type="hidden" name="cid" value="<%=request.getParameter("cid")%>">
         <input type="submit" value="Pay Full" class="alertdanger btn btn-danger alertdanger">
         
         
         </div>
 </div>
 </form>
 
<%@ include file="common/foot.jsp" %>



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
 (function ($) {
	 $("tbody").find("td.expenseFor").each(function() { //get all rows in table

		   var $addedServiceTdText = $(this).text().trim(); 	 		
		   jQuery("#serviceId option").filter(function(){
			    return $.trim($(this).text()) ==  $addedServiceTdText
			}).remove();	   

		});
	 $('#datepicker').val($('#datepickerReadOnly').val());
	})(jQuery);
 
 </script>