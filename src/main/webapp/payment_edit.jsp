<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

 <%
Client client=new Client();
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");

int estimateid=  Integer.parseInt(request.getParameter("estimateid"));
Scheme scheme= new  Scheme();

int pid=Integer.parseInt(request.getParameter("pid"));

Payment payment= new Payment();
%>
<script type="text/javascript">
function calculateGst()
{
	var amount_rcv = document.getElementById("amount_rcv").value;
	var gstPercentage = document.getElementById("gstPercentage").value;
	var isClientRegional = document.getElementById("isClientRegional").value;
	
	//alert(isClientRegional);
	//alert(per_unit_price);
	var gstAmount=(amount_rcv*gstPercentage)/100;
	var n=gstAmount.toFixed(2);
	document.getElementById("gstAmountRec").value=n;
	if(isClientRegional === "false" ) {		
		document.getElementById("igst").value=n;
	} else {	
		
		document.getElementById("cgst").value=n/2;
		document.getElementById("sgst").value=n/2;
	}
	

}
</script>

<script type="text/javascript" src="resources/js/datetimepicker.js"></script>

<h4 class="widgettitle">Get Payment from <b><%=client.getClientNameById(Integer.parseInt(request.getParameter("cid"))) %></b> for
<b><%=scheme.getSchemeNameByEstimateId(estimateid) %>
</b></h4>
                    <form class="stdform stdform2" method="post" action="ActionServlet" onsubmit="return paymentValidation();">
					<table width="900px" border="1" class="tbl">
					  <tr>
						<td>
							<span>ClientName</span>
							<div>
							<select style="width:300px;" name="client" id="selection2" class="uniformselect">
								<option value="">Choose One</option>
								
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
<option 
	<% 
	if(request.getParameter("cid")!=null){
	if(Integer.parseInt(request.getParameter("cid"))==clientItem.getId())
		{
			out.print("selected='selected'");
	} 
	}
	%> 
	value="<%=clientItem.getId()%>">
		<%=clientItem.getClientName()%>
