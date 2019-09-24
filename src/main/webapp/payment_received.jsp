<title>
Money Receipt
</title>
<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<link rel="stylesheet" href="resources/css/style.css" type="text/css" />
<%
int cid= Integer.parseInt(request.getParameter("cid"));
int eid= 0;
double totalpaid=0.0;
double estimatedAmount=0.0;
double receivedTotal=0.0;
double gstTotal=0.0;
String addGstFlag = "";
if (request.getParameter("eid")!=null){
eid=Integer.parseInt(request.getParameter("eid"));
}

Client client= new Client();
String client_name=client.getClientNameById(cid);
String developer_name=client.getDeveloperNameById(cid);
if(null!=developer_name && developer_name.length()>0){
	client_name = developer_name;
}
String client_address=client.getClientAddressById(cid);
%>

<style>
@page { size: auto;  margin: 0mm; }
</style>
<script type="text/javascript" src="resources/js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="resources/js/jquery.print.js" ></script>

<script type="text/javascript">
    $(function() {
    	window.print();
	});
</script>

<div id="printdiv" class="printable" >
	<div class="beforePrintTable" ><p style="text-align:center;font-size:22px;">Money Receipt</p></div>
	<!-- <img src="resources/images/plogo.png" alt="" style="width: 100%; height: 99px;" /> -->
	<div style="width: 100%; margin-top:15px" >
		<div style="font-size:18px"><span style="font-weight:bold">R</span>anjan <span style="font-weight:bold">D</span>atta</div>
		<div>Off - 83/1 S. N. Banerjee Road</div>
		<div>Barrackpore, Kolkata - 700120</div>		
		<div>Phone: 033-2592-4222</div>		
		<div>Mobile: +91-98301-57969</div>
		<div>E-mail: mail2rtech@gmail.com</div>
	</div>
	<div style="float:right;margin-top:-86px">
	<img src="resources/images/rtechLogo.JPG" alt="" style="height: 55px;width:104px" />
	</div>
	<hr style="height:0px">
	
	<div style="display:inline;color:black;font-weight:bold">
	Invoice No : &nbsp;<b><%=request.getParameter("pid") %></b>
	</div>
	<% java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd-MM-yyyy");
	  %>
	  
	  <% 
		Client testClient = new Client(); 
		boolean isClientRegional = false;
		if(request.getParameter("cid")!=null){
			 isClientRegional = testClient.isClientRegional(Integer.parseInt(request.getParameter("cid")));
		}
	%>            
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
				receivedTotal=0.0;
				gstTotal=0.0;
				ArrayList<PaymentBO> paymentList=null;
				Iterator<PaymentBO> paymantIt;
				PaymentBO paymentItem;
				try{
					Payment payment= new Payment();
					
					paymentList=payment.getAllItemByPId(Integer.parseInt(request.getParameter("pid")));
					
					if(paymentList != null){
						paymantIt = paymentList.iterator();
						while(paymantIt.hasNext()){
							paymentItem = (PaymentBO)paymantIt.next();
							receivedTotal=receivedTotal+paymentItem.getAmountReceived();
							gstTotal=gstTotal+paymentItem.getGstAmount();
     					    addGstFlag = paymentItem.getAddGstFlag();
     					%>    

	  
	<div style="float:right;color:black;font-weight:bold">Date: <%=df2.format(df.parse(paymentItem.getDateReceived())) %></div>

<h4 class="widgettitle" style="margin-top:10px;margin-button:10px">
	<div style="display:inline;color:black;font-weight:bold;margin-left:-10px">
	From : &nbsp;<b><%=client_name %></b>
	</div>
	<%
	 String gstNo = new Gst().getGstDetail();
	 if(null!=gstNo && gstNo.length()>4 && null!=addGstFlag && addGstFlag.equalsIgnoreCase("yes"))
	 {
	%>
	<div style="float:right;color:black;font-weight:bold;;margin-right:-10px">GST NO :- <%=new Gst().getGstDetail() %></div>
	<%} %>
</h4>
 <table class="table table-bordered table-invoice-full">
                <colgroup>
                    <col class="con0 width5" />
                   <!--  <col class="con1 width5" /> -->
                    <col class="con0 width10" />
                    <col class="con1 width5" />
                    <col class="con0 width20" />
                    <col class="con1 width5" />
                </colgroup>
                <thead>
                    <tr>
                        <th class="head0" style="color:black;font-weight:bold">Date</th>
                        <!-- <th class="head1" style="color:black;font-weight:bold">Estimate Id</th> -->
                        <th class="head0" style="color:black;font-weight:bold">For Service</th>
                      <!--   <th class="head1">Estimated Amount</th> -->
                        <th class="head0" style="text-align:center; color:black;font-weight:bold">Amount Received</th>
                        <!--  <th class="head0">Estimated By</th> -->
                    </tr>
                </thead>
                <tbody>
           
                    <tr>
                        <td><%= df2.format(df.parse(paymentItem.getDateReceived())) %></td>
                      <%--   <td><%= estimateItem.getId()%></td> --%>
                        <td class="right">
						<% Scheme scheme= new Scheme(); %>
	                    <%=scheme.getSchemeNameById(estimateItem.getSchemeId())%>
						</td>
                        <%-- <td class="right">
						<%=String.format("%.2f", estimateItem.getAmount()) %>
						</td> --%>
                        
                        
                        <td class="right">
                        
                        <table width=100%>
                        	<tr>
	                        	<!-- <th style="color:black;font-weight:bold">Date Received</th> -->
	                        	<th style="color:black;font-weight:bold">Bill Amount</th>
	                        	<%if(null!=gstNo && gstNo.length()>0 && null!=addGstFlag && addGstFlag.equalsIgnoreCase("yes")){ %>
	                        	<th style="color:black;font-weight:bold">GST %</th>
	                        	
	                        	
	                        	<% if(isClientRegional) { %>
	                        	<th style="color:black;font-weight:bold">CGST</th>
	                        	<th style="color:black;font-weight:bold">SGST</th>
	                        	<%} else { %>
	                        	<th style="color:black;font-weight:bold">IGST</th>
	                        	<%}
	                        	}
	                        	%>
	                        	<!-- <th>Received By</th> -->
                        	</tr>
<%

%>                        	
                        	<tr>
	                        	<%-- <td><%=paymentItem.getDateReceived() %></td> --%>
	                        	<td> <%=String.format("%.2f", paymentItem.getAmountReceived())%></td>
	                        	<%if(null!=gstNo && gstNo.length()>0 && null!=addGstFlag && addGstFlag.equalsIgnoreCase("yes")){ %>
	                        	<td> <%=paymentItem.getGstPercentage()%></td>
	                        	<% if(isClientRegional) { %>
	                        	<td> <%=paymentItem.getGstAmount()/2%></td>
	                        	<td> <%=paymentItem.getGstAmount()/2%></td>
	                        	<%} else { %>
	                        	<td> <%=paymentItem.getGstAmount()%></td>
	                        	<%} }%>
	                        	<%-- <td>
	                        	<% User user= new User(); %>
                        		<%=user.getLoginUserName(paymentItem.getReceivedBy()) %>
	                        	</td> --%>
                        	</tr>

<%
		int receiptCount = paymentItem.getReceiptPrintCount();

		
		payment.setId(Integer.parseInt(request.getParameter("pid")));
		payment.updateReceiptCount(receiptCount+1);
		
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>
             <%-- <tr>
             	<td><b>Total</b></td>
             	<td><%=String.format("%.2f", receivedTotal)%></td>
             	<td></td>
             	<td><%=String.format("%.2f", gstTotal)%></td>
             	<td></td>
             </tr> --%>
             <%-- <tr>
             	<td><b>Due</b></td>
             	<td><%=String.format("%.2f", estimateItem.getAmount()-receivedTotal)%></td>
             	<td></td>
             	<td></td>
             	<td></td>
             </tr>   --%>         	
                        </table>
						</td>
                        <%-- <td class="right">
						<% User user= new User(); %>
                        <%=user.getLoginUserName(estimateItem.getCreatedBy()) %>
						</td> --%>
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

if(request.getParameter("pid")!=null){
int payment_id=Integer.parseInt(request.getParameter("pid"));
%>

<%
Payment payment= new Payment();
%>

<div style="display:inline;color:black;">
<div >Payment Method  :<%=payment.getPaymentMethodByPaymentId(payment_id)%></div>
<%if(payment.getPaymentMethodByPaymentId(payment_id).equalsIgnoreCase("CHEQUE")) {%>
<div style="display:inline">Cheque No :<%=payment.getChecknoWithBankByPaymentId(payment_id)%></div>
<%} %>
</div>

<div style="float:right;color:black;font-weight:bold;margin-top:-25px">
	<%if(null!=addGstFlag && addGstFlag.equalsIgnoreCase("yes")){
		 %>
	<div style="text-align:right;">Total Amount  :
	<%=String.format("%.2f",receivedTotal)%></div>
	<div style="text-align:right;">GST Amount  :
	<%=String.format("%.2f",gstTotal)%></div>
	<%} %>
	<div style="text-align:right;">Received Amount  :
	<%=String.format("%.2f",(receivedTotal+gstTotal))%></div>
</div>
<% } %>
<div style="text-align:center;padding-top:40px"><span>**This is a computer-generated receipt. No signature is required.**</span></div>
</div>
