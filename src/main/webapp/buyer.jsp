<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.BuyerBean"%>
<%@page import="com.project.dao.Buyer"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Bank Master</li>
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
    
 jQuery(document).ready(function(){
        jQuery(".color").colorbox();        
    });
</script>        
		 
        <div class="maincontent">
            <div class="maincontentinner">
                <div class="row-fluid">
                    <h4 class="widgettitle">Buyer Master</h4>
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
                            <th class="head0">Buyer Name</th>
                            <th class="head1">Address</th>
                            <th class="head1">Contact No</th>
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	ArrayList<BuyerBean> buyerList=null;
	Iterator<BuyerBean> buyerIt;
	BuyerBean buyerItem;
	try{
		Buyer buyer= new Buyer();
		buyerList=buyer.getAllBuyer("all","");
		
		if(buyerList != null){
			buyerIt = buyerList.iterator();
			while(buyerIt.hasNext()){
				buyerItem = (BuyerBean)buyerIt.next();
%>       
                        <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                            <td><%=buyerItem.getBuyer_name() %></td>
                            <td><%=buyerItem.getBuyer_address() %></td>
                             <td><%=buyerItem.getBuyer_contactno() %></td>
							<td><b>
								<a href="project_edit_buyer.jsp?buyer_id=<%=buyerItem.getBuyer_id() %>" class="color cboxElement">Edit  <img width="15" height="12" src="resources/images/edit.png" /></a>  |
								<a href="ActionServlet?todo=deleteProAttrib&id=<%=buyerItem.getBuyer_id()%>&flag=buyer"  onclick="return confirm('Are you sure?');">Delete   <img width="15" height="12" src="resources/images/delete.png" /> </a>
								</b>
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