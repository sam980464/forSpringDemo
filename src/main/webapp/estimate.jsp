<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>All Estimate</li>
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
                    <h4 class="widgettitle">Estimate List </h4>
					<table id="dyntable" class="table table-bordered responsive">
                    <!-- <colgroup>
                        <col class="con0" style="align: center; width: 4%" />
                        <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                    </colgroup> -->
                    <thead>
                        <tr>
                          	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
                            <th class="head0">Client Name</th>
                            <th class="head1">For Scheme</th>
                            <th class="head0">Amount</th>
                            <th class="head1">Created By</th>
                            <th class="head0">On Date</th>
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<EstimateBO> estimateList=null;
	Iterator<EstimateBO> estimateIt;
	EstimateBO estimateItem;
	try{
		Estimate estimate= new Estimate();
		estimateList=estimate.getAllItem();
		
		if(estimateList != null){
			estimateIt = estimateList.iterator();
			while(estimateIt.hasNext()){
				estimateItem = (EstimateBO)estimateIt.next();
%>
                    
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td>
                            	<% Client clientname= new Client(); %>
                            	<a href="client_estimate.jsp?cid=<%=estimateItem.getClientId()%>">
                            	<%=clientname.getClientNameById(estimateItem.getClientId())%>
                            	</a>
                            </td>
                            <td>
	                            <% Scheme scheme= new Scheme(); %>
	                            <%=scheme.getSchemeNameById(estimateItem.getSchemeId())%>
                            </td>
                            <td>
                            	<%
								Payment payment= new Payment();
								Double due=payment.getDueByEstimateId(estimateItem.getId());
								%>
                            	
                            	<b><%=estimateItem.getAmount()%></b>
                            	
                            	[Due :<%=due %>]
                            
                            </td>
                            <td>
                            	<% User user= new User(); %>
                            	<%=user.getLoginUserName(estimateItem.getCreatedBy()) %>
                            </td>
                            <td>
                            	<%=estimateItem.getDateCreated()%>

                            </td>
							<td>
								<a href="edit_client.jsp?id=<%=estimateItem.getId()%>" class="color cboxElement"><img src="resources/images/edit.png" /></a>
								<a href="ActionServlet?todo=deleteEstimate&id=<%=estimateItem.getId()%>"  onclick="return confirm('Are you sure?');"><img src="resources/images/delete.png" /></a>
								
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