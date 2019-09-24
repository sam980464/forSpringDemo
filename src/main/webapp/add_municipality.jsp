<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add Municipality</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Municipality Name</span>
							<div>
								<input type="text" value="" name="m_name">
							</div></td>
						<td><span>Status</span>
							<div>
							<select name="m_status">
								<option value="1">Enable</option>
								<option value="0">Disable</option>
							</select>
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addMunicipality"> <input
						type="hidden" name="userid"
						value='<%=session.getAttribute("id")%>'>
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
