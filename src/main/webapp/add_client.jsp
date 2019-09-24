<%@page import="com.project.bean.DeveloperBean"%>
<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>

<%@page import="java.util.*"%>
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>

<h4 class="widgettitle">Add Client</h4>
 <form class="stdform stdform2" method="post" action="ActionServlet">
					<table width="100%" border="1" class="tbl">
					  <tr>
						<td colspan=2>
							<span>Name</span>
							<div>
							<select name="mr_ms" id="selection2" class="uniformselect" required="required">
							<option value="">Choose One</option>
							<option value="Mr">Mr</option>
							<option value="Mrs">Mrs</option>
							<option value="Ms">Ms</option>
							<option value="Md">Md</option>
							<option value="Sri">Sri</option>
							<option value="Sekh">Sekh</option>
							<option value="Smt">Smt</option>
							<option value="M/S">M/S</option>
							</select>
							<input type="text" name="name" id="name" class="input-xxlarge" required="required" />
							</div>
						</td>
						</tr>
						<tr>
							<td colspan=2>
								<span>Guardian's Name</span>
								<div>
								<select name="gar_rel" id="selection2" class="uniformselect">
								<option value="0">Choose One</option>
								<option value="SON">SON</option>
								<option value="WIFE">WIFE</option>
								<option value="HUSBAND">HUSBAND</option>
								<option value="DAUGHTER">DAUGHTER</option>
								</select>
								<input type="text" name="gar_name" id="name" class="input-xxlarge"/>
								</div>
							</td>
					  </tr>
					  <tr>
						<td>
							<span>Present Address</span>
							<div>
							<textarea cols="80" rows="5" name="present_addr" id="location2" class=""></textarea>
							</div>
						</td>
						<td>
							<span>Permanent Address</span>
							<div>
							<textarea cols="80" rows="5" name="per_addr" id="location2" class=""></textarea>
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Municipality</span>
							<div>
							<select style="width:290px" name="municipality" id="selection2" class="uniformselect" required="required" >
								<option value="0">Select Municipality</option>
								
<%
	ArrayList<MunicipalityBO> municipalityList=null;
	Iterator<MunicipalityBO> municipalityIt;
	MunicipalityBO municipalityItem;
	try{
		Municipality municipality= new Municipality();
		municipalityList=municipality.getAllItem();
		
		if(municipalityList != null){
			municipalityIt = municipalityList.iterator();
			while(municipalityIt.hasNext()){
				municipalityItem = (MunicipalityBO)municipalityIt.next();
%>								
								
								<option value="<%=municipalityItem.getId()%>"><%=municipalityItem.getMunicipalityName()%></option>
								

<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>  							
							</select>
							&nbsp;
							<!-- <a href="add_municipality.jsp" class="cboxElement">
							<button type="button" class="btn">Add Municipality</button>
							</a> -->
							</div>	
						</td>
						<td>
							<span>Ward Number</span>
							<div>
							<input type="text" name="word_no" id="phone" class="input-large" required="required" style="width: 100px" />
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Contact Number 1</span>
							<div>
							<input type="text" name="mobile_no" id="mobile_no" class="input-large" required="required" />
							</div>	
						</td>
						<td>
							<span>Contact Number 2</span>
							<div>
							<input type="text" name="land_no" id="land_no" class="input-large"  />
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Reference</span>
							<div>
								<select name="ref" id="ref" class="uniformselect">
									<option value="">Choose One</option>
<%
	ArrayList<ReferenceBO> referenceList=null;
	Iterator<ReferenceBO> referenceIt;
	ReferenceBO referenceItem;
	try{
		Reference reference= new Reference();
		referenceList=reference.getAllItem();
		
		if(referenceList != null){
	referenceIt = referenceList.iterator();
	while(referenceIt.hasNext()){
		referenceItem = (ReferenceBO)referenceIt.next();
%>								
								
								<option value="<%=referenceItem.getId()%>"><%=referenceItem.getName()%></option>
								

<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>


								</select>&nbsp;
								<!-- <a href="add_reference.jsp" class="cboxElement"><button type="button" class="btn">Add Refarence</button></a> -->
							</div>
						</td>
						<td>
							<span>State</span>
							<div>
							<select name="stateName" id="stateName" class="uniformselect">
									<option value="">Choose One</option>
									<option value="Andhra Pradesh">Andhra Pradesh</option>
									<option value="Arunachal Pradesh">Arunachal Pradesh</option>
									<option value="Assam">Assam</option>
									<option value="Bihar">Bihar</option>
									<option value="Chhattisgarh">Chhattisgarh</option>
									<option value="Goa">Goa</option>
									<option value="Gujarat">Gujarat</option>
									<option value="Haryana">Haryana</option>
									<option value="Himachal Pradesh">Himachal Pradesh</option>
									<option value="Jammu & Kashmir">Jammu & Kashmir</option>
									<option value="Jharkhand">Jharkhand</option>
									<option value="Karnataka">Karnataka</option>
									<option value="Kerala">Kerala</option>
									<option value="Madhya Pradesh">Madhya Pradesh</option>
									<option value="Maharashtra">Maharashtra</option>
									<option value="Manipur">Manipur</option>
									<option value="Meghalaya">Meghalaya</option>
									<option value="Mizoram">Mizoram</option>
									<option value="Nagaland">Nagaland</option>
									<option value="Odisha">Odisha</option>
									<option value="Punjab">Punjab</option>
									<option value="Rajasthan">Rajasthan</option>
									<option value="Sikkim">Sikkim</option>
									<option value="Tamil Nadu">Tamil Nadu</option>
									<option value="Telangana">Telangana</option>
									<option value="Tripura">Tripura</option>
									<option value="Uttarakhand">Uttarakhand</option>
									<option value="Uttar Pradesh">Uttar Pradesh</option>
									<option value="West Bengal">West Bengal</option>
							</select>		
							</div>
						</td>
					  </tr>
					  <tr>
					  <td>
							<span>Email Id 1</span>
							<div>
								<input  type="email" name="email" class="input-larg" />
							</div>	
						</td>
					  <td>
							<span>Email Id 2</span>
							<div>
								<input  type="email1" name="email1" class="input-larg" />
							</div>	
						</td>
						</tr>
					  <tr>
					  	<td>
							<span>Associated Developer</span>
							<div>
							<select style="width:290px" name="developer" id="selection2" class="uniformselect" required="required" >
								<option value="0">None</option>
								
									<%
										ArrayList<DeveloperBean> developerListList=null;
										Iterator<DeveloperBean> developerIt;
										DeveloperBean developerItem;
										try{
											Developer developer= new Developer();
											developerListList=developer.getAllDeveloper("all");
											
											if(developerListList != null){
												developerIt = developerListList.iterator();
												while(developerIt.hasNext()){
													developerItem = (DeveloperBean)developerIt.next();
									%>								
																	
																	<option value="<%=developerItem.getDeveloper_id()%>"><%=developerItem.getDeveloper_name()%></option>
																	
									
									<%
										
											}
										}}
										catch(Exception e){
											
											e.printStackTrace();
										}
									%>  							
																</select>
																&nbsp;
																
																</div>	
						</td>
					  
					  
						<td >
						
								<span>Date Created</span>
								<div ><input id="demo" type="text" name="datecreated" class="input-small datepicker" value="<%= df.format(new java.util.Date()) %>" /><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	
						  	<b>(YYYY-MM-DD)</b>
						  	</div>	
						</td>					  
					  </tr>
					</table>		                      
					<p class="stdformbutton">
					<br>
					<br>
						<input type="hidden" name="todo" value="addClient">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                    </form>







  