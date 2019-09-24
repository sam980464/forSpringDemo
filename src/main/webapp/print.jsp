<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>

    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Email Sender</li>
        </ul>


        <div class="maincontent">
            <div class="maincontentinner">
				<div class="widget" id="client_not_selected">
				   <h4 class="widgettitle">Print Bill/Money Receipt</h4>
				   <div class="widgetcontent">
				   	<form action="ActionServlet" method="post" style="padding-left:20%">
					<table border="0" width="100%" align="center" style="font-size:15px;font-weight:bold;">
						
						<tr style="height:50px">
							<td width="25%">Print </td>
							<td><select><option>Money Receipt</option><option>Bill</option></select></td>
						</tr>
						<tr style="height:50px">
							<td>Customer </td>
							<td><select style="width:auto"><option value="358">ABDUL GHAFFAR ANSARI</option>
								
<option value="48">ABDUL KHALEQUE</option>
								
<option value="29">ABHRA DUTTA</option>
								
<option value="178">AJANTA BISWAS </option>
								
<option value="250">AJIT KR. GHOSH</option>
								
<option value="141">AJIT KR. GHOSH &amp; OTHRS</option>
								
<option value="131">AJOY BHATTACHARJEE &amp; OTHRS</option>
								
<option value="87">AJOY GHOSH &amp; OTHRS</option>
								
<option value="28">ALPANA SINGHA ROY</option>
								
<option value="117">AMAL KR. PATRA</option>
								
<option value="160">AMARENDRA NATH MONDAL &amp; OTHRS</option>
								
<option value="330">AMIYA CONSTRUCTION</option>
								
<option value="266">AMIYA KR. MONDAL</option>
								
<option value="18">AMIYA PAL</option>
								
<option value="289">ANAJIT GHOSH &amp; ANUP GHOSH</option>
								
<option value="239">ANAJIT GHOSH [ RADIANT TECHNO ]</option>
								
<option value="329">ANANDAMOY GHOSHAL</option>
								
<option value="91">ANANTA LAL SADHUKHAN</option>
								
<option value="111">ANATH BANDHU NANDI</option>
								
<option value="245">ANIMA DEY</option>
								
<option value="115">ANIRBAN DANDA</option>
								
<option value="124">ANIRBAN MUKHERJEE</option>
								
<option value="136">ANIRUDDHA SINGH</option>
								
<option value="344">ANIRUDH SINGH &amp; OTHRS</option>
								
<option value="163">ANITA CHOWDHURY &amp; OTHRS</option>
								
<option value="322">ANJALI GHATAK</option>
								
<option value="251">ANJALI GUHA &amp; OTHRS</option>
								
<option value="179">ANJAN PAL</option>
								
<option value="82">ANJANA GHOSH &amp; OTHRS</option>
								
<option value="175">ANUP BHOWMIK &amp; OTHRS</option>
								
<option value="297">ANUP KUMAR GHOSH</option>
								
<option value="265">ANUSREE ROY</option>
								
<option value="46">APARNA ROY &amp; OTHRS</option>
								
<option value="165">ARATI GHOSH &amp; OTHRS</option>
								
<option value="292">ARDHENDU SEKHA GHOSH &amp; SMT. NITA GHOSH</option>
								
<option value="77">ARUN KR. SADHUKHAN &amp; OTHRS</option>
								
<option value="277">ARUP CHOWDHURY</option>
								
<option value="260">ARUP KR DUTTA</option>
								
<option value="183">ARUP KR. MAITY</option>
								
<option value="57">ARUP KR. ROYCHOWDHURY &amp; OTHRS</option>
								
<option value="158">ARUP KUNDU</option>
								
<option value="209">ASHA PAI</option>
								
<option value="134">ASHIM BARMAN ROY</option>
								
<option value="79">ASHISH GUHA &amp; OTHRS</option>
								
<option value="271">ASHIT RANJAN BOSE</option>
								
<option value="296">ASHOK GHOSH &amp; SMT SIKHA GHOSH</option>
								
<option value="40">ASHOK KR. BHAKTA</option>
								
<option value="192">ASHOKE SANTRA &amp; OTHRS</option>
								
<option value="249">ASHOKE SHAW &amp; OTHRS</option>
								
<option value="248">ASHRAFUT ZAMA - SEC. MASJID COMM.</option>
								
