
<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add Mouja</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Mouja Name</span>
							<div>
								<input type="text" value="" name="mouja_name" required="required">
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addMouja"> 
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
	</div>
</div>
<!--row-fluid-->
