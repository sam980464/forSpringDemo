<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add New Service For Scheme</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Service Name</span>
							<div>
								<input type="text" value="" name="s_name">
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addNewService"> 
					<input type="hidden" name="scheme_id" value="<%=request.getParameter("scheme_id") %>" >
					<button class="btn btn-primary">Add</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
