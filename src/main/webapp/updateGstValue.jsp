<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<%
int id=Integer.parseInt(request.getParameter("schema_id"));
Scheme scheme= new Scheme();
String scheme_name=scheme.getSchemeNameById(id);
int gst_amount = scheme.getGstValueById(id);
%>



<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Update GST  :<%=scheme_name %></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>GST Value (%)</span>
							<div>
								<input type="text" value="<%=gst_amount %>" name="gst_amount" required="required">
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="updateGstAmount"> 
					<input type="hidden" name="schema_id" value="<%= request.getParameter("schema_id") %>">
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
