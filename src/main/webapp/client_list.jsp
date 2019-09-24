<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>All Client</li>
        </ul>

<script type="text/javascript">
    jQuery(document).ready(function(){
        // dynamic table
        jQuery('#dyntable').dataTable({
            "sPaginationType": "full_numbers",
            "aaSortingFixed": [[0,'asc']],
            "fnDrawCallback": function(oSettings) {
                jQuery.uniform.update();
            }
        });
        
        jQuery('#dyntable2').dataTable( {
            "bScrollInfinite": true,
            "bScrollCollapse": true,
            "sScrollY": "300px"
        });
        
    });
</script>        
		 
        <div class="maincontent">
            <div class="maincontentinner">
                <div class="row-fluid">
                <a href="add_client.jsp" class="btn btn-inverse alertinverse color"><small>Add Client</small></a>
                    <h4 class="widgettitle">Client's List</h4>
					<table id="dyntable" class="table table-bordered responsive">
                    <!-- <colgroup>
                        <col class="con0" style="align: center; width: 4%" />
                        <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                    </colgroup> -->
                    <thead>
                        <tr>
                          	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
                            <th class="head0">Name</th>
                            <th class="head1">Guardian</th>
                            <th class="head0">Mobile</th>
                            <th class="head1">Municipality</th>
                            <th class="head0">Ward No</th>
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<ClientBO> itemPartList=null;
	Iterator<ClientBO> testIt;
	ClientBO clientItem;
	try{
		Client test= new Client();
		itemPartList=test.getAllItem();
		
		if(itemPartList != null){
			testIt = itemPartList.iterator();
			while(testIt.hasNext()){
				clientItem = (ClientBO)testIt.next();
%>
                    
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td><a href="client_estimate.jsp?cid=<%=clientItem.getId()%>">
                            <%=clientItem.getMrMs()%>  <%=clientItem.getClientName()%>
                            </a></td>
                            <td><%=clientItem.getGuardianRelation()%> OF <%=clientItem.getGuardianName() %></td>
                            <td><%=clientItem.getMobile()%></td>
                            <td>
								<%Municipality municipality= new Municipality();%>
                            	<%=municipality.getMunicipalityNameById(clientItem.getMunicipality())%>
                            </td>
                            <td><%=clientItem.getWordNo()%></td>
							<td>
								<a href="edit_client.jsp?id=<%=clientItem.getId()%>" class="color cboxElement"><img src="resources/images/edit.png" /></a>
								<a href="ActionServlet?todo=deleteClient&id=<%=clientItem.getId()%>"  onclick="return confirm('Are you sure?');"><img src="resources/images/delete.png" /></a>
								<a href="add_estimate.jsp?cid=<%=clientItem.getId()%>"><img src="resources/images/estimate.png" /></a>
							</td>
                        </tr>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>  
  
                        
                    </tbody>
                </table>
                </div><!--row-fluid-->
                

  <%@ include file="common/foot.jsp" %>