<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>All Office Expenses Item</li>
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
                <%
				if (session.getAttribute("message")!=null){
				%>
				<div class="alert alert-info" style="background-color:yellow">
				<%=session.getAttribute("message") %>
				<% session.setAttribute("message",null); %>
				</div>
				<% } %> 
                <a href="add_office_expenses_item.jsp" class="btn btn-inverse alertinverse color"><small>Add Item</small></a>
                    <h4 class="widgettitle"> Office Expenses Item List</h4>
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
                            <th class="head0">Name</th>                            
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<OfficeExpensesItemBO> officeExpensesItemList=null;
	Iterator<OfficeExpensesItemBO> officeExpensesItemIt;
	OfficeExpensesItemBO officeExpensesItemBO;
	try{
		OfficeExpensesItem officeExpensesItem= new OfficeExpensesItem();
		officeExpensesItemList=officeExpensesItem.getAllItem();
		
		if(officeExpensesItemList != null){
			officeExpensesItemIt = officeExpensesItemList.iterator();
	while(officeExpensesItemIt.hasNext()){
		officeExpensesItemBO = (OfficeExpensesItemBO)officeExpensesItemIt.next();
%>		
                    
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td><%=officeExpensesItemBO.getItemName()%></td>
                            
							<td><b>
								<a href="edit_office_expenses_item.jsp?id=<%=officeExpensesItemBO.getId()%>" class="color cboxElement"><!-- <img src="resources/images/edit.png" /> -->Edit</a>
								<a href="ActionServlet?todo=deleteOfficeExpensesItem&id=<%=officeExpensesItemBO.getId()%>"  onclick="return confirm('Are you sure?');"><!-- <img src="resources/images/delete.png" /> -->Delete</a>
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