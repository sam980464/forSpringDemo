<%@page import="com.bo.*"%><%@page import="com.dao.*"%><%@page import="java.util.*"%><%  
response.setContentType("text/csv");  
response.setHeader("Content-Disposition", "attachment; filename=OfficeExpenses.csv");
String from= request.getParameter("from");
String to=request.getParameter("to");
int exp_for=0;        		 
if(request.getParameter("exp_for")!=null){
exp_for=Integer.parseInt(request.getParameter("exp_for"));
}
out.print("ID");   
out.print(",");
out.print("EXPENSES NAME"); 
out.print(",");
out.print("EXPENSES DESCRIPTION");
out.print(",");
out.print("DATE");
out.print(",");
out.print("AMOUNT");
out.print(",");
out.print("CHEQUE NUMBER");
out.print(",");
out.print("BANK");
//out.print(",");
out.println();  
%><%
	ArrayList<OfficeExpensesBO> officeExpensesList=null;
	Iterator<OfficeExpensesBO> officeExpensesIt;
	OfficeExpensesBO officeExpensesBO;
	try{
		OfficeExpenses officeExpenses= new OfficeExpenses();
		
		officeExpenses.setFromDate(request.getParameter("from"));
		officeExpenses.setToDate(request.getParameter("to"));
		officeExpenses.setExpensesName(exp_for);

		if(request.getParameter("from")==null || request.getParameter("t")==null)
			{
			officeExpensesList=officeExpenses.getAllItemForCsv();
			
			}
		else
			{
			officeExpensesList=officeExpenses.getAllItemForCsv();
			}
		
		
		if(officeExpensesList != null){
			officeExpensesIt = officeExpensesList.iterator();
			while(officeExpensesIt.hasNext()){
				officeExpensesBO = (OfficeExpensesBO)officeExpensesIt.next();
				out.print(officeExpensesBO.getId());   
				out.print(",");
				out.print(officeExpensesBO.getExpensesNameTxt()); 
				out.print(",");
				out.print(officeExpensesBO.getExpensesDesc());
				out.print(",");
				out.print(officeExpensesBO.getDateTime());
				out.print(",");
				out.print(officeExpensesBO.getAmount());
				out.print(",");
				out.print(officeExpensesBO.getChequeNo());
				out.print(",");
				out.print(officeExpensesBO.getBankName());
				//out.print(",");
				out.println();  
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	} 
%>  




<%
/*ArrayList<ViewNameListBO> viewNameListArrList=null;
Iterator<ViewNameListBO> viewNameIt;
ViewNameListBO viewNameListBO;
try{
	ViewNameList viewNameList= new ViewNameList();
	viewNameListArrList=viewNameList.getAllItemByGrade();
	if(viewNameListArrList != null){
		viewNameIt = viewNameListArrList.iterator();
		out.print("Name");   
		out.print(",");
		out.print("Manager"); 
		out.print(",");
		out.print("Grade");
		out.print(",");
		out.print("Caregory Original");
		out.print(",");
		out.print("Caregory New");
		out.print(",");
		out.println();  
		//out.println();  
		while(viewNameIt.hasNext()){
			viewNameListBO = (ViewNameListBO)viewNameIt.next();
			out.print(viewNameListBO.getName());   
			out.print(",");
			out.print(viewNameListBO.getManager()); 
			out.print(",");
			out.print(viewNameListBO.getGrade());
			out.print(",");
			out.print(viewNameListBO.getCategoryOrig());
			out.print(",");
			out.print(viewNameListBO.getCategoryNew());
			out.print(",");
			out.println();  
			
		}
		//out.println("/n");  
}}
catch(Exception e){
	e.printStackTrace();
} */
%>
<%-- <% 
for(int i = 1; i < 12; i++){  
    for(int j = 1; j < 8; j++){  
        if(j != 1) out.print(",");  
        out.print(String.valueOf(i * j));  
    }  
    out.println();  
}  
 %> --%>
