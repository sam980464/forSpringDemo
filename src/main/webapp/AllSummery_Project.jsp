<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.ProjectSummeryBean"%>
<%@page import="com.project.dao.ProjectSummeryDao"%>

 <%@ include file="common/head_print_pro.jsp" %>
    <div class="rightpanel">
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
		 
		 
        <div class="maincontent">
            <div class="maincontentinner">
                <div class="row-fluid">    
                    
                    <div class="span6">
                        <div class="invoice_logo"><img width="150px" src="resources/images/comlogo.png" alt="" class="img-polaroid" /></div>
                  
                       
                    </div><!--span6-->
            
                    <div class="span6">
                        <table class="table table-bordered table-invoice">
                            <tr>
                                <td class="width30">Project Name:</td>
                                <td class="width70"><strong><%=session.getAttribute("project_name").toString() %></strong></td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td><%=session.getAttribute("project_address").toString() %></td>
                            </tr>
                        </table>
                </div><!--span6-->
            </div>
            
<div id="exportCSV">
<h4 class="widgettitle">Project Summary</h4>
            <table class="table table-bordered table-invoice-full">
                <colgroup>
                    <col class="con0 width12" />
                    <col class="con1 width12" />
                    <col class="con0 width12" />
                    <col class="con1 width12" />
                    <col class="con0 width12" />
                </colgroup>
                <thead>
                    <tr>
                        <th class="head0">Total Investment</th>
                        <th class="head1">Buyer Payment</th>
                        <th class="head0">Total Expense</th>
                        <th class="head1">Total Refund</th>
                        <th class="head1">Miscellaneous</th>
                        <th class="head0">Profit Summary</th>
                    </tr>
                </thead>
                <tbody>
               
                    <tr>
                        <td>
                        <table width=100%>
                        	<tr>
	                        	<th>Date Received</th>
	                        	<th>Amount</th>
                        	</tr>
                        		<%
                        		float receivedTotal=0;
                     	float totalInvested=0;
	               float promisedRefunded=0;
	               float totalExpense=0;
	               float totalRefund=0;
	               float misP=0;
	             ArrayList<ProjectSummeryBean> paymentList=null;
	              ProjectSummeryBean psbean;
	          	ProjectSummeryDao psdao=new ProjectSummeryDao();
	
	try{
		paymentList=psdao.getSummeryList("buyerInv",session.getAttribute("project_id").toString());
		if(paymentList != null){
				for(int i=0;i<paymentList.size();i++){
				psbean = (ProjectSummeryBean)paymentList.get(i);
				totalInvested+=Float.parseFloat(psbean.getInvested_amount());
				promisedRefunded+=Float.parseFloat(psbean.getPromised_refund_amount());
%>      <tr><td><%=psbean.getInvested_date() %></td><td><%=psbean.getInvested_amount() %></td></tr>
	                        	<%	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>  
                        	<tr style="color: red;"><td><b>Total:</b></td><td><%=totalInvested %></td></tr>
                        	</table>
                        </td>
                        <td>
						<table width=100%>
                        	<tr>
                        	    <th><b>Buyer</b></th>
	                        	<th><b>Date Received</b></th>
	                        	<th><b>Amount</b></th>
	                        	</tr>
	                        	<%
	try{
		paymentList=psdao.getSummeryList("buyer",session.getAttribute("project_id").toString());
		if(paymentList != null){
				for(int i=0;i<paymentList.size();i++){
				psbean = (ProjectSummeryBean)paymentList.get(i);
				receivedTotal+=Float.parseFloat(psbean.getPamount());
%>                        	
	                        	<tr>
	                        	<td><%=psbean.getBuyerName() %></td>
	                        	 <td><%= psbean.getPdate() %> </td>
	                        	 <td><%=psbean.getPamount() %></td>
	                        	</tr>
	            <%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
	float estimateAmount=Float.parseFloat(psdao.getSummeryList("buyerEst",session.getAttribute("project_id").toString()).get(0).getBuyerEstimate());
%>
	                        	<tr style="color: red;"><td></td><td><b>Total:</b></td><td><%=receivedTotal %></td></tr>
	                        	<tr style="color: red;"><td></td><td><b>Estimated:</b></td><td><%=estimateAmount %></td></tr>
	                        	<tr style="color: red;"><td></td><td><b>Due:</b></td><td><%=(estimateAmount-receivedTotal) %></td></tr>
                        	</table>
						</td>
                        <td class="right">
						<table width=100%>
                        	<tr>
	                        	<th>Date Received</th>
	                        	<th>Amount</th>
	                        	</tr>
	                        	<%
	try{
		paymentList=psdao.getSummeryList("totalExpense",session.getAttribute("project_id").toString());
		if(paymentList != null){
				for(int i=0;i<paymentList.size();i++){
				psbean = (ProjectSummeryBean)paymentList.get(i);
				totalExpense+=Float.parseFloat(psbean.getExpense_amount());
%>      <tr><td><%=psbean.getExpense_date() %></td>
              <td><%=psbean.getExpense_amount() %></td>
              </tr>
 <%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
	%>
	                        
	                        	      <tr style="color: red;"><td><b>Total:</b></td><td><%=totalExpense %></td></tr>
                        	</table>
                        	</td>
                        <td class="right">
						<table width=100%>
                        	<tr>
	                        	<th>Date Received</th>
	                        	<th>Amount</th>
	                        	</tr>
	                        		<%
	try{
		paymentList=psdao.getSummeryList("totalRefund",session.getAttribute("project_id").toString());
		if(paymentList != null){
				for(int i=0;i<paymentList.size();i++){
				psbean = (ProjectSummeryBean)paymentList.get(i);
				totalRefund+=Float.parseFloat(psbean.getRefund_amount());
%>      <tr>
<td><%=psbean.getRefunded_date() %></td><td><%=psbean.getRefund_amount() %></td>
</tr>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
	%>

	                        	<tr style="color: red;"><td><b>Total Refund:</b></td><td><%=totalRefund %></td></tr>
	                        	<tr style="color: red;"><td><b>Promised Amnt:</b></td><td><%=promisedRefunded %></td></tr>
	                        	<tr style="color: red;"><td><b>Due :</b></td><td><%=promisedRefunded-totalRefund %></td></tr>
                        	</table></td>
                         <td class="right">
                      <%String misI="";
                      String mis="";
                      
                      paymentList=psdao.getSummeryList("misI",session.getAttribute("project_id").toString());
                      misI=paymentList.get(0).getMisI();
                      paymentList=psdao.getSummeryList("mis",session.getAttribute("project_id").toString());
                      mis=paymentList.get(0).getMis();
                      misP=Float.parseFloat(misI)-Float.parseFloat(mis);
		 %>  
                        <table width=100%>
                        	<tr>
	                        	<td><b>Income:</b></td>
	                        	<td style="color: red;"><%=misI %></td>
	                         	</tr>
	                         	<tr>
	                        	<td><b>Expense:</b></td>
	                        	<td style="color: red;"><%=mis %></td>
	                         	</tr>
                        </table>
						</td>
                        
                        
                        <td class="right">
                        
                        <table width=100%>
                        	<tr>
	                        	<td><b>Profit Till Date:</b></td>
	                        	<td style="color: red;"><%=totalInvested+receivedTotal-totalExpense-totalRefund+misP %></td>
	                         	</tr>
	                         	<tr>
	                        	<td><b>Estimate Profit:</b></td>
	                        	<td style="color: red;"><%=totalInvested+estimateAmount-totalExpense-promisedRefunded %></td>
	                         	</tr>
                        </table>
						</td>
                        
                        
                        <td class="right">
						</td>
                    </tr>
                    
                    </tbody>
                </table>
</div>                

                <table class="table invoice-table">
                    <tbody>
                        <tr>
                        	<td class="width65 msg-invoice">
          						<h4></h4>
          						<p></p>
                            </td>
                            <td class="width15 right numlist">
                            	<strong>Invested Amount</strong>
                                <strong>Buyer Payment</strong>
                                <strong>Total Expense</strong>
                                <strong>Total Refund</strong>
                                <strong>Misc Profit</strong>
                                 <strong>Profit</strong>
                            </td>
                            <td class="width20 right numlist">
                                <strong>Rs.<%= totalInvested%></strong>
                                <strong>Rs.<%=receivedTotal%></strong>
                                <strong>Rs.<%=totalExpense %></strong>
                                <strong>Rs.<%=totalRefund %></strong>
                                <strong>Rs.<%=misP %></strong>
                                <strong>Rs.<%=totalInvested+receivedTotal-totalExpense-totalRefund+misP%></strong>
                                
                            </td>
                        </tr>
                    </tbody>
          </table>
			
		
	
			
         <%--  <div class="amountdue">
          	<h1><span>Amount Paid:</span>xxx</h1> <br />
            <a href="" class="btn btn-primary btn-large">Pay Invoice</a>
            <a href="client.jsp?cid=<%=cid %>" class="btn btn-primary btn-large">Back To Client </a>
          </div> --%>

  <%@ include file="common/foot.jsp" %>