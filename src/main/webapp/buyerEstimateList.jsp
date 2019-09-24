<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.AddBuyerToProjectBean"%>
<%@page import="com.project.dao.AddBuyerToProject"%>


 
                
<h4 class="widgettitle">Estimate  List  </h4>
<table id="" class="" width="900px">
         <tr>
             <th class="head0">Buyer Name</th>
             <th class="head1">Estimate Amount</th>
             <th class="head0">On Date</th>
			<th class="head1">Option</th>
         </tr>
<tbody>
<%

	ArrayList<AddBuyerToProjectBean> projectpayList=null;
	Iterator<AddBuyerToProjectBean> projectpayIt;
	AddBuyerToProjectBean paymntList=new AddBuyerToProjectBean();
	try{
		AddBuyerToProject paylist=new AddBuyerToProject();
		projectpayList=paylist.getEstimateList("est",(String)session.getAttribute("project_id")); 
		float buffer=0;
		String bufferId="";
		int i=0;
		if(projectpayList != null){
			projectpayIt = projectpayList.iterator();
			while(projectpayIt.hasNext()){
				paymntList = (AddBuyerToProjectBean)projectpayIt.next();
				
%>
                    
                        <tr class="gradeX">
                            <td>
                            <%=paymntList.getBuyer_name()%>
                            </td>
                            <td>
	                             <%=paymntList.getBuyer_estimate_amount()%>
                            </td>
                          <td>
                            	<%=paymntList.getBuyer_estimate_date()  %>
                            </td>
                            							<td><b>
								<a href="edit_buyerestimate.jsp?eid=<%=paymntList.getBuyer_estimate_id()%>" class="color cboxElement">Edit <img width="15" height="12" src="resources/images/edit.png" /> </a> | 
							<!-- 	<a Title="Print" href="buyerestimatePrint.jsp?pid=<%=paymntList.getBuyer_estimate_id()%>" target="_blank">Print </a>| -->|
								 <a Title="Delete Estimate" href="ActionServlet?todo=deleteProAttrib&id=<%=paymntList.getBuyer_estimate_id()%>&flag=estdel"  onclick="return confirm('Are you sure?');"> Delete  <img width="15" height="12" src="resources/images/delete.png" /> </a>  
								
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
                