<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="com.project.bean.*"%>

<%
String userId=request.getParameter("id");
AddUser addUser=new AddUser();
addUser.setId(Integer.parseInt(userId));
ArrayList<UserDataBO> userDataList = new ArrayList<UserDataBO>();
UserDataBO userData = addUser.getUserDetailsById().get(0);
%>




<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit User</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Full Name</span>
							<div>
								<input type="text" value="<%=userData.getName() %>"  name="name" required="required">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>User Name</span>
							<div>
								<input type="text" value="<%=userData.getUserid() %>"  name="userName" id="userName" readOnly />
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Role</span>
							<div>
								<select name="role" data-placeholder="Choose a Role"  class="_chzn-select" tabindex="2">
									<%
									try{
										
										ArrayList<AddRoleBO> addRoleList =new AddRole().getAllItem();
										Iterator<AddRoleBO> addRoleIt;
										AddRoleBO addRole;
										if(addRoleList != null){
											addRoleIt = addRoleList.iterator();
											while(addRoleIt.hasNext()){
												addRole = (AddRoleBO)addRoleIt.next();
									%>								
									<option <% if(userData.getRole()==addRole.getId()){out.print("selected='selected'");}  %>  value="<%=addRole.getId()%>"><%=addRole.getRole()%></option>
									<%
										}
									}}
									catch(Exception e){
										
										e.printStackTrace();
									}
									%>
							  </select>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Email Id</span>
							<div>
								<input type="text" value="<%=userData.getEmail() %>"  name="emailId" id="emailId" required="required">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Mobile Number</span>
							<div>
								<input type="text" value="<%=userData.getMobileNo() %>"  name="mobileNumber" required="required">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Password</span>
							<div>
								<input type="text" value="<%=userData.getPassword() %>"  name="password" required="required">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
								<textarea cols="10" rows="5" name="address" id="address" class=""><%=userData.getAddress() %> </textarea>								
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="updateUser"> 
					<input type="hidden" name="user_id" value="<%=request.getParameter("id")%>">
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
