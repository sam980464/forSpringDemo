<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.ProjectSummeryBean"%>
<%@page import="com.project.dao.ProjectSummeryDao"%>

 <%@ include file="common/head_print_buyer.jsp" %>
    <div class="rightpanel"">

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
<h4 class="widgettitle">Buyer Summary</h4>
            <table class="table table-bordered table-invoice-full">
                <colgroup>
                    <col class="con0 width5" />
                    <col class="con1 width5" />
                    <col class="con0 width5" />
                    <col class="con1 width5" />
                    <col class="con0 width5" />
                    <col class="con1 width20" />
                </colgroup>
                <thead>
                    <tr>
                       <th class="head0">Buyer Name</th>
                        <th class="head0">Estimate Date</th>
                        <th class="head1">Estimate Id</th>
                        <th class="head0">Project Name</th>
                        <th class="head1">Estimated Amount</th>
                        <th class="head0">Amount Received</th>
                         
                    </tr>
                </thead>
                <tbody>
                <%
              
                 ArrayList<ProjectSummeryBean> paymentList=null;
                  ArrayList<ProjectSummeryBean> paymenListBuyer=null;
	              ProjectSummeryBean psbean;
	              ProjectSummeryBean psbean1;
	              int totalEstimate=0;
	              int totalPaid=0;
	              int buyerTotal=0;
	          	ProjectSummeryDao psdao=new ProjectSummeryDao();
	           
	try{
		paymentList=psdao.getSummeryList("buyerTotal",(String) session.getAttribute("project_id"));
		if(paymentList != null){
				for(int i=0;i<paymentList.size();i++){
				psbean = (ProjectSummeryBean)paymentList.get(i);
                 %>
                    <tr>
                        <td><%=psbean.getBuyerName() %></td>
                        <td>
						<%=psbean.getEst_date() %>
						</td>
                        <td class="right">
                        <%=psbean.getEst_id() %>
						</td>
                        <td class="right">
                        <%=psbean.getPro_name() %>
						</td>
                        <td class="right">
                        <%=psbean.getEst_amount() %>
                        	</td>
                        <td class="right">
                        <table width=100%>
                        	<tr>
	                        	<th>Date Received</th>
	                        	<th>Amount</th>
	                        	</tr>
	                        	<%ProjectSummeryDao psdao1=new ProjectSummeryDao();
                        paymenListBuyer=psdao1.getSummeryList("buyerTotalbyId",psbean.getEst_id());
		         totalEstimate+=Float.parseFloat(psbean.getEst_amount());
				for(int j=0;j<paymenListBuyer.size();j++){
				psbean1 = (ProjectSummeryBean)paymenListBuyer.get(j);
				totalPaid+=Float.parseFloat(psbean1.getPamount());
				buyerTotal+=Float.parseFloat(psbean1.getPamount());
         %>
                        	<tr>
	                        	<td><%=psbean1.getPdate() %></td>
	                        	<td><%=psbean1.getPamount() %> </td>
                        	</tr>
                        	<%}
                        	
                        	 %>
             <tr style="color: red;">
             	<td><b>Total</b></td>
             	<td><%=buyerTotal %></td>
             </tr>    </table>
                        
						</td>
                    </tr>
                    <%	buyerTotal=0;}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
  %>
                    
                    </tbody>
                </table>
                <table class="table invoice-table">
                    <tbody>
                        <tr>
                        	<td class="width65 msg-invoice">
          						<h4></h4>
          						<p></p>
                            </td>
                            <td class="width15 right numlist">
                            	<strong>Estimated Amount</strong>
                                <strong>Total Paid</strong>
                                <strong>Total Due</strong>
                             
                            </td>
                            <td class="width20 right numlist">
                                <strong>Rs.<%=totalEstimate %> </strong>
                                <strong>Rs. <%=totalPaid %></strong>
                                <strong>Rs. <%=totalEstimate-totalPaid %> </strong>
                             
                                
                            </td>
                        </tr>
                    </tbody>
          </table>
			
		
</div>	
			
         <%--  <div class="amountdue">
          	<h1><span>Amount Paid:</span>xxx</h1> <br />
            <a href="" class="btn btn-primary btn-large">Pay Invoice</a>
            <a href="client.jsp?cid=<%=cid %>" class="btn btn-primary btn-large">Back To Client </a>
          </div> --%>

  <%@ include file="common/foot.jsp" %>