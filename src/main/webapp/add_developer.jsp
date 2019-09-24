<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add New Developer</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="get" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Developer Name</span>
							<div>
								<input type="text" value="" name="developer_name">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Mobile</span>
							<div>
							<input type="text" value="" name="developer_contactno">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Email Id</span>
							<div>
							<input type="text" value="" name="developer_email_id">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
							<textarea rows="" cols="" name="developer_address"></textarea>
							</div>
						</td>
					</tr>					
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addDeveloper"> 
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
