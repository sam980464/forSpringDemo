<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add Scheme</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Scheme Name</span>
							<div>
								<input type="text" value="" name="s_name" required="required">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Parent Scheme</span>
							<div>
							<select style="width: 300px;" name="parent_scheme_id" id="selection2"class="uniformselect" required="required">
									<option value="0">No Parent</option>


									<%
										ArrayList<SchemeBO> schemeList = null;
										Iterator<SchemeBO> schemeIt;
										SchemeBO schemeBO;
										try {
											Scheme scheme = new Scheme();
											schemeList = scheme.getAllParentItem();

											if (schemeList != null) {
												schemeIt = schemeList.iterator();
												while (schemeIt.hasNext()) {
													schemeBO = (SchemeBO) schemeIt.next();
									%>

									<option value="<%=schemeBO.getId()%>"><%=schemeBO.getSchemeName()%></option>


									<%
										}
											}
										} catch (Exception e) {

											e.printStackTrace();
										}
									%>


								</select>								
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addSeheme"> 
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