<option value="113">ASIS KR. MAJUMDAR</option>
								
<option value="190">ASIT BARAN DAS</option>
								
<option value="215">ASOHK SINGH </option>
								
<option value="93">AYODHYA SHAW &amp; RAJENDAR SHAW</option>
								
<option value="321">BABURAM MONDAL</option>
								
<option value="39">BADAL BHATTACHARJEE</option>
								
<option value="255">BADAL CH. GHOSH &amp; OTHRS</option>
								
<option value="49">BANAMALI DEY JOARDER &amp; OTHRS</option>
								
<option value="137">BANDANA DUTTA</option>
								
<option value="166">BANDANA GHOSH &amp; OTHRS</option>
								
<option value="343">BANI ROY &amp; OTHRS</option>
								
<option value="230">BANSHI DHAR PAL</option>
								
<option value="12">BARNALI MAJUMDER</option>
								
<option value="85">BASANA RANI DUTTA</option>
								
<option value="10">BENI MADHAB DAS </option>
								
<option value="105">BHARATI GHOSH &amp; OTHRS</option>
								
<option value="352">BHARATI ROY</option>
								
<option value="187">BHASKAR BHATTACHARJEE</option>
								
<option value="22">BIBHAS DATTA [KALADA]</option>
								
<option value="235">BIBHUTI BHUSAN DAS</option>
								
<option value="96">BIBHUTI BHUSAN GHOSH</option>
								
<option value="337">BIJAN KR BISWAS</option>
								
<option value="60">BIJAN KR. BISWAS &amp; OTHRS</option>
								
<option value="180">BIJAY  MANDAL</option>
								
<option value="43">BIJOY KRISHNA DAS</option>
								
<option value="146">BIKASH &amp; BIJAN KR. ROY</option>
								
<option value="241">BIKASH GURUNG</option>
								
<option value="317">BIMAN CHOWDHURY &amp; OTHRS</option>
								
<option value="347">BINDU DUBEY</option>
								
<option value="306">BINOY SARKAR</option>
								
<option value="149">BIROJA PROSANNA BANERJEE</option>
								
<option value="104">BISTU GHOSH</option>
								
<option value="127">BISTU GHOSH &amp; OTHRS</option>
								
<option value="95">BISWAJIT KARAK</option>
								
<option value="331">BISWANATH BISWAS &amp; OTHRS</option>
								
<option value="286">BIVA CHAKRABOTY</option>
								
<option value="308">BRAJO GOPAL SARKAR</option>
								
<option value="257">BYOMKESH CH. GHOSH &amp; OTHRS</option>
								
<option value="116">CHANDANA BANERJEE</option>
								
<option value="342">CHANDRAKET SINGH &amp; BIRENDRA SINGH</option>
								
<option value="172">CHANDRANATH DHAR</option>
								
<option value="37">CHHABI MONDAL</option>
								
<option value="221">CHITTARANJAN SINGH</option>
								
<option value="99">CHUMKI RANI BANIK</option>
								
<option value="36">CONCORD DEVELOPERS</option>
								
<option value="324">DALIA DEY</option>
								
<option value="184">DEBDAS SINGHA &amp; OTHRS.</option>
								
<option value="254">DEBMAYA ROY &amp; OTHRS</option>
								
<option value="138">DHARMENDRA MAHARAJ &amp; OTHRS</option>
								
<option value="304">DILIP KARMAKAR</option>
								
<option value="75">DINESH CH. DAS</option>
								
<option value="191">DINESH MODI</option>
								
<option value="139">DIPAK DEBNATH</option>
								
<option value="173">DIPAK KR. BASU</option>
								
<option value="236">DIPAK KR. SINGHA &amp; OTHRS</option>
								
<option value="44">DIPALI GHOSH &amp; OTHRS</option>
								
<option value="33">DISHA EYE HOSPITAL</option>
								
<option value="227">GAURI RANI MUKHERJEE</option>
								
<option value="189">GIRINDRA CH. SARKAR</option>
								
<option value="125">GITA BANERJEE &amp; OTHRS</option>
								
<option value="41">GITA BISWAS &amp; OTHRS</option>
								
<option value="242">GITA RANI DAS &amp; OTHRS</option>
								
<option value="341">GOPAL CH GHOSH &amp; OTHRS</option>
								
