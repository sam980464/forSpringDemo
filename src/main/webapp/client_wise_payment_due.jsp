<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Payment Due  From Client</li>
        </ul>

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
                    <h4 class="widgettitle">Payment Due  From Client </h4>
					<table id="dyntable" class="table table-bordered responsive">
                  
                    <thead>
                        <tr>
                          	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
                            <th class="head0">Client Name</th>
                            <th class="head0">Mobile No</th>
                            <th class="head0">Municipality Name</th>
                            <th class="head0">Ward No</th>
                            <th class="head1">Total Estimate</th>
                            <th class="head0">Total Paid</th>
                            <th class="head1">Total Due</th>
                            <th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<PaymentBO> paymentList=null;
	Iterator<PaymentBO> paymentIt;
	PaymentBO paymentItem;
	try{
		Payment payment= new Payment();
		paymentList=payment.getAllDueResult();
		
		if(paymentList != null){
			paymentIt = paymentList.iterator();
			while(paymentIt.hasNext()){
				paymentItem = (PaymentBO)paymentIt.next();
%>
                    
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td>
                            <%=paymentItem.getSumClientName()%>
                            </td>
                             <td>
                            	<%=paymentItem.getMobile_no()%>
                            </td>
                            
                             <td>
                            	<%=paymentItem.getMunicipality_name()%>
                            </td>
                            <td>
                            	<%=paymentItem.getWard_no()%>
                            </td>
                            <td>
	                            <%=paymentItem.getSumEstimate().intValue()%>
                            </td>
                            <td><%=paymentItem.getSumPaid().intValue()%></td>
                            <td>
                            	<%=paymentItem.getSumUnPaid().intValue()%>
                            </td>
                            <td>
                            	<a href="show_payment_details.jsp?cid=<%=paymentItem.getSumClientId() %>" class="color cboxElement">Details</a>                             	
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
                </div><!--row-fluid-->
                

  <%@ include file="common/foot.jsp" %>