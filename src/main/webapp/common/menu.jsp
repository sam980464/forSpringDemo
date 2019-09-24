<%
String uri = request.getRequestURI();
String pageName = uri.substring(uri.lastIndexOf("/")+1);

ArrayList<String> permissions1 = (ArrayList<String>)session.getAttribute("permissions");
String userName1= (String)session.getAttribute("userName");
%>




<div class="leftmenu">        
            <ul class="nav nav-tabs nav-stacked">
            	<li class="nav-header">Navigation</li>
            	<% if(permissions1.contains("dashboard.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                <li  <% if(pageName.equals("dashboard.jsp")){out.print("class=active");} %> ><a href="dashboard.jsp"><span class="iconfa-laptop"></span> Dashboard</a></li>
                <%}
                 if(permissions1.contains("client.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                <li <% if(pageName.equals("client.jsp")){out.print("class=active");} %> ><a href="client.jsp"><span class="iconfa-laptop"></span> Clients</a>
                <%}
                 if(permissions1.contains("scheme.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                <li <% if(pageName.equals("scheme.jsp")){out.print("class=active");} %>><a href="scheme.jsp"><span class="iconfa-laptop"></span> Scheme</a>
                </li>
                <% } %>
                
<!-- 				<li><a href="estimate.jsp"><span class="iconfa-laptop"></span> Estimate List</a></li> -->
                
                <li class="dropdown"><a href=""><span class="iconfa-laptop"></span> Master</a>
                	<ul>
                		<% if(permissions1.contains("scheme.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="scheme.jsp">Scheme</a></li>
                		<%}
                 		if(permissions1.contains("supplier.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="supplier.jsp">Supplier</a></li>
                		<%}
                 		if(permissions1.contains("scheme.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li ><a href="municipality.jsp">Municipality</a></li>
                    	<%}
                 		if(permissions1.contains("municipality.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="reference.jsp">Reference</a></li>
                    	<%}
                 		if(permissions1.contains("bank.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="bank.jsp">Bank</a></li>
                    	<%}
                 		if(permissions1.contains("office_expenses_item.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="office_expenses_item.jsp">Office Expenses Item</a></li>
                    	<%}
                 		if(permissions1.contains("mouja.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="mouja.jsp">Mouja Master</a></li>
                    	<%}
                 		if(permissions1.contains("police_station.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="police_station.jsp">Police Station Master</a></li>
                    	<%}
                 		if(permissions1.contains("district.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="district.jsp">District Master</a></li>
                    	<%}
                 		if(permissions1.contains("investor.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="investor.jsp">Investor Master</a></li>
                    	<%}
                 		if(permissions1.contains("buyer.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="buyer.jsp">Buyer Master</a></li>
                    	<%}
                 		if(permissions1.contains("projectmisc.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="projectmisc.jsp">Project Miscellaneous</a></li>
                    	<%}
                 		if(permissions1.contains("gst.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="gst.jsp">GST Master</a></li>
                    	<%}
                 		if(permissions1.contains("developer.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="developer.jsp">Developer Master</a></li>
                    	<%} %>
                    </ul>
                </li>
                
                <li class="dropdown"><a href=""><span class="iconfa-laptop"></span> Report</a>
                	<ul>
                		<%
                 		if(permissions1.contains("report_by_scheme.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="report_by_scheme.jsp"><span class="iconfa-laptop"></span>By Client</a></li>
                		<%}
                 		if(permissions1.contains("report_by_supplier_select.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="report_by_supplier_select.jsp"><span class="iconfa-laptop"></span>By Supplier</a></li>
                		<%}
                 		if(permissions1.contains("gst_report_by_scheme.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="gst_report_by_scheme.jsp"><span class="iconfa-laptop"></span>Gst Report</a></li>
                		<%} %>
                    </ul>
                </li>
				<li  class="dropdown"><a href=""><span class="iconfa-laptop"></span>Payment Due</a>
                	<ul>
                		<%
                 		if(permissions1.contains("gst_report_by_scheme.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="client_wise_payment_due.jsp">Payment Due From Client</a></li>
                		<%}
                 		if(permissions1.contains("gst_report_by_scheme.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                    	<li><a href="supplier.jsp">Payment Due to Supplier</a></li>
                    	<%} %>
                    </ul>
                </li>
               <!--  <li  class="dropdown"><a href=""><span class="iconfa-laptop"></span>Print</a>
                	<ul>
                    	<li><a href="">Invoice</a></li>
                        <li><a href="">Payment Due From Client</a></li>
                    </ul>
                </li> -->
                <%
                 		if(permissions1.contains("office_expenses.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                 <li <% if(pageName.equals("office_expenses.jsp")){out.print("class=active");} %>><a href="office_expenses.jsp"><span class="iconfa-laptop"></span>Office Expenses</a></li>
                 <%}
                 		if(permissions1.contains("projects.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                  <li <% if(pageName.equals("projects.jsp")){out.print("class=active");} %>><a href="projects.jsp"><span class="iconfa-laptop"></span>Project</a></li>
                  <%}
                 	%>
            <li class="dropdown"><a href=""><span class="iconfa-laptop"></span>Project Report</a>
                	<ul>
                		<%
                 		if(permissions1.contains("report_by_project_investment.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="report_by_project_investment.jsp"><span class="iconfa-laptop"></span>By Investment</a></li>
                		<%}
                 		if(permissions1.contains("report_by_project_expense.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="report_by_project_expense.jsp"><span class="iconfa-laptop"></span>By Expense</a></li>
                		<%}
                 		if(permissions1.contains("report_by_project_buyer.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="report_by_project_buyer.jsp"><span class="iconfa-laptop"></span>By Buyer Payment</a></li>
                		<%}
                 		if(permissions1.contains("report_all_project.jsp") || "admin".equalsIgnoreCase(userName1)) { %>
                		<li><a href="report_all_project.jsp"><span class="iconfa-laptop"></span>Total Report</a></li>
                		<%} %>
                    </ul>
                </li>
            </ul>
        </div><!--leftmenu-->