<option value="170">GOURI CHOWDHURY</option>
								
<option value="156">GOURI DEY &amp; OTHRS</option>
								
<option value="226">HI TECH ABASAN PVT. LTD</option>
								
<option value="20">HIRANMOY MUKHERJEE</option>
								
<option value="217">HRISIKESH GHOSH &amp; OTHRS</option>
								
<option value="26">INDIAN SWEETS</option>
								
<option value="270">INDRADEEP DUTTA</option>
								
<option value="69">JAYANTA GHOSH</option>
								
<option value="312">JAYANTA GHOSHAL</option>
								
<option value="35">JAYANTI CINEMA MULTIPLEX</option>
								
<option value="240">JEET BAHADUR SUBBA</option>
								
<option value="293">JHARNA GHOSH</option>
								
<option value="232">JHARNA GHOSH &amp; OTHRS</option>
								
<option value="34">JHUMU DAS</option>
								
<option value="233">JIVAN SATHI TOURS &amp; TRAVELS PVT. LTD</option>
								
<option value="339">JOLLY CHAKRABORTY</option>
								
<option value="15">JOYDEB GHOSH</option>
								
<option value="327">JUGAL KISHORE DAS</option>
								
<option value="123">KAJAL CHATTERJEE</option>
								
<option value="353">KALISANKAR SARKAR &amp; OTHRS</option>
								
<option value="88">KALYAN  DEY</option>
								
<option value="276">KAMAKSHYA GHOSH</option>
								
<option value="106">KAMALA DEB &amp; APARNA ROY</option>
								
<option value="47">KAMALA MITRA &amp; OTHRS</option>
								
<option value="222">KAMALESH BHATTACHARJEE &amp; OTHRS</option>
								
<option value="238">KANCHAN KR. BISWAS</option>
								
<option value="305">KARTIK ROY</option>
								
<option value="319">KARUNA CHAKRABORTY &amp; OTHRS</option>
								
<option value="109">KAUSIK BHATTACHARJEE</option>
								
<option value="152">KISHOR PAUL</option>
								
<option value="205">KSHITISH CH. KARMAKAR</option>
								
<option value="273">KUSHAL KR GHSOH &amp; OTHRS</option>
								
<option value="338">LABANYAPRAVA MAJUMDER</option>
								
<option value="55">LILA DUTTA</option>
								
<option value="5">LINA DHAR</option>
								
<option value="94">MADAN BISWAS</option>
								
<option value="50">MADAN GHOSH</option>
								
<option value="355">MADHUSUDAN GHOSH &amp; OTHERS</option>
								
<option value="65">MAHADEB MALLICK</option>
								
<option value="204">MAHIJABIN BANO</option>
								
<option value="228">MAMIN ALI MONDAL</option>
								
<option value="193">MANABENDRA PAL</option>
								
<option value="23">MANARANJAN BISWAS</option>
								
<option value="362">MANGAL</option>
								
<option value="157">MANGAL CH. DAS</option>
								
<option value="361">MANGAL SHAW</option>
								
<option value="186">MANI MOHAN DAS</option>
								
<option value="223">MANJU ROY &amp; OTHRS</option>
								
<option value="201">MANJUSREE DEB ROY</option>
								
<option value="253">MANOJ KR. DAS</option>
								
<option value="13">MANORANJAN CHOWDHURY</option>
								
<option value="206">MANTU CH. DAS</option>
								
<option value="120">MAYA DAS</option>
								
<option value="108">MAYA ROY</option>
								
<option value="213">MIHIR BARAN RAKSHIT &amp; OTHRS</option>
								
<option value="174">MIHIR CH. DUTTA</option>
								
<option value="135">MINATI &amp; GURUDEV SINGHA</option>
								
<option value="132">MIR NURUL ANSER</option>
								
<option value="274">MIRA RANI BHADRA</option>
								
<option value="194">MIRA RANI DUTTA</option>
								
<option value="348">MITA KUNDU</option>
								
<option value="290">MOJIBUR RAHMAN [ ANSARI ] &amp; OTHRS</option>
								
<option value="285">MOUSUMEE SURAL</option>
								
<option value="264">NABARUN MONDAL</option>
								
<option value="143">NALINI RANJAN BISWAS</option>
								
<option value="280">NEEPA CHKRABORTY &amp; OTHRS</option>
								
