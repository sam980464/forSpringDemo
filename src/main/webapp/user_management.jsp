<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Police Station Master</li>
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
                <a href="add_role.jsp" class="btn btn-inverse alertinverse color"><small>Add New Role</small></a>
                <a href="add_user.jsp" class="btn btn-inverse alertinverse color"><small>Add User</small></a>
                <a href="role_permissions.jsp" class="btn btn-inverse alertinverse color"><small>Role & Permission</small></a>
                    <h4 class="widgettitle">User Management</h4>
					<table id="dyntable" class="table table-bordered responsive">
                    
                    <thead>
                        <tr>
                          	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
                            <th class="head0">Full Name</th>
                            <th class="head0">User Name</th>
                            <th class="head0">Mobile Number</th>
                            <th class="head0">Address</th>                          
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<UserDataBO> userDataList=null;
	Iterator<UserDataBO> userDataIt;
	UserDataBO userDataBO;
	try{
		AddUser addUser= new AddUser();
		userDataList=addUser.getAllUserDetails();
		if(userDataList != null){
			userDataIt = userDataList.iterator();
			while(userDataIt.hasNext()){
				userDataBO = (UserDataBO)userDataIt.next();
%>       
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td><%=userDataBO.getName() %></td>
                            <td><%=userDataBO.getUserid() %></td>
                            <td><%=userDataBO.getMobileNo() %></td>
                            <td><%=userDataBO.getAddress() %></td>
							<td><b>
								<a href="editUser.jsp?id=<%=userDataBO.getId() %>" class="color cboxElement">Edit<!-- <img src="resources/images/edit.png" /> --></a><%if(!userDataBO.getUserid().equals("admin")){ %>  |
								
								<a href="ActionServlet?todo=deleteUser&id=<%=userDataBO.getId() %>"  onclick="return confirm('Are you sure?');">Delete</a>
								<%} %>
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