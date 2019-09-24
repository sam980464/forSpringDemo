<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>



<%
	ArrayList<ClientBO> clientList=null;
	Iterator<ClientBO> testIt;
	ClientBO clientItem;
	try{
		Client client= new Client();
		clientList=client.getAllItem(Integer.parseInt(request.getParameter("id")));
		
		if(clientList != null){
			testIt = clientList.iterator();
			while(testIt.hasNext()){
				clientItem = (ClientBO)testIt.next();
%>


<div class="alert alert-info">
<h5>Edit Client  :  <%=clientItem.getClientName()%>
</h5>
</div>



 <form class="stdform stdform2" method="post" action="ActionServlet">
					<table width="100%" border="1" class="tbl">
					  <tr>
						<td>
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
							<option value="M/S">M/S</option>
							</select>
							<input type="text" name="name" id="name" value="<%=clientItem.getClientName()%>" class="input-large" required="required" />
							</div>
						</td>
						<td>
							<span>Guardian's Name</span>
							<div>
							<select name="gar_rel" id="selection2" class="uniformselect" required="required">
							<option value="0">Choose One</option>
							<option <% if(clientItem.getGuardianRelation().equals("SON")){out.print("selected='selected'");}  %> value="SON">SON</option>
							<option <% if(clientItem.getGuardianRelation().equals("WIFE")){out.print("selected='selected'");}  %> value="WIFE">WIFE</option>
							<option <% if(clientItem.getGuardianRelation().equals("HUSBAND")){out.print("selected='selected'");}  %> value="HUSBAND">HUSBAND</option>
							<option <% if(clientItem.getGuardianRelation().equals("DAUGHTER")){out.print("selected='selected'");}  %> value="DAUGHTER">DAUGHTER</option>
							</select>
							<input type="text" name="gar_name" id="name" class="input-large" required="required" value="<%=clientItem.getGuardianName() %>" />
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Present Address</span>
							<div>
							<textarea cols="80" rows="5" name="present_addr" id="location2" class=""><%=clientItem.getPresentAddress().trim() %></textarea>
							</div>
						</td>
						<td>
							<span>Permanent Address</span>
							<div>
							<textarea cols="80" rows="5" name="per_addr" id="location2" class=""><%=clientItem.getPermanentAddress().trim() %></textarea>
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Municipality</span>
							<div>
							<select style="width:222px" name="municipality" id="selection2" class="uniformselect">
								<option value="">Select Municipality</option>
								
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
								
								<option <% if(clientItem.getMunicipality()==municipalityItem.getId()){out.print("selected='selected'");}  %>   value="<%=municipalityItem.getId()%>"><%=municipalityItem.getMunicipalityName()%></option>
								

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
						<td>
							<span>Ward Number</span>
							<div>
							<input type="text" name="word_no" id="phone" class="input-large" required="required"  value="<%=clientItem.getWordNo() %>"/>
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Mobile Number</span>
							<div>
							<input type="text" name="mobile_no" id="phone" class="input-large" required="required" value="<%=clientItem.getMobile()%>"/>
							</div>	
						</td>
						<td>
							<span>Land Number</span>
							<div>
							<input type="text" name="land_no" id="phone" class="input-large" required="required" value="<%=clientItem.getLand() %>" />
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Reference</span>
							<div>
								<select name="ref" id="ref" class="uniformselect">
									<option value="0">Choose One</option>
<%
	ArrayList<ReferenceBO> refarenceList=null;
	Iterator<ReferenceBO> refarenceIt;
	ReferenceBO refarenceItem;
	try{
		Reference refarence= new Reference();
		refarenceList=refarence.getAllItem();
		
		if(refarenceList != null){
	refarenceIt = refarenceList.iterator();
	while(refarenceIt.hasNext()){
		refarenceItem = (ReferenceBO)refarenceIt.next();
%>								
								
<option <% if(refarenceItem.getId()==clientItem.getRef()){out.print("selected='selected'");}  %> value="<%=refarenceItem.getId()%>"><%=refarenceItem.getName()%></option>
								

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
						<td>
							<span>Email</span>
							<div>
								<input  type="email" name="email" class="input-large" value="<%=clientItem.getEmail() %>" />
							</div>	
						</td>
					  </tr>
					</table>		                      
					<p class="stdformbutton">
						<input type="hidden" name="todo" value="updateClient">
						<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
						<button class="btn btn-primary">Update</button>
						<button type="reset" class="btn">Reset Button</button>
						<a href="add_estimate.jsp?cid=<%=request.getParameter("id")%>">
						<button type="button" class="btn">CREATE AN ESTIMATE</button>
						</a>
					</p>
                    </form>
                    
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>  