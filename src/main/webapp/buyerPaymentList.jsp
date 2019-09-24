<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.AddBuyerToProjectBean"%>
<%@page import="com.project.dao.AddBuyerToProject"%>


 <%
Client client=new Client();
%>

                
<h4 class="widgettitle">Payment  List  </h4>
<table id="" class="" width="900px">
         <tr>
             <th class="head0">Buyer Name</th>
             <th class="head1">Estimate Amount</th>
             <th class="head0">Paid Amount</th>
               <th class="head0">Payment Method</th>
                 <th class="head0">Cheque No</th>
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
		projectpayList=paylist.getPaymentList("all",(String)session.getAttribute("project_id"));
		float buffer=0;
		String bufferId="";
		int i=0;
		if(projectpayList != null){
			projectpayIt = projectpayList.iterator();
			while(projectpayIt.hasNext()){
				paymntList = (AddBuyerToProjectBean)projectpayIt.next();
				if(paymntList.getBuyer_id().equals(bufferId)||i==0){
			buffer+=Float.parseFloat(paymntList.getPaidamount());
			//paymntList.setPaidamount(buffer+"");
				}else{
				buffer=Float.parseFloat(paymntList.getPaidamount());
				}
%>
                    
                        <tr class="gradeX">
                            <td>
                            <%=paymntList.getBuyer_name()%>
                            </td>
                            <td>
	                             <%=paymntList.getBuyer_estimate_amount()%>
                            </td>
                            <td>
                               	<%=
								paymntList.getPaidamount()
							  %>
                            [Due :<%=(Float.parseFloat(paymntList.getBuyer_estimate_amount())-buffer) %>]
                            
                            </td>
                             <td>
                            	<%=paymntList.getPm()  %>
                            </td>
                             <td>
                            	<%=paymntList.getNo() %>
                            </td>
                            <td>
                            	<%=paymntList.getBuyer_estimate_date()  %>
                            </td>
                            							<td><b>
								<a href="edit_payment.jsp?pid=<%=paymntList.getPayment_id()%>" class="color cboxElement">Edit Payment<!-- <img src="resources/images/edit.png" /> --></a> | 
								<%-- <a Title="Delete Estimate" href="ActionServlet?todo=deleteEstimate&id=<%=estimateItem.getId()%>"  onclick="return confirm('Are you sure?');"> Delete <%-- <img src="resources/images/delete.png" /> --%></a> 
								<a Title="Print" href="buyerpayreceived.jsp?pid=<%=paymntList.getPayment_id()%>" target="_blank">Print </a>|
								 <a Title="Delete Estimate" href="ActionServlet?todo=deleteProAttrib&id=<%=paymntList.getPayment_id()%>&flag=paydel"  onclick="return confirm('Are you sure?');"> Delete  <img width="15" height="12" src="resources/images/delete.png" /> </a>  
								
								</b>
							</td>
                        </tr>
<%i++;
					bufferId=paymntList.getBuyer_id();
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>  
  
                        
                    </tbody>
                </table>
                