<option value="268">NEMAI &amp; RUMA MONDAL</option>
								
<option value="103">NEMAI CHANDRA MONDAL</option>
								
<option value="31">NEMAI MISTRI</option>
								
<option value="83">NEPAL CH. GHOSH</option>
								
<option value="218">NIKUNJA DAS</option>
								
<option value="21">NILANJAN CHAKRABORTY</option>
								
<option value="252">NILU CHAKRABORTY</option>
								
<option value="102">NUPUR KRISHNA ROY</option>
								
<option value="278">OMPRAKASH AGARWAL</option>
								
<option value="188">OMPRAKASH AGARWAL [MANGALYAM NIRMAN ]</option>
								
<option value="9">PANCHANAN CHOWDHURY</option>
								
<option value="72">PANNA BHOWMIK &amp; OTHRS</option>
								
<option value="313">PARBATI DEBI &amp; OTHRS</option>
								
<option value="171">PARBATI DUTTA &amp; OTHRS</option>
								
<option value="122">PARITOSH KR. SARKAR</option>
								
<option value="212">PARITOSH PAUL</option>
								
<option value="167">PARTHA SINGHA ROY</option>
								
<option value="73">PIJUSH KANTI ROY CHOWDHURY</option>
								
<option value="272">PIJUSH KR. ROUTH</option>
								
<option value="112">PINAKI NARAYAN BANERJEE</option>
								
<option value="195">PINTU BHATTACHARJEE</option>
								
<option value="24">PINTU BISWAS &amp; OTHRS</option>
								
<option value="301">PIYARI CHETRI</option>
								
<option value="287">PLABAN KARAK</option>
								
<option value="211">PRABHAT KIRAN CHOWDHURY</option>
								
<option value="234">PRABIR DEBNATH &amp; OTHRS</option>
								
<option value="81">PRABIR KR. DUTTA &amp; OTHRS</option>
								
<option value="310">PRADIP BARAL</option>
								
<option value="346">PRADIP DASGUPTA &amp; OTHRS</option>
								
<option value="279">PRADIP HALDER &amp; PARTHA SARATHI HALDER</option>
								
<option value="356">PRADIP KR GHOSH</option>
								
<option value="349">PRADIP KR GHOSH &amp; SMT SUDHA GHOSH</option>
								
<option value="84">PRADIP KR. CHOWDHURY</option>
								
<option value="336">PRADIP PAKREY</option>
								
<option value="291">PRAFULLA CH. DUTTA</option>
								
<option value="14">PRAFULLA KR. SEN</option>
								
<option value="351">PRAKASH BACHAR</option>
								
<option value="219">PRALAY CH. SINHA</option>
								
<option value="142">PRANAB DEY</option>
								
<option value="101">PRASENJIT GHOSH &amp; OTHRS</option>
								
<option value="360">PRASENJIT NASKAR</option>
								
<option value="51">PRATAP DAS &amp; OTHRS</option>
								
<option value="63">PRATIMA DEY</option>
								
<option value="244">PRITAM GHOSH</option>
								
<option value="182">PRITAM SINGH</option>
								
<option value="246">PRITI DAS</option>
								
<option value="229">PUJA CHATTERJEE</option>
								
<option value="309">PURNIMA GOSWAMI [ GHOSH ]</option>
								
<option value="340">PUSPA RANI GHOSH</option>
								
<option value="295">RABIN DE</option>
								
<option value="56">RABINDRA NATH CHATTOPADHYAY</option>
								
<option value="52">RABINDRA NATH MALAKAR</option>
								
<option value="2">RAJEN ROY</option>
								
<option value="294">RAJENDRA NARAYAN &amp; CHAMPA GANGULY</option>
								
<option value="159">RAJESH RAJAK</option>
								
<option value="16">RAJIB CHAKRABORTY</option>
								
<option value="58">RAJIB GHOSH</option>
								
<option value="303">RAJU MAJUMDER</option>
								
<option value="92">RAKESH KR. SHAW</option>
								
<option value="176">RAKESH KR. SHRIVASTWA</option>
								
<option value="1">RAKESH OJHA</option>
								
<option value="323">RAMA PAL GHOSH</option>
								
<option value="133">RANAJIT NANDY</option>
								
<option value="8">RANI BALA DAS</option>
								
