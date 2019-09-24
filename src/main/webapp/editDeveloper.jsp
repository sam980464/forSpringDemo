<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="com.project.bean.*"%>

<%
String developerId=request.getParameter("developer_id");
Developer developer=new Developer();
ArrayList<DeveloperBean> developerList = new ArrayList<DeveloperBean>();

%>




<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Developer</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="get" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Developer Name</span>
							<div>
								<input type="text" value="<%=developer.getAllDeveloper(developerId).get(0).getDeveloper_name() %>" name="developer_name">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Mobile</span>
							<div>
							<input type="text" name="developer_contactno" value="<%=developer.getAllDeveloper(developerId).get(0).getDeveloper_contactno()%>"/>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Email Id</span>
							<div>
							<input type="text" name="developer_email_id" value="<%=developer.getAllDeveloper(developerId).get(0).getDeveloper_email_id()%>"/>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
							<input type="text" name="developer_address" value="<%=developer.getAllDeveloper(developerId).get(0).getDeveloper_address()%>"/>
							</div>
						</td>
					</tr>
					
					
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="updateDeveloper"> 
					<input type="hidden" name="developer_id" value="<%=request.getParameter("developer_id")%>">
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
