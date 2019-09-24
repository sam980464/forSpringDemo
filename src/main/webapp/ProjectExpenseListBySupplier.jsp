<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.*"%>
 <%@ include file="common/head.jsp" %>
 <%
 ProjectDAO pdao=new ProjectDAO();
  %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>All Client</li>
        </ul>
<!-- <script type="text/javascript">
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
    

</script>  -->       
<div class="maincontent">
<div class="maincontentinner">
<% 
ArrayList<Project> itemPartList=null;
Iterator<Project> clientIt2;
Project clientItem;
Project pro_details=null;
%>
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Choose Supplier To View Payment Details</h4>
         <div class="widgetcontent">
             <form class="stdform stdform2" action="" method="get">
<p>
<select name="sup_id" data-placeholder="Choose a Project" style="width:350px" class="_chzn-select" tabindex="2">
<%
  pdao=new ProjectDAO();
                            ArrayList<SupplierBO> suplist=pdao.getProjectSupplierList((String)session.getAttribute("project_id"));
                             for(int i=0;i<suplist.size();i++){
                             %>
                             <option value="<%=suplist.get(i).getId() %>"><%=suplist.get(i).getSupplierName() %>/<%=suplist.get(i).getAddress() %></option>
                             <%} %>
        </select>
<input type="submit" class="alertdanger btn btn-danger alertdanger" value="Get Payment Details"/>
 </p>   
 <p><a href="projects.jsp?proid=<%=session.getAttribute("project_id") %>" class="alertdanger btn btn-danger alertdanger">Project Dashboard</a></p>
    </form>
</div><!--widgetcontent-->
</div>
<% if(request.getParameter("sup_id")!=null){ %>
<h4 class="widgettitle"><b>Project Expense List</b></h4>
<table id="" class="" width="900px">
         <tr>
             <th class="head0">Bill No</th>
             <th></th>
             <th class="head0">Expense ID</th>
             <th class="head0">Supplier Name</th>
             <th class="head1">Expensed Amount</th>
             <th class="head1">Total Paid Amount</th>
             <th class="head0">Expensed Date</th>
			<th class="head1">Option</th>
         </tr>
<tbody>
<%
 ArrayList<ArrayList<String>> expenseDetails= pdao.getExpensePaymentList((String)session.getAttribute("project_id"),request.getParameter("sup_id"));
 for(int i=0;i<expenseDetails.size();i++){
 %>
                        <tr class="gradeX">
                            <td>
                          <a href="addExpenseWithBill.jsp?sup_id=<%=expenseDetails.get(i).get(7) %>&bill_no=<%=expenseDetails.get(i).get(0) %>"><%=expenseDetails.get(i).get(0) %></a> 	
                            </td>
                            <td></td>
                         <td>
                          <a href="editProjectExpense.jsp?exp_id=<%=expenseDetails.get(i).get(1) %>&exp_amount=<%=expenseDetails.get(i).get(3) %>&bill_no=<%=expenseDetails.get(i).get(0) %>&sup_id=<%=expenseDetails.get(i).get(7) %>" class="color cboxElement"><!-- <img src="resources/images/edit.png" /> -->EXP_00<%=expenseDetails.get(i).get(1) %></a>                     
                         </td>
                            <td>
                              <%=expenseDetails.get(i).get(2) %> 	
                            </td>
                            <td>
	                          <%=expenseDetails.get(i).get(3) %>
                            </td>
                            <td>
                              <%=expenseDetails.get(i).get(4) %>[Due: <%=Float.parseFloat(expenseDetails.get(i).get(3))-Float.parseFloat(expenseDetails.get(i).get(4)) %>]
                            </td>
                            <td>
                            <%=expenseDetails.get(i).get(5) %>
                            </td>
                           <!--  <td>
                            <%=expenseDetails.get(i).get(6) %>
                            </td>
                             -->
							<td>
							<b> 
								<a Title="Payment" href="ProjectSupplierPayment.jsp?exp_id=<%=expenseDetails.get(i).get(1) %>&sup_id=<%=expenseDetails.get(i).get(7) %>&exp_amount=<%=expenseDetails.get(i).get(3) %>&total_amount=<%=expenseDetails.get(i).get(4) %>&due_amount=<%=Float.parseFloat(expenseDetails.get(i).get(3))-Float.parseFloat(expenseDetails.get(i).get(4)) %>&bill_no=<%=expenseDetails.get(i).get(0) %>&p_id=<%=expenseDetails.get(i).get(6)%>" class="color cboxElement">Pay</a> | 
								<a Title="Payment History" href="ProjectSupplierPaymentHistory.jsp?exp_id=<%=expenseDetails.get(i).get(1) %>" class="color cboxElement">History</a> 
							</b>
							</td>
                        </tr>
  <%} }%>
                    </tbody> 
                </table>
                <%@ include file="common/foot.jsp" %>