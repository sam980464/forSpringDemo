<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head_print.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Print <span class="separator"></span></li>
            <li>Invoice </li>
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
                    
                    <div class="span6">
                        <div class="invoice_logo"><img src="resources/images/comlogo.png" alt="" class="img-polaroid" /></div>
                  
                        <table class="table table-bordered table-invoice">
                            <tr>
                                <td class="width30">Invoice For:</td>
                                <td class="width70"><strong>xx</strong></td>
                            </tr>
                            <tr>
                                <td>Payment ID:</td>
                                <td>P-</td>
                            </tr>
                            <tr>
                                <td>Estimate ID:</td>
                                <td>E-</td>
                            </tr>
                        </table>
                    </div><!--span6-->
            
                    <div class="span6">
                        <table class="table table-bordered table-invoice">
                            <tr>
                                <td class="width30">From:</td>
                                <td class="width70">
                                    <strong>RTECH</strong> <br />
                                    Makes Dream Real <br />
                                    Address<br />
                                    <b>Received By:</b> <%=session.getAttribute("userName") %><br />
                                    Email:
                                    <%=session.getAttribute("id") %>
                                </td>
                            </tr>
                        </table>
    
                </div><!--span6-->
            </div>
            
            <table class="table table-bordered table-invoice-full">
                <colgroup>
                    <col class="con0 width15" />
                    <col class="con1 width45" />
                    <col class="con0 width5" />
                    <col class="con1 width15" />
                    <col class="con0 width20" />
                </colgroup>
                <thead>
                    <tr>
                        <th class="head0">Payment ID</th>
                        <th class="head1">For  Scheme</th>
                        <th class="head0 right">Amount Estimate</th>
                        <th class="head1 right">Amount Payment</th>
                        <th class="head0 right">Amount Due</th>
                    </tr>
                </thead>
                <tbody>
                

                
                    <tr>
                        <td></td>
                        <td></td>
                        <td class="right">
                        
                        </td>
                        <td class="right">
                        
                        </td>
                        <td class="right">
                         
                        </td>
                    </tr>
                      
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
                            	  <strong>Estimate</strong>
                                <strong>Paid Now</strong>
                                <strong>Due</strong>
                            </td>
                            <td class="width20 right numlist">
                                <strong>Rs. </strong>
                                <strong>Rs. </strong>
                                <strong>Rs.  </strong>
                            </td>
                        </tr>
                    </tbody>
          </table>
			
          <div class="amountdue">
          	<h1><span>Amount Paid:</span></h1> <br />
            <a href="" class="btn btn-primary btn-large">Pay Invoice</a>
            <a href="client.jsp?cid=" class="btn btn-primary btn-large">Back To Client </a>
          </div>

  <%@ include file="common/foot.jsp" %>