<option value="316">RANJAN DATTA</option>
								
<option value="86">RANJAN DUTTA</option>
								
<option value="320">RATAN KR. DEY</option>
								
<option value="30">RATNA ROY &amp; OTHRS</option>
								
<option value="224">REKHA TALAPATRA</option>
								
<option value="164">SABIR &amp; OTHRS</option>
								
<option value="225">SABITA DUTTA</option>
								
<option value="196">SABITRI CHOWDHURY &amp; OTHRS</option>
								
<option value="128">SABYASACHI DEY</option>
								
<option value="27">SADHUKHAN INFOCOM</option>
								
<option value="210">SAIKAT PAUL CHOWDHURY</option>
								
<option value="177">SAIKAT SINHA ROY &amp; OTHRS</option>
								
<option value="78">SAILENDRANATH GHOSH &amp; OTHRS</option>
								
<option value="208">SAMAR GHOSH &amp; OTHRS</option>
								
<option value="335">SAMBHU DUTTA</option>
								
<option value="140">SAMIR KR. BISWAS</option>
								
<option value="107">SAMIR KR. DATTA</option>
								
<option value="25">SAMIRAN DAS</option>
								
<option value="154">SANAT KR. DEY</option>
								
<option value="269">SANDHYA KUNDU &amp; OTHRS</option>
								
<option value="119">SANDHYA SEN</option>
								
<option value="357">SANDIP KR JAISWAL &amp; OTHRS</option>
								
<option value="275">SANJIB CHAKRABORTY &amp; OTHERS</option>
								
<option value="17">SANJIB KR . SINHA</option>
								
<option value="231">SANJIB KR. BISWAS</option>
								
<option value="32">SANJIB KR. NAG</option>
								
<option value="145">SANJIB ROY</option>
								
<option value="256">SANJOY KR. GHOSH</option>
								
<option value="61">SANTA BISWAS</option>
								
<option value="359">SANTANU BASU</option>
								
<option value="263">SANTILATA DEB</option>
								
<option value="110">SANTILATA PRAMANIK</option>
								
<option value="38">SARADA SISU SIKSHA NIKETAN</option>
								
<option value="80">SATYA NARAYAN GHATAK &amp; OTHRS</option>
								
<option value="68">SHANTI RANI GHOSH</option>
								
<option value="328">SHIB KUMAR JAISWARA</option>
								
<option value="220">SHIBANI BHUIYA &amp; SWAPAN SADHUKHAN</option>
								
<option value="333">SHIBNATH MUKHERJEE</option>
								
<option value="311">SHIBU BISWAS</option>
								
<option value="151">SHYAM SUNDAR HALDER</option>
								
<option value="307">SHYAMAL SARDAR &amp; OTHRS</option>
								
<option value="7">SIBANI SEN &amp; OTHRS</option>
								
<option value="314">SIMA SAHA</option>
								
<option value="345">SISHIR KR CHOWDHURY [ BARASAT ROAD ]</option>
								
<option value="76">SISIR KUMAR CHOWDHURY</option>
								
<option value="62">SK. SAFIAR RAHMAN</option>
								
<option value="354">SOMA BISWAS</option>
								
<option value="326">SOUMEN PAL</option>
								
<option value="203">SOUMYABRATA DAS</option>
								
<option value="130">SOURAV MUKHERJEE</option>
								
<option value="54">SRABANTI CHATTERJEE</option>
								
<option value="288">SUBAL CH GHOSH &amp; OTHRS</option>
								
<option value="67">SUBASH CHANDRA BASU</option>
								
<option value="148">SUBHABRATA PALIT</option>
								
<option value="126">SUBHASH CH. SWAIKA</option>
								
<option value="168">SUBHASISH SADHUKHAN</option>
								
<option value="334">SUBHENDU BISWAS</option>
								
<option value="332">SUBHRA DEY SARKAR</option>
								
<option value="169">SUBHRAJYOTI GHOSH</option>
								
<option value="259">SUBIR PRAMANIK</option>
								
<option value="53">SUBRATA DATTA</option>
								
<option value="42">SUBRATA GHOSH</option>
								
<option value="318">SUBRATA KR. BISWAS</option>
								
<option value="114">SUBRATA MAJUMDER</option>
								
<option value="153">SUBRATA SAMADDAR &amp; OTHRS</option>
								
