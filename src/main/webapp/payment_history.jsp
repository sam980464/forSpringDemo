<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<style type="text/css">
.box {
	border: 1px solid green;
	position: absolute;
	color: black;
	top: 19px;
	left: 75px; 
	background-color: gray;
}
</style>
<%
	Client client = new Client();
	Estimate estimate = new Estimate();
	int eid = 0;
	if (request.getParameter("estimateid") != null) {
		eid = Integer.parseInt(request.getParameter("estimateid"));
	}
	double estimated_amount = estimate.getAmountByEstimateId(eid);
	double total_paid = 0.00;
%>
<div class="row-fluid">
	<h4 class="widgettitle">
		Payment History of <b><%=client.getClientNameById(Integer.parseInt(request
					.getParameter("cid")))%></b>
	</h4>
	<table id="dyntable" style="width: 900px;"
		class="table table-bordered responsive">

		<thead>
			<tr>
				<th></th>
				<th class="head1">For Scheme</th>
				<th class="head0">Amount</th>
				<th class="head1" style="width: 60px">Payment Method</th>
				<th class="head0">Check Number</th>
				<th class="head1">Received By</th>
				<th class="head0" style="width: 70px">On Date</th>
				<th class="head1">Option</th>
			</tr>
		</thead>
		<tbody>
			<%
				int cid = Integer.parseInt(request.getParameter("cid"));
				ArrayList<PaymentBO> paymentList = null;
				Iterator<PaymentBO> paymantIt;
				PaymentBO paymentItem;
				try {
					Payment payment = new Payment();

					if (eid == 0) {
						paymentList = payment.getAllItemByCId(cid);
					} else {
						paymentList = payment.getAllItemByEId(eid);
					}
					if (paymentList != null) {
						paymantIt = paymentList.iterator();
						while (paymantIt.hasNext()) {
							paymentItem = (PaymentBO) paymantIt.next();
			%>

			<tr class="gradeX">
				<td></td>

				<td>
					<%
						Scheme scheme = new Scheme();
					%> <%=scheme.getSchemeNameByEstimateId(paymentItem
								.getEstimateId())%>
				</td>
				<td>
					<%-- <a target="_blank" href="invoice.jsp?pid=<%=paymentItem.getId()%>"> --%>
					<%=String.format("%.2f",
								paymentItem.getAmountReceived())%> <%
 	total_paid = total_paid
 						+ paymentItem.getAmountReceived();
 %> <!-- </a> -->
				</td>

				<td><%=paymentItem.getPaymentMethod()%></td>
				<td>
					<%
						if (paymentItem.getPaymentMethod().equals("CHEQUE")) {
					%> CHECK NO: <%=paymentItem.getChequeNo()%> <%
 	Bank bank = new Bank();
 %> [<%=bank.getBankNameById(paymentItem
									.getBankid())%>]

					<%
 	}
 %>
				</td>
				<td>
					<%
						User user = new User();
					%> <%=user.getLoginUserName(paymentItem
								.getReceivedBy())%>

				</td>
				<td><%=paymentItem.getDateReceived()%></td>
				<td><a class="color cboxElement"
					href="payment_edit.jsp?cid=<%=cid%>&estimateid=<%=eid%>&pid=<%=paymentItem.getId()%>&total=<%=estimated_amount%>">Edit</a>
					| <a
					href="ActionServlet?todo=deletePayment&cid=<%=cid%>&pid=<%=paymentItem.getId()%>"
					onclick="return confirm('Are you sure?');">Delete</a>| <a
					Title="Print"
					href="payment_received.jsp?cid=<%=cid%>&eid=<%=eid%>&pid=<%=paymentItem.getId()%>"
					target="_blank">Print Receipt(<span
						<%if(paymentItem.getReceiptPrintCount()>0) { %> title=<%=paymentItem.getReceiptPtintDate()%> class="hoverToolTip" <%} %>
						id="receiptPrintCount" ><%=paymentItem.getReceiptPrintCount()%></span>)
				</a>| <a Title="Print"
					href="bill.jsp?cid=<%=cid%>&eid=<%=eid%>&pid=<%=paymentItem.getId()%>"
					target="_blank">Download Bill(<span
						<%if(paymentItem.getBillPrintCount()>0) { %>title=<%=paymentItem.getBillPrintDate()%> class="hoverToolTip" <%} %> id="billPrintCount"  ><%=paymentItem.getBillPrintCount()%></span>)
				</a></td>

			</tr>

			<%
				}
					}
				} catch (Exception e) {

					e.printStackTrace();
				}
			%>

		</tbody>
	</table>
	<table style="width: 900px;" border="1">
		<tr>
			<th>Estimated Total</th>
			<td><%=estimated_amount%></td>
			<th>Total Received</th>
			<td><%=total_paid%></td>
			<th>Total Due</th>
			<td><%=estimated_amount - total_paid%></td>
		</tr>
	</table>
</div>
<!--row-fluid-->



<a
	href="get_payment.jsp?cid=<%=request.getParameter("cid")%>&estimateid=<%=eid%>"
	class="btn btn-danger alertdanger cboxElement color"> <small>Get
		A Payment</small>
</a>
<script type="text/javascript" src="resources/js/jquery-1.9.1.min.js"></script>
<script>
	$(".hoverToolTip").hover(function() {		
		var title = $(this).attr("title");
		$('<div/>', {
			text : title,
			class : 'box'
		}).appendTo(this);
	}, function() {
		$(document).find("div.box").remove();
	}); 
</script>
