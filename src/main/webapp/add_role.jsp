<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add Role</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Role Name</span>
							<div>
								<input type="text" value="" name="roleName" required="required">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Role Description</span>
							<div>
								<textarea cols="10" rows="5" name="roleDescription" id="roleDescription" class=""></textarea>
								
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addRole"> 
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
