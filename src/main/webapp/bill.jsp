<title>Bill</title>
<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<link rel="stylesheet" href="resources/css/style.css" type="text/css" />
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border-color:#ccc;}
.tg td{font-family:Arial, sans-serif;font-size:14px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#fff;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#f0f0f0;}
.tg .tg-0lax{text-align:left;vertical-align:top}
.tg .tg-orf0{font-family:"Arial Black", Gadget, sans-serif !important;;text-align:left;vertical-align:top}
</style>
<style>
@page { size: auto;  margin: 0mm; }
</style>
<%
int cid= Integer.parseInt(request.getParameter("cid"));
int eid= 0;
double totalpaid=0.0;
double estimatedAmount=0.0;
double receivedTotal=0.0;
double gstTotal=0.0;
if (request.getParameter("eid")!=null){
eid=Integer.parseInt(request.getParameter("eid"));
}

Client client= new Client();
String client_name=client.getClientNameById(cid);
String developer_name=client.getDeveloperNameById(cid);
if(null!=developer_name && developer_name.length()>0){
	client_name = developer_name;
}
String client_address=client.getClientAddressById(cid);
%>
 <% 
		Client testClient = new Client(); 
		boolean isClientRegional = false;
		if(request.getParameter("cid")!=null){
			 isClientRegional = testClient.isClientRegional(Integer.parseInt(request.getParameter("cid")));
		}
	%>  

<script type="text/javascript" src="resources/js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="resources/js/jquery.print.js" ></script>

<script type="text/javascript">
    $(function() {
    	inWords();    	
        window.print();
    });
</script>
<script>
var a = ['','One ','Two ','Three ','Four ', 'Five ','Six ','Seven ','Eight ','Nine ','Ten ','Eleven ','Twelve ','Thirteen ','Fourteen ','Fifteen ','Sixteen ','Seventeen ','Eighteen ','Nineteen '];
var b = ['', '', 'Twenty','Thirty','Forty','Fifty', 'Sixty','Seventy','Eighty','Ninety'];

function inWords() {
	var num = document.getElementById("amountValue").innerHTML;
	num=Math.round(num);
	
    if ((num = num.toString()).length > 9) return 'overflow';
    n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
    if (!n) return; var str = '';
    str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'Crore ' : '';
    str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'Lakh ' : '';
    str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'Thousand ' : '';
    str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'Hundred ' : '';
    str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'Only ' : '';
    document.getElementById("amountInWord").innerHTML = str;
   // return str;
}


</script>

<div id="printdiv" class="printable"  >
<div class="beforePrintTable" ><p style="text-align:center;font-size:22px;">Bill</p></div>
	<div style="width: 100%;margin-top:15px " >
		<div style="font-size:18px"><span style="font-weight:bold">R</span>anjan <span style="font-weight:bold">D</span>atta</div>
		<div>Off - 83/1 S. N. Banerjee Road</div>
		<div>Barrackpore, Kolkata - 700120</div>		
		<div>Phone: 033-2592-4222</div>		
		<div>Mobile: +91-98301-57969</div>
		<div>E-mail: mail2rtech@gmail.com</div>
	</div>
	<div style="float:right;margin-top:-86px">
	<img src="resources/images/rtechLogo.JPG" alt="" style="height: 55px;width:104px" />
	</div>
	
	<hr style="height:0px">
	<div style="text-align:left;font-weight:bold;display:inline">
	To	
	</div>
	<%
	 String gstNo = new Gst().getGstDetail();
	 String addGstFlag =  new Payment().getAddGstFlagByPaymentId(Integer.parseInt(request.getParameter("pid")));
	 if(null!=gstNo && gstNo.length()>4 && null!=addGstFlag && addGstFlag.equalsIgnoreCase("yes"))
	 {
	%>
	<div style="float:right;font-weight:bold;">
	GST NO :- <%=new Gst().getGstDetail() %>
	</div>
	<%} %>
	<div style="text-align:left;font-weight:bold;">
	<%=client_name %>
	</div>
	
	<table class="tg" style="margin-top:2%;margin-left:5%">
  <tr>
    <th class="tg-0lax" colspan="4" style="width:400px;text-align:center;font-weight:bold">Particulars of Service</th>
    <th class="tg-0lax" colspan="3" style="width:200px;text-align:center;font-weight:bold">Amount</th>
  </tr>
  <%
  ArrayList<PaymentBO> paymentList=null;
  Iterator<PaymentBO> paymantIt;
	PaymentBO paymentItem;
	try{
		Payment payment= new Payment();
		Estimate estimate = new Estimate();
		
		paymentList=payment.getAllItemByPId(Integer.parseInt(request.getParameter("pid")));
		
		if(paymentList != null){
			paymantIt = paymentList.iterator();
			while(paymantIt.hasNext()){
				paymentItem = (PaymentBO)paymantIt.next();
  %>
  <tr>
    <td class="tg-0lax" colspan="4" style="height:125px;padding-left:15px">
    	<div><%=estimate.getSchemeNameByEstimateId(eid) %></div>
    	<div style="margin-top:10%;font-size:18px;"> (Rupees <span id="amountInWord"></span> ) </div>
    </td>
    <td class="tg-0lax" colspan="3" style="height:125px;"> 
    	<table class="tg" style="width:100%;height:100%">
		  <tr>
		    <td class="tg-ilw0"><span style="font-weight:bold">Bill Amount</span></td>
		    <td class="tg-0ord" style="text-align:right"><%=paymentItem.getAmountReceived() %></td>
		  </tr>
		  <%if(null!=gstNo && gstNo.length()>0 && null!=addGstFlag && addGstFlag.equalsIgnoreCase("yes")) { %>
		   <tr>
		    <td class="tg-ilw0"><span style="font-weight:bold">GST %</span></td>
		    <td class="tg-0ord" style="text-align:right"><%=paymentItem.getGstPercentage()%></td>
		  </tr>
		  <% if(isClientRegional) { %>
		  <tr>
		    <td class="tg-0lax"><span style="font-weight:bold">CGST</span></td>
		    <td class="tg-lqy6" style="text-align:right"><%=paymentItem.getGstAmount()/2%></td>
		  </tr>
		  <tr>
		    <td class="tg-0lax"><span style="font-weight:bold">SGST</span></td>
		    <td class="tg-lqy6" style="text-align:right"><%=paymentItem.getGstAmount()/2%></td>
		  </tr>
		  <%} else { %>
		  <tr>
		    <td class="tg-0lax"><span style="font-weight:bold">IGST</span></td>
		    <td class="tg-lqy6" style="text-align:right"><%=paymentItem.getGstAmount()%></td>
		  </tr>
		   <%}
           	}
           	%>
		  <tr>
		    <td class="tg-orf0"><span style="font-weight:bold">Total</span></td>
		    <td class="tg-lqy6" style="text-align:right"><span id="amountValue"><%=paymentItem.getGstAmount()+paymentItem.getAmountReceived()%></span></td>
		  </tr>
		 
		</table>
    </td>
  </tr>
  <%	int billPrintCount = paymentItem.getBillPrintCount();  		
  		payment.setId(Integer.parseInt(request.getParameter("pid")));
  		payment.updateBillCount(billPrintCount+1);
  
			}
		}
	}catch(Exception e){
		
		e.printStackTrace();
	}	
%>
</table>
<div style="font-weight:bold;color:black;margin-top:15px">
Bill No:<%=request.getParameter("pid") %>
</div>
<% java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
   java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd-MM-yyyy");
	  %>
	<div style="color:black;font-weight:bold;margin-top:15px">Date: <%=df2.format(df.parse(new Payment().getDateReceivedByPaymentId(Integer.parseInt(request.getParameter("pid"))))) %></div>

<div style="text-align:center;padding-top:40px"><span>**This is a computer-generated bill. No signature is required.**</span></div>
</div>
