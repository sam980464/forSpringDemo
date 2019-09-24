<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp"%>

<div class="rightpanel">
	<ul class="breadcrumbs">
		<li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span
			class="separator"></span></li>
		<li>Scheme List</li>
	</ul>
	<div class="maincontent">
		<div class="maincontentinner">

			<%
int scheme_id=0;
if (request.getParameter("scheme_child_id") ==null) {
	scheme_id=Integer.parseInt(request.getParameter("scheme_parent_id"));
} else {
	scheme_id=Integer.parseInt(request.getParameter("scheme_child_id"));
}
Scheme schemeRef= new Scheme();



%>
			<div class="widget" id="client_selected">
				<h4 class="widgettitle">
					Scheme  :	<%=schemeRef.getSchemeNameById(scheme_id) %>
				</h4>
				<div class="widgetcontent">
					<div class="alert alert-info">
						<a href="add_new_service_for_scheme.jsp?scheme_id=<%=scheme_id %>"
							class="btn btn-danger alertdanger color"> <small>Add
								New Service</small>
						</a> <a
							href="add_old_service_for_scheme.jsp?scheme_id=<%=scheme_id %>"
							class="btn btn-danger alertdanger color"> <small>Add
								Old Service</small>
						</a> <a class="btn btn-danger alertdanger" onclick="editMe()"> <small>Edit
								Scheme</small>
						</a>
					</div>
					<form action="ActionServlet" method="post">
						<table width="100%" border="1" class="tbl">
							<tr>
								<td><span>Scheme Name</span>
									<div>
										<input type="text" name="scheme_name" class="input-large"
											value="<%= schemeRef.getSchemeNameById(scheme_id)%>" />
									</div>
									<div id="pp">
										&nbsp; <input type="hidden" name="todo" value="updateScheme">
										<input type="hidden" name="id" value="<%=scheme_id %>">
										<button class="btn btn-primary">Save</button>
										<button type="reset" class="btn">Reset Button</button>
										<a class="btn btn-primary onclick=" return confirm('Are you
											sure?');" href="ActionServlet?todo=deleteScheme&amp;id=<%=scheme_id %>">Delete
											Scheme</a>
									</div></td>
							</tr>
						</table>
					</form>


					<div class="widget" id="client_selected">
						<table width="100%" border="1" class="tbl">
							<tr>
								<th><span>Service Name</span></th>
								<th><span>Options</span></th>
							</tr>
<%
ArrayList<SchemeServiceBO> serviceschemeList=null;
Iterator<SchemeServiceBO> serviceschemeIt;
SchemeServiceBO schemeserviceBO;
try{
	SchemeService schemeservice= new SchemeService();
	serviceschemeList=schemeservice.getAllItem(scheme_id);
	
	if(serviceschemeList != null){
		serviceschemeIt = serviceschemeList.iterator();
		while(serviceschemeIt.hasNext()){
			schemeserviceBO = (SchemeServiceBO)serviceschemeIt.next();
%>
							<tr style="border-bottom: 1px solid #ccc;">
								<td><%=schemeserviceBO.getServicename()%></td>
								<td><b> <a class="color"
										href='add_new_supplier_for_service.jsp?scheme_id=<%=request.getParameter("scheme_id") %>&amp;service_id=<%=schemeserviceBO.getServiceId() %>'>Add
											New Suppliers</a> | <a class="color"
										href='add_old_supplier_for_service.jsp?scheme_id=<%=request.getParameter("scheme_id") %>&amp;service_id=<%=schemeserviceBO.getServiceId() %>'>Add
											Existing Suppliers</a> | <a class="color"
										href="supplier_list.jsp?service_id=<%=schemeserviceBO.getServiceId() %>">Suppliers
											List</a> | <a onclick="return confirm('Are you sure?');"
										href="ActionServlet?todo=deleteServiceFromScheme&amp;id=<%=schemeserviceBO.getId()%>">Delete
											Service</a>
								</b></td>
							</tr>
<%	
		}
	}
}
catch(Exception e){
	
	e.printStackTrace();
}
%>



						</table>
					</div>

				</div>
			</div>



			<script type="text/javascript">
				document.getElementById("pp").style.display = "none";
				function editMe() {
					document.getElementById("pp").style.display = "block";
				}
			</script>




			<%@ include file="common/foot.jsp"%></div>
	</div>
</div>