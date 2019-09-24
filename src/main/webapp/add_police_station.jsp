<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add Police Station</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Police Station Name</span>
							<div>
								<input type="text" value="" name="police_station_name" required="required">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
								<input type="text" value="" name="police_station_address" >
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addPoliceStation"> 
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
