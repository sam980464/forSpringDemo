<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>All Reference</li>
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
                <a href="add_reference.jsp" class="btn btn-inverse alertinverse color"><small>Add Reference</small></a>
                    <h4 class="widgettitle">Reference List </h4>
					<table id="dyntable" class="table table-bordered responsive">
                   
                    <thead>
                        <tr>
                          	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
                            <th class="head0">Name</th>
                            <th class="head1">Status</th>
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<ReferenceBO> referenceList=null;
	Iterator<ReferenceBO> referenceIt;
	ReferenceBO referenceItem;
	try{
		Reference reference= new Reference();
		referenceList=reference.getAllItem();
		
		if(referenceList != null){
	referenceIt = referenceList.iterator();
	while(referenceIt.hasNext()){
		referenceItem = (ReferenceBO)referenceIt.next();
%>		
                    
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td><%=referenceItem.getName()%></td>
                            <td></td>
							<td><b>
								<a href="edit_reference.jsp?id=<%=referenceItem.getId()%>" class="color cboxElement"><!-- <img src="resources/images/edit.png" /> -->Edit</a>
								<a href="ActionServlet?todo=deleteReference&id=<%=referenceItem.getId()%>"  onclick="return confirm('Are you sure?');"><!-- <img src="resources/images/delete.png" /> -->Delete</a>
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