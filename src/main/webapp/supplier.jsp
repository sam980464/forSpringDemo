<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
 <%@ include file="common/head.jsp" %>
<div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>All Supplier</li>
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
                    <h4 class="widgettitle">All Supplier </h4>
					<table id="dyntable" class="table table-bordered responsive">
                   <!--  <colgroup>
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
                            <th class="head0">Company Name1</th>
                            <th class="head1">Address</th>
							<th class="head0">Phone Number</th>
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>
<%
	ArrayList<SupplierBO> supplierList=null;
	Iterator<SupplierBO> supplierIt;
	SupplierBO supplierItem;
	try{
		Supplier supplier= new Supplier();
		supplierList=supplier.getAllItem();
		
		if(supplierList != null){
			supplierIt = supplierList.iterator();
			while(supplierIt.hasNext()){
				supplierItem = (SupplierBO)supplierIt.next();
%>
                    
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td><%=supplierItem.getSupplierName() %></td>
                            <td><%=supplierItem.getAddress() %></td>
                            <td><%=supplierItem.getPhone() %></td>
							<td><b>
								<a class="color cboxElement" href="edit_supplier.jsp?supplier_id=<%=supplierItem.getId() %>">Edit </a>|
								<a class="color cboxElement" href="allDue.jsp?supplier_id=<%=supplierItem.getId() %>">Due Status</a> |
								Delete
								</b>
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