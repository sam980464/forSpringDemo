<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Order List To Supplier</li>
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
    
    
    
    
   

</script>        
		 
        <div class="maincontent">
            <div class="maincontentinner">
                <div class="row-fluid">
                <a href="add_order_to_supplier.jsp" class="btn btn-inverse alertinverse color"><small>Add Order To Supplier</small></a>
                    <h4 class="widgettitle">Order List To Supplier</h4>
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
                            <th class="head0">For Client</th>
                            <th class="head1">For Scheme</th>
                            <th class="head0">Total Amount</th>
                            <th class="head1">For  Item</th>
                            <th class="head0">To Company</th>
                            <th class="head0">Date</th>
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<ExpensesBO> expensesList=null;
	Iterator<ExpensesBO> expIt;
	ExpensesBO expensesBO;
	try{
		Expenses expenses= new Expenses();
		expensesList=expenses.getAllItem();
		
		if(expensesList != null){
			expIt = expensesList.iterator();
			while(expIt.hasNext()){
				expensesBO = (ExpensesBO)expIt.next();
%>
                    
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td><a href="">
                            <%
                            Client client=new Client();
                            %>
                            <%=client.getClientNameById(expensesBO.getClientId()) %>
                            
                            </a></td>
                            <td>
                            <%
                            Scheme scheme= new Scheme();
                            %>
                            <%= scheme.getSchemeNameByEstimateId(expensesBO.getEstimateId())%>
                            </td>
                            <td><%=expensesBO.getTotalAmount()%></td>
                            <td>
                            <%
                            Item item = new Item();
                            %>
                            <%= item.getItemNameById(expensesBO.getItemId())%>
                            
                            </td>
                             <td><%=expensesBO.getSupplierId()%>
                             
                             </td>
                            <td><%=expensesBO.getExpDate()%></td>
							<td>
								<a href="edit_order.jsp?id=<%=expensesBO.getId()%>" class="color cboxElement"><img src="resources/images/edit.png" /></a>
								<a href="ActionServlet?todo=deleteOrderSupplier&id=<%=expensesBO.getId()%>"  onclick="return confirm('Are you sure?');"><img src="resources/images/delete.png" /></a>
								
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