<option value="98">SUBRATA SINGHA ROY [ VACANT LAND ]</option>
								
<option value="100">SUBRATAA SINGHA ROY</option>
								
<option value="6">SUDIPTA BARUA</option>
								
<option value="155">SUJIT KR. DEBNATH</option>
								
<option value="207">SUJIT ROY &amp; BARNALI ROY</option>
								
<option value="3">SUJOY SADHUKHAN</option>
								
<option value="284">SUJOY SENGUPTA</option>
								
<option value="90">SUKANTA MITRA</option>
								
<option value="214">SUKLA TALUKDAR &amp; OTHERS</option>
								
<option value="247">SULEKHA KUNDU</option>
								
<option value="45">SUMAN CHATTOPADHYAY</option>
								
<option value="315">SUMANA GHOSH [ BISWAS ]</option>
								
<option value="243">SUMITA BANERJEE &amp; OTHRS</option>
								
<option value="66">SUNANDA SENGUPTA &amp; OTHRS</option>
								
<option value="261">SUNIL KR. CHATTERJEE</option>
								
<option value="129">SUPRIYA SINGHA ROY</option>
								
<option value="325">SUPRIYO GHOSH &amp; AVIK GHOSH1</option>
								
<option value="299">SUSANTA BISWAS</option>
								
<option value="4">SUSANTA KR. MONDAL</option>
								
<option value="89">SUSANTA SINGHA ROY</option>
								
<option value="258">SUSHANTA SINGHA ROY-258</option>
								
<option value="262">SUSHANTA SINGHA ROY-262</option>
								
<option value="150">SUVRA ROY</option>
								
<option value="185">SWAPAN KR. BISWAS &amp; OTHRS</option>
								
<option value="59">SWAPAN KR. DUTTA &amp; OTHRS</option>
								
<option value="118">SWAPAN KR. GHOSH </option>
								
<option value="97">SWAPAN KR. MAJUMDER &amp; OTHRS</option>
								
<option value="302">SWAPAN SAHA</option>
								
<option value="71">SWAPAN SUR</option>
								
<option value="74">SWAPNA BOSE</option>
								
<option value="147">SWATI BAGHCHI</option>
								
<option value="19">SYAMAL KANTI BISWAS</option>
								
<option value="70">SYAMAL KUMAR SARKAR</option>
								
<option value="197">TANDRA BHATTACHARJEE</option>
								
<option value="202">TAPAN KR. DAS &amp; OTHRS</option>
								
<option value="161">TAPAN KR. DAS [ CHABI ]</option>
								
<option value="298">TAPAS BANERJEE &amp; OTHERS</option>
								
<option value="237">TAPAS DAS &amp; BIPLAB DAS</option>
								
<option value="64">TAPAS DAS &amp; OTHRS</option>
								
<option value="267">TAPASI GHOSH</option>
								
<option value="350">TAPATI ROY &amp; DIPA ROY</option>
								
<option value="181">TARAK CH. DEBNATH &amp; OTHRS</option></select></td>
						</tr>
						<tr style="height:50px">
							<td>Estimation List </td>
							<td><select style="width:auto">
								<option value="358">CONSTRUCTION::1000.00::2015-06-06</option>
								<option value="358">SUPERVISION::10000.00::2013-02-08</option>
							</select>
							</td>
						</tr>
						
						<tr style="height:50px">
							<td>Amount </td>
							<td>
								<input type="number" />
							</td>
						</tr>
						<tr style="height:50px">
							<td>Adjust Estimate </td>
							<td>
								<select style="width:auto">
								<option value="358">Yes</option>
								<option value="358">No</option>
							</select>
							</td>
						</tr>
						<tr style="height:50px">
							<td>Date </td>
							<td>
								<input id="datepicker" type="text" name="datecreated" class="input-small datepicker hasDatepicker" value="2018-11-13">
	  	
	  							<b>(YYYY-MM-DD)</b>
							</td>
						</tr>
						
						<tr style="height:100px">
							<td colspan="2" style="padding-left:20%"><input type="submit" class="btn btn-info" value="Print"/></td>
						</tr>
					</table>	
					<input type="hidden" name="todo" value="sendMail" />
				</form>

				   </div> 
	    		</div>
			</div>
			<%@ include file="common/foot.jsp" %>
			
		</div>
	</div>	







