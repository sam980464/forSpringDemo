
<%@page import="com.project.dao.AddBuyerToProject"%>
<%@page import="com.project.bean.AddBuyerToProjectBean"%><title>
RTECH   -  Payment Received
</title>
<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.*"%>
<link rel="stylesheet" href="resources/css/style.css" type="text/css" />
<%
String pid= request.getParameter("pid");
%>

<script type="text/javascript" src="resources/js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="resources/js/jquery.print.js" ></script>

<script type="text/javascript">
    $(function() {
    	window.print();
	});
</script>

<div id="printdiv" class="printable">

	<img src="resources/images/plogo.png" alt="" style="width: 100%; height: 99px;" />
	<hr>
	By  &nbsp;<b><%=session.getAttribute("userName") %></b>
<%
//Date date = new Date();
//out.print( "<h2 align=\"center\">" +date.toString()+"</h2>");
%>

<h4 class="widgettitle">Payment Received Copy</h4>
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
                        <th class="head1">Payment Id</th>
                         <th class="head0">Buyer Name</th>
                        <th class="head1">Estimated Amount</th>
                        <th class="head0">Amount Received</th>
                         <th class="head0">Estimated By</th>
                    </tr>
                </thead>
                <tbody>
<%
	ArrayList<AddBuyerToProjectBean> paymentList=null;
	Iterator<AddBuyerToProjectBean> paymentIt;
	AddBuyerToProjectBean paymentItem;
	
		AddBuyerToProject payment= new AddBuyerToProject();
		paymentList=payment.getPaymentList(pid,(String)session.getAttribute("project_id"));
		
 if(paymentList.size()!=0){
			paymentIt = paymentList.iterator();
			while(paymentIt.hasNext()){
				paymentItem = (AddBuyerToProjectBean)paymentIt.next();
				
%>                
                    <tr>
                        <td><%= paymentItem.getBuyer_estimate_date()%></td>
                        <td><%= paymentItem.getPayment_id()%></td>
                        <td class="right">
						
	                    <%=paymentItem.getBuyer_name()%>
						</td>
                        <td class="right">
						<%=paymentItem.getBuyer_estimate_amount() %>
						</td>
                        
                        
                        <td class="right">
                        
                        <table width=100%>

             <tr>
             	<td><b>Total</b></td>
             	<td><%= paymentItem.getPaidamount()%></td>
             	<td></td>
             </tr>
             <tr>
             	<td><b>Due</b></td>
             	<td><%=Integer.parseInt(paymentItem.getBuyer_estimate_amount())-Integer.parseInt(paymentItem.getPaidamount()) %></td>
             	<td></td>
             </tr>           	
                        </table>
						</td>
                        <td class="right">
                        <%=session.getAttribute("userName") %>
						</td>
                    </tr>
<%
	}
	}
%>
                    
                    </tbody>
                </table>
             




</div>