</option>




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
							<span>Amount Due</span>
							<div>
							<%
							//Payment payment= new Payment();
							Double due=payment.getDueByEstimateId(Integer.parseInt(request.getParameter("estimateid")));
							%><b>Rs.</b>
							<input type="text" value="<%=String.format("%.2f", due) %>" name="amount_due" readonly="readonly" id="amount_due" class="input-large" />
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Payment Method</span>
							<div>
							<select name="payment_method" id="payment_method" style="width:60px" onchange="loadBank()" >
								<option <% if(payment.getPaymentMethodByPaymentId(pid).equals("CASH")){out.println("selected='selected'");} %> value="CASH">CASH</option>
								<option <% if(payment.getPaymentMethodByPaymentId(pid).equals("CHEQUE")){out.println("selected='selected'");} %> value="CHEQUE">CHEQUE</option>
							</select>
							<!-- <div id="bank_list" style="float:left;width:30px;  height:50px;"></div> -->
							<select id="bank_list" name="bank_list" style="float: right; margin: 1px; width: 135px;"></select>
							<input type="text" placeholder="Cheque No." value="<%=payment.getChecknoByPaymentId(pid) %>" name="cheque_no"  id="cheque_no" class="input-small"  />
							<input type="hidden" placeholder="chequeBankId" value="<%=payment.getBankIdByPaymentId(pid) %>" name="chequeBankId"  id="chequeBankId" class="input-small"  />
							</div>
							<a style="float: right;color: #fff;" id="add_bank" class="btn btn-inverse alertinverse color cboxElement" href="add_bank.jsp"><small>+</small></a>
						</td>
						<td>
							<span>Amount</span>
							<div><b>Rs.</b>
							<input type="text" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("yes")){out.println("readonly='readonly'");} %> value="<%=String.format("%.2f", payment.getAmountReceivedByPaymentId(pid)) %>" name="amount_rcv" size="9" placeholder="0.00"  id="amount_rcv" class="input-large" required="required" onblur="calculateGst()" />
							</div>
						</td>
					  </tr>
					  <tr>
						  <td colspan=2>
								<span>Date</span>
									<div>
									<input type="text" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("yes")){out.println("readonly='readonly'");} %> value="<%= payment.getDateReceivedByPaymentId(pid) %>" class="input-small datepicker hasDatepicker" name="datecreated" id="demo"> <a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
									<b>[YYYY-MM-DD]</b>
									</div>
								
							</td>
							<td colspan=2>
							&nbsp;
							</td>
					  </tr>
					  
					  <tr>
					  <td  colspan="1">
							<span>Add GST</span>
							<div>
							<select name="addGST" id="addGST" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("yes")){out.println("disabled");} %> style="width:103px" onchange="addGstOption()">
								<option <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("yes")){out.println("selected='selected' ");} %> value="yes">Yes</option>
								<option <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("no")){out.println("selected='selected'");} %> value="no">No</option>
							</select>
					    </td>
						 <% 
							Client testClient = new Client(); 
							 GstBO gstBo = payment.getGstDetailByPaymentId(pid);
							boolean isClientRegional = false;
							if(request.getParameter("cid")!=null){
								 isClientRegional = testClient.isClientRegional(Integer.parseInt(request.getParameter("cid")));
							}
						%>
						<input type="hidden" name="isClientRegional" id="isClientRegional" value=<%=isClientRegional %>>
						<input type="hidden" value="<%=gstBo.getGst_amount()  %>" name="gstAmountRec" size="9" placeholder="0.00"  id="gstAmountRec" class="input-large" required="required"  />
						<% if(isClientRegional) { %>
						<td id="cgstTd" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("no")){out.println("style='display:none'");} %> >
							<span>CGST</span>
							<div><b>Rs.</b>
							<input type="text" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("yes")){out.println("readonly='readonly'");} %> value=<%=Double.parseDouble(gstBo.getGst_amount())/2 %> name="cgst" size="9" placeholder="0.00"  id="cgst" class="input-large" required="required"  />
							</div>
						</td>
						<%} %>
					  </tr>					
						<tr>
						<td  id="gstPerTd" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("no")){out.println("style='display:none'");} %> >
								<span> GST %</span>
									<div>
										<input type="text" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("yes")){out.println("readonly='readonly'");} %> value="<%=gstBo.getGst_percentage()  %>" class="input-small" name="gstPercentage" id="gstPercentage" />
									</div>
								
						</td>
						<% if(isClientRegional) { %>
						<td id="sgstTd" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("no")){out.println("style='display:none'");} %> >
							<span>SGST</span>
							<div><b>Rs.</b>
							<input type="text" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("yes")){out.println("readonly='readonly'");} %> value=<%=Double.parseDouble(gstBo.getGst_amount())/2 %> name="sgst" size="9" placeholder="0.00"  id="sgst" class="input-large" required="required"  />
							</div>
						</td>
						<% } if(!isClientRegional) { %>
						<td id="igstTd" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("no")){out.println("style='display:none'");} %> >
							<span>IGST</span>
							<div><b>Rs.</b>
							<input type="text" <% if(payment.getAddGstFlagByPaymentId(pid).equalsIgnoreCase("yes")){out.println("readonly='readonly'");} %>  value=<%=gstBo.getGst_amount() %> name="igst" size="9" placeholder="0.00"  id="igst" class="input-large" required="required"  />
							</div>
						</td>
						<%} %>
					 </tr>
					  
					  
					  
					  
					  
					</table>		                      
					<p class="stdformbutton">
						<input type="hidden" name="todo" value="editPayment">
						<input type="hidden" name="paymentId" value="<%=request.getParameter("pid")%>">
						<input type="hidden" name="cid" value="<%=request.getParameter("cid")%>">
						<input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
						<input type="hidden" id="total" name="total" value="<%=request.getParameter("total")%>">
						<button class="btn btn-primary">Update</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                    </form>
   
   <script src="http://code.jquery.com/jquery-1.9.1.js"></script>                 
 <script type="text/javascript">
 loadBank();

 function paymentValidation()
 	{
	 
	var amount_due=Math.round(document.getElementById("total").value);
	var amount_rcv=Math.round(document.getElementById("amount_rcv").value);
	 
	 //alert(amount_due+"-"+amount_rcv);
	 if(parseInt(amount_due-amount_rcv)<0)
	 	{
		 alert("You Can not receive more then  due  amount of  the  estimate !");
		 return  false;
	 	} 
	 else{
		return true;
	 }
 	}

 document.getElementById("cheque_no").style.display= "none";
 document.getElementById("bank_list").style.display= "none";
 document.getElementById("add_bank").style.display= "none";
 

 
 function setSelectedValue() {
	 var selectObj = document.getElementById("bank_list");
	 var chequeBankId = document.getElementById("chequeBankId").value;	 	
	    for (var i = 0; i < selectObj.options.length; i++) { 
	        if (selectObj.options[i].value== chequeBankId) {
	            selectObj.options[i].selected = true;
	            return;
	        }
	    }
	}
 
 function loadBank()
 {
 	var payment_method= document.getElementById("payment_method").value;
 	
 	
 	
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
	 		 	if(payment_method=="CHEQUE"){
	 	 			document.getElementById("bank_list").style.display= "inline";
	 	 			document.getElementById("cheque_no").style.display= "inline";
	 	 			document.getElementById("add_bank").style.display= "inline";
	 		  		document.getElementById("bank_list").innerHTML=xmlhttp.responseText;
	 		  		setTimeout(
	 		  			 	setSelectedValue()
	 		  			 	, 5000);
	 		 	}
	 		 	else{
	 		 		document.getElementById("bank_list").style.display= "none";
	 		 		document.getElementById("cheque_no").style.display= "none";
	 		 		document.getElementById("add_bank").style.display= "none";
	 		 	}
	 	    }
	 	  }
	 	xmlhttp.open("GET","ActionServlet?todo=getBankList",true);
	 	xmlhttp.send();
 	
 }
 function addGstOption()
 {
 	var gstOption= document.getElementById("addGST").value;
 	var isClientRegional = document.getElementById("isClientRegional").value;
 	if(gstOption === "no"){
 		document.getElementById("gstPerTd").style.display="none";
 		
 		if(isClientRegional === "false"){
 			document.getElementById("igstTd").style.display="none";
 		} else {
 			document.getElementById("cgstTd").style.display="none";
 	 		document.getElementById("sgstTd").style.display="none";
 		}
 		
 		
 		
 					
 	} else {
 		document.getElementById("gstPerTd").style.display="table-cell";
 		if(isClientRegional === "false"){
 			document.getElementById("igstTd").style.display="table-cell";
 		} else{
 			document.getElementById("cgstTd").style.display="table-cell";
 	 		document.getElementById("sgstTd").style.display="table-cell";
 		}
 		
 		calculateGst();
 		
 	}
 	
 }
 
</script>
                