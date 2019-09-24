<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<script type="text/javascript"
	src="http://jqueryjs.googlecode.com/files/jquery-1.3.1.min.js"> </script>
<script type="text/javascript">

    function PrintElem(elem)
    {
        Popup($(elem).html());
    }

    function Popup(data) 
    {
        var mywindow = window.open('', 'maincontent', 'height=400,width=600');
        mywindow.document.write('<html><head><title>my div</title>');
        /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
        mywindow.document.write('</head><body >');
        mywindow.document.write(data);
        mywindow.document.write('</body></html>');

        mywindow.print();
        mywindow.close();

        return true;
    }

</script>

<%@ include file="common/head_for_print.jsp"%>
<style>
table {
	border: 1px solid;
}

body {
	background: none !important;
}

.invoice_logo {
	margin-bottom: 5px;
}

table {
	white-space: nowrap;
}

.table th {
	background: none repeat scroll 0 0 #6C6868;
	border-top: 0 none;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: normal;
	text-transform: uppercase;
}
</style>


<div class="">
	<%
int cid= Integer.parseInt(request.getParameter("cid"));
int eid= 0;
double totalpaid=0.0;
double estimatedAmount=0.0;
double receivedTotal=0.0;
if (request.getParameter("eid")!=null){
eid=Integer.parseInt(request.getParameter("eid"));
}

Client client= new Client();
String client_name=client.getClientNameById(cid);
String client_address=client.getClientAddressById(cid);
%>

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
    
 jQuery(document).ready(function(){
        jQuery(".color").colorbox();        
    });
</script>


	<div class="maincontent" id="maincontent">
		<div class="maincontentinner">
			<div class="row-fluid">

				<div class="span6">
					<div class="invoice_logo">
						<img width="150" src="resources/images/comlogo.png" alt=""
							class="img-polaroid" />
					</div>
				</div>
				<!--span6-->

				<div class="span6">
					<table class="table table-bordered table-invoice">
						<tr>
							<td class="width30">Invoice For:</td>
							<td class="width70"><strong><%=client_name %></strong></td>
						</tr>
						<tr>
							<td>Address</td>
							<td><%=client_address %></td>
						</tr>
					</table>
				</div>
				<!--span6-->
			</div>

			<hr>

			<h4>Estimate Summary</h4>
			<table class="table table-bordered table-invoice-full">
				<colgroup>
					<col class="con0 width5" />
					<col class="con1 width5" />
					<col class="con0 width10" />
					<col class="con1 width5" />
					<col class="con0 width20" />
					<col class="con1 width5" />
				</colgroup>
				<thead>
					<tr>
						<th class="head0">Date</th>
						<th class="head1">Estimate Id</th>
						<th class="head0">For Scheme</th>
						<th class="head1">Estimated Amount</th>
						<th class="head0">Amount Received</th>
						<th class="head0">Estimated By</th>
					</tr>
				</thead>
				<tbody>
					<%
	ArrayList<EstimateBO> estimateList=null;
	Iterator<EstimateBO> estimateIt;
	EstimateBO estimateItem;
	try{
		Estimate estimate= new Estimate();
		
		if(eid<=0){
			estimateList=estimate.getAllItem(cid);
		}
		else{
			estimateList=estimate.getAllItemByEid(eid);
		}
		if(estimateList != null){
			estimateIt = estimateList.iterator();
			while(estimateIt.hasNext()){
				estimateItem = (EstimateBO)estimateIt.next();
				estimatedAmount=estimateItem.getAmount();
%>
					<tr>
						<td><%= estimateItem.getDateCreated()%></td>
						<td><%= estimateItem.getId()%></td>
						<td class="right">
							<% Scheme scheme= new Scheme(); %> <%=scheme.getSchemeNameById(estimateItem.getSchemeId())%>
						</td>
						<td class="right"><%=String.format("%.2f", estimateItem.getAmount()) %>
						</td>


						<td class="right">

							<table width=100%>
								<tr>
									<th>Date Received</th>
									<th>Amount</th>
									<th>Received By</th>
								</tr>
								<%
	receivedTotal=0.0;
	ArrayList<PaymentBO> paymentList=null;
	Iterator<PaymentBO> paymantIt;
	PaymentBO paymentItem;
	try{
		Payment payment= new Payment();
		paymentList=payment.getAllItemByEId(estimateItem.getId());
		
		if(paymentList != null){
			paymantIt = paymentList.iterator();
			while(paymantIt.hasNext()){
				paymentItem = (PaymentBO)paymantIt.next();
				receivedTotal=receivedTotal+paymentItem.getAmountReceived();
%>
								<tr>
									<td><%=paymentItem.getDateReceived() %></td>
									<td><%=String.format("%.2f", paymentItem.getAmountReceived())%></td>
									<td>
										<% User user= new User(); %> <%=user.getLoginUserName(paymentItem.getReceivedBy()) %>
									</td>
								</tr>

								<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>
								<tr>
									<td><b>Total</b></td>
									<td><%=String.format("%.2f", receivedTotal)%></td>
									<td></td>
								</tr>
								<tr>
									<td><b>Due</b></td>
									<td><%=String.format("%.2f", estimateItem.getAmount()-receivedTotal)%></td>
									<td></td>
								</tr>
							</table>
						</td>


						<td class="right">
							<% User user= new User(); %> <%=user.getLoginUserName(estimateItem.getCreatedBy()) %>
						</td>
					</tr>
					<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>

				</tbody>
			</table>

			<h4 class="widgettitle">Expenses For Client</h4>
			<table class="table table-bordered table-invoice-full">
				<colgroup>
					<col class="con0 width5" />
					<col class="con1 width5" />
					<col class="con0 width5" />
					<col class="con1 width5" />
					<col class="con1 width5" />
					<col class="con0 width20" />
				</colgroup>
				<thead>
					<tr>
						<th class="head0">Date</th>
						<th class="head1">For Scheme</th>
						<th class="head0">Supplier</th>
						<th class="head1">Bill Number</th>
						<th class="head0">Amount</th>
						<th class="head1">Paid Details</th>
					</tr>
				</thead>
				<tbody>

					<%
double totalPaidExp=0.0;
int expid=0;
	ArrayList<ExpensesBO> expensesList=null;
	Iterator<ExpensesBO> expIt;
	ExpensesBO expensesBO;
	try{
		Expenses expenses= new Expenses();
		
		if(request.getParameter("eid") ==null){
			expensesList=expenses.getAllItemByCid(cid);
		}
		else{
			expensesList=expenses.getAllItemByEstimateid(eid);
		}
		
		
		if(expensesList != null){
			expIt = expensesList.iterator();
			while(expIt.hasNext()){
				expensesBO = (ExpensesBO)expIt.next();
				
%>
					<tr>
						<td><%=expensesBO.getExpDate() %></td>

						<td>
							<%
                        expid=expensesBO.getId();
        				System.out.print(expid);
        				
                        Scheme scheme= new Scheme();
                        %> <%=scheme.getSchemeNameByEstimateId(expensesBO.getEstimateId()) %>
						</td>
						<td>
							<%
                        Supplier supplier=  new Supplier();
                        %> <%=supplier.getSupplierNameById(expensesBO.getSupplierId()) %><br>[
							<%=supplier.getSupplierAddressById(expensesBO.getSupplierId()) %>]
						</td>
						<td class="right"><%=expensesBO.getBillNumber() %></td>
						<td class="right"><b><%=String.format("%.2f", expensesBO.getTotalAmount())%></b></td>

						<td class="">



							<table width=100%>
								<tr>
									<th>Date Paid</th>
									<th>Amount</th>
									<th>Paid By</th>
								</tr>

								<%
	totalpaid=0.0;

	ArrayList<ExpensesPaymentBO> expensesPaymentList=null;
	Iterator<ExpensesPaymentBO> expensesPaymentIt;
	ExpensesPaymentBO expensesPaymentBO;
	try{
		ExpensesPayment expensesPayment= new ExpensesPayment();
		
		expensesPaymentList=expensesPayment.getAllItemByExpensesId(expensesBO.getId());
		
		if(expensesPaymentList != null){
			expensesPaymentIt = expensesPaymentList.iterator();
			while(expensesPaymentIt.hasNext()){
				expensesPaymentBO = (ExpensesPaymentBO)expensesPaymentIt.next();
				totalpaid=totalpaid+expensesPaymentBO.getAmountReceived();
				totalPaidExp+=totalpaid;
%>
								<tr>
									<td><%=expensesPaymentBO.getDateTime() %></td>
									<td><%=String.format("%.2f", expensesPaymentBO.getAmountReceived())%>
									</td>

									<td>
										<% User user= new User(); %> <%=user.getLoginUserName(expensesPaymentBO.getReceivedBy()) %>

									</td>
								</tr>
								<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>

								<tr>
									<td><b>Total</b></td>
									<td><%=String.format("%.2f",totalpaid )%></td>
									<td></td>
								</tr>
								<tr>
									<td><b>Due</b></td>
									<td><%=String.format("%.2f", expensesBO.getTotalAmount()-totalpaid)%></td>
									<td></td>
								</tr>
							</table>
						</td>
					</tr>
					<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>

				</tbody>
			</table>


			<%
if(eid>0){

%>
			<table class="table invoice-table">
				<tbody>
					<tr>
						<td class="width65 msg-invoice">
							<h4></h4>
							<p></p>
						</td>
						<td class="width15 right numlist"><strong>Estimated
								Amount</strong> <strong>Total Paid</strong> <strong>Total Paid
								For Expenses</strong> <strong>On Hand</strong></td>
						<td class="width20 right numlist"><strong>Rs. <%=String.format("%.2f", estimatedAmount)%></strong>
							<strong>Rs. <%=String.format("%.2f", receivedTotal)%></strong> <strong>Rs.
								<%=String.format("%.2f", totalPaidExp)%></strong> <strong>Rs. <%=String.format("%.2f", receivedTotal-totalpaid)%></strong>

						</td>
					</tr>
				</tbody>
			</table>

			<%
}
%>

			<%--  <div class="amountdue">
          	<h1><span>Amount Paid:</span>xxx</h1> <br />
            <a href="" class="btn btn-primary btn-large">Pay Invoice</a>
            <a href="client.jsp?cid=<%=cid %>" class="btn btn-primary btn-large">Back To Client </a>
          </div> --%>

			<%@ include file="common/foot.jsp"%>