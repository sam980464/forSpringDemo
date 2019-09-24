<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Role & Permission</h4>
		<div class="widgetcontent nopadding">
			<form  method="post" action="ActionServlet">
				
				<div style="margin-top:15px;">
					<span style="margin-left:100px;">Role</span>
					<select name="roleId" id="roleId" data-placeholder="Choose a Role"  style="margin-right:50px" class="_chzn-select" tabindex="2"  onchange="loadPermission()" >
					<option value="0">Select Role</option>
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
						<option value="<%=addRole.getId()%>"><%=addRole.getRole()%></option>
						<%
							}
						}}
						catch(Exception e){
							
							e.printStackTrace();
						}
						%>
				  </select>
				</div>
				<br />
				
				<table width="100%" border="1" class="table table-bordered tbl">
					<thead>
                        <tr>
                          	
                            <th class="head0">Page Name</th>                                                 
							<th class="head1">Permission</th>
                        </tr>
                    </thead>
                    <tbody>
					<tr>
						<td>
							<div>
								<label for="Clients Dashboard">Clients Dashboard                                     .</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="client.jsp" name="permissionPage" id="client_jsp" >
							</div>
						</td>
					</tr>
					
					<tr>						
						<td>
							<div>
								<label for="Scheme Dashboard">Scheme Dashboard</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="scheme.jsp" name="permissionPage" id="scheme_jsp" >
							</div>
						</td>
					</tr>
					
					<tr>						
						<td>
							<div>
								<label for="Reference Master">Reference Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="reference.jsp" name="permissionPage" id="reference_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Supplier Master">Supplier Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="supplier.jsp" name="permissionPage" id="supplier_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Municipality Master">Municipality Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="municipality.jsp" name="permissionPage" id="municipality_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Bank Master">Bank Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="bank.jsp" name="permissionPage" id="bank_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Office Expenses Master">Office Expenses Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="office_expenses.jsp" name="permissionPage" id="office_expenses_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Mouja Master">Mouja Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="mouja.jsp" name="permissionPage" id="mouja_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Police Station Master">Police Station Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="police_station.jsp" name="permissionPage" id="police_station_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="District  Master">District  Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="district.jsp" name="permissionPage" id="district_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Report By Scheme">Report By Scheme</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="report_by_scheme.jsp" name="permissionPage" id="report_by_scheme_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Report By Supplier">Report By Supplier </label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="report_by_supplier_select.jsp" name="permissionPage" id="report_by_supplier_select_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Projects">Projects</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="projects.jsp" name="permissionPage" id="projects_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Investor Master">Investor Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="investor.jsp" name="permissionPage" id=""investor_jsp"" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Buyer Master">Buyer Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="buyer.jsp" name="permissionPage" id="buyer_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="GST Master">GST Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="gst.jsp" name="permissionPage" id="gst_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Gst Report By Scheme">Gst Report By Scheme</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="gst_report_by_scheme.jsp" name="permissionPage" id="gst_report_by_scheme_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Developer Master">Developer Master</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="developer.jsp" name="permissionPage" id="developer_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="Email Sender">Email Sender</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="emailSender.jsp" name="permissionPage" id="emailSender_jsp" >
							</div>
						</td>
					</tr>
					<tr>						
						<td>
							<div>
								<label for="User Management">User Management</label>
							</div>
						</td>
						<td>
							<div>
								<input type="checkbox" value="user_management.jsp" name="permissionPage" id="user_management_jsp" >
							</div>
						</td>
					</tr>
					</tbody>
					
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addRolePermission"> 
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
 <script type="text/javascript">
  function loadPermission() {
	  var roleId= document.getElementById("roleId").value;
	  var xmlhttp;
	 	if (window.XMLHttpRequest)
	 	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	 	  xmlhttp=new XMLHttpRequest();
	 	  }
	 	else
	 	  {// code for IE6, IE5
	 	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	 	  }
	 	xmlhttp.onreadystatechange=function()
	 	  {
	 	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 	    {
	 		 	var response = xmlhttp.responseText;
	 		 	var str_array = response.split(',');

	 		 	for(var i = 0; i < str_array.length; i++) {
	 		 	   // Trim the excess whitespace.
	 		 	   str_array[i] = str_array[i].replace(/^\s*/, "").replace(/\s*$/, "");
	 		 	   // Add additional code here, such as:
	 		 	 if(str_array[i] && str_array[i].length>0){
	 		 		var checkboxId = str_array[i].replace(".","_"); 
	 		 		 
	 		 		document.getElementById(checkboxId).checked = true;
	 		 		
	 		 	 }	   
	 		 	  
	 		 	}
	 		 	console.log(response);
	 	    }
	 	  }
	 	xmlhttp.open("GET","ActionServlet?todo=getPermissionByRoleId&roleId="+roleId,true);
	 	xmlhttp.send();
	 
  }
 </script>
<!--row-fluid-->
