<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>
<h4 class="widgettitle">Add Project</h4>
 <form class="stdform stdform2" method="post" action="ProjectServlet">
					<table width="100%" border="1" class="tbl">
					  <tr>
					  <td>
					  <span>Project Name</span>
					  <div><input type="text" name="pro_name" id="pro_name" class="input-xxlarge"/></div>
					  </td>
					  </tr>
					  <tr>
						<td colspan=2>
							<span>Client Name</span>
							<div>
							<select name="mr_ms" id="mr_ms" class="uniformselect" required="required">
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
							<input type="text" name="c_name" id="c_name" class="input-xxlarge" required="required" />
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>Site Address</span>
							<div>
							<textarea cols="10" rows="5" name="site_addr" id="site_addr" class=""></textarea>
							</div>
						</td>
						<td colspan=2>
							<span>Project Type</span>
							<div>
							<select name="project-type" id="project-type" class="uniformselect" required="required">
							<option value="">Choose One</option>
							<option value="1">Joint-Venture</option>
							<option value="2">Purchased-Land</option>
							</select>
						</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>No of Floors.</span>
							<div>
							<input type="text" name="site_no_floors" id="site_no_floors" class="" />
							</div>
						</td>
						<td>
							<span>No of Units.</span>
							<div>
							<input type="text" name="site_no_units" id="site_no_units" class="" />
							</div>
						</td>
						</tr>
						 <tr>
						<td>
							<span>Municipality</span>
							<div>
							<select style="width:222px" name="municipality" id="selection2" class="uniformselect" required="required" >
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
							<span>Contact Number 1.</span>
							<div>
							<input type="text" name="Contact1" id="Contact1" class="" />
							</div>
						</td>
						<td>
							<span>Contact Number 2.</span>
							<div>
							<input type="text" name="Contact2" id="Contact2" class="" />
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>Email Id 1.</span>
							<div>
							<input type="text" name="Email1" id="Email1" class="" />
							</div>
						</td>
						<td>
							<span>Email Id 2.</span>
							<div>
							<input type="text" name="Email2" id="Email2" class="" />
							</div>
						</td>
						</tr>
				        <tr>
						<td rowspan="2">
						<br>
						<span>Date Created</span>
						<div><input id="demo" type="text" name="datecreated" class="input-small datepicker" value="<%= df.format(new java.util.Date()) %>" /><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	<b>(YYYY-MM-DD)</b>
						  	</div>	
						</td>
						<td>
							<span>Note.</span>
							<div>
							<textarea rows="2" cols="10" name="site_note" id="site_note"></textarea>
							</div>
						</td>
					  					  
					  </tr>
					</table>		                      
					<p class="stdformbutton">
					<br>
					<br>
						<input type="hidden" name="todo" value="addProject">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                    </form>