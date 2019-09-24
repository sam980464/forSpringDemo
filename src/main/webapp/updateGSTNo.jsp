
<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%
Gst gst= new Gst();
String gst_no=gst.getGstDetail();
%>
<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Update GST No</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>GST No</span>
							<div>
								<input type="text" value="<%=gst_no %>" name="gstNo">
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="updateGstNo"> 
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
	</div>
</div>
<!--row-fluid-->
