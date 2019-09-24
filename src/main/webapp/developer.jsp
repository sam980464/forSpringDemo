<%@page import="com.project.bean.*" %>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.dao.Developer"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li> Master</li>
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
                 <a href="add_developer.jsp" class="btn btn-inverse alertinverse color"><small>Add Developer</small></a>
                    <h4 class="widgettitle">Developer Master</h4>
					<table id="dyntable" class="table table-bordered responsive">
                    <colgroup>
                        <col class="con0" style=" width: 20%" />
                        <col class="con1" style=" width: 20%"/>
                        <col class="con0" style=" width: 20%" />
                        <col class="con1" style=" width: 20%"/>
                        <col class="con0" style=" width: 10%"/>
                        <col class="con1" style=" width: 10%"/>
                    </colgroup>
                    <thead>
                        <tr>
                          	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
                            <th class="head0">Developer Name</th>
                            <th class="head1">Address</th>
                            <th class="head1">Contact No.</th>
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<DeveloperBean> developerList=null;
	Iterator<DeveloperBean> developerIt;
	DeveloperBean developerItem;
	try{
		Developer developer= new Developer();
		developerList=developer.getAllDeveloper("all");
		
		if(developerList != null){
			developerIt = developerList.iterator();
			while(developerIt.hasNext()){
				developerItem = (DeveloperBean)developerIt.next();
%>       
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td><%=developerItem.getDeveloper_name() %></td>
                            <td><%=developerItem.getDeveloper_address() %></td>
                            <td><%=developerItem.getDeveloper_contactno() %></td>
							<td><b>
								<a href="editDeveloper.jsp?developer_id=<%=developerItem.getDeveloper_id() %>" class="color cboxElement">Edit <img width="15" height="12" src="resources/images/edit.png" /></a>  |
								<a href="ActionServlet?todo=deleteProAttrib&id=<%=developerItem.getDeveloper_id() %>&flag=devep"  onclick="return confirm('Are you sure?');">Delete <img width="15" height="12" src="resources/images/delete.png" /></a>
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