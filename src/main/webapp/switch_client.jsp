<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Choose Client</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action=client.jsp>
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Client</span>
							<div>
								<select name="cid" data-placeholder="Choose a Client" style="width:350px" class="_chzn-select" tabindex="2">
								<%
								ArrayList<ClientBO> itemPartList=null;
								Iterator<ClientBO> clientIt2;
								ClientBO clientItem;
								try{
									Client test= new Client();
									itemPartList=test.getAllItemWithSameNameClient();
									
									if(itemPartList != null){
										clientIt2 = itemPartList.iterator();
										while(clientIt2.hasNext()){
											clientItem = (ClientBO)clientIt2.next();
								%>								
								<option value="<%=clientItem.getId()%>"><%=clientItem.getClientName()%></option>
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
					
				</table>
				<p class="stdformbutton">
					<input type="submit" class="alertdanger btn btn-danger alertdanger" value="Switch Client" >
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
