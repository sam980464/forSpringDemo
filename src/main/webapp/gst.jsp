<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>GST Master</li>
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
                	<a href="updateGSTNo.jsp" class="btn btn-inverse alertinverse color"><small>Update GST No</small></a>      
                    <h4 class="widgettitle">GST Master</h4>
					<table id="dyntable" class="table table-bordered responsive">
                    <colgroup>
                        <col class="con0" style="align: center; width: 40%" />
                        <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                    </colgroup>
                    <thead>
                        <tr>
                          	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
                            <th class="head1">Scheme Name</th>
                            <th class="head0">GST %</th>
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<SchemeBO> schemeList = null;
	Iterator<SchemeBO> schemeIt;
	SchemeBO schemeBO;
	try {
		Scheme scheme = new Scheme();
		schemeList = scheme.getAllParentItem();

		if (schemeList != null) {
			schemeIt = schemeList.iterator();
			while (schemeIt.hasNext()) {
				schemeBO = (SchemeBO) schemeIt.next();
%>      
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td><%=schemeBO.getSchemeName() %></td>
                            <td><%=schemeBO.getGstValue()  %></td>
							<td><b>
								<a href="updateGstValue.jsp?schema_id=<%=schemeBO.getId() %>" class="color cboxElement">Update</a>  
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