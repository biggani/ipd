<%@ include file="/WEB-INF/template/include.jsp" %>
<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />

<table cellpadding="5" cellspacing="0" width="100%" id="queueList">
<tr align="center" >
	<th>#</th>
	<th><spring:message code="ipd.admissionDate"/></th>
	<th><spring:message code="ipd.patient.patientId"/></th>
	<th><spring:message code="ipd.patient.patientName"/></th>
	<th><spring:message code="ipd.patient.age"/></th>
	<th><spring:message code="ipd.patient.gender"/></th>
	<th><spring:message code="ipd.patient.admissionWard"/></th>
	<th><spring:message code="ipd.patient.bedNumber"/></th>
	<th><spring:message code="ipd.patient.admissionBy"/></th>
	<th><spring:message code="ipd.patient.action"/></th>
</tr>
<c:choose>
<c:when test="${not empty listPatientAdmitted}">
<c:forEach items="${listPatientAdmitted}" var="queue" varStatus="varStatus">
	<tr  align="center" class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } ' >
		<td><c:out value="${(( pagingUtil.currentPage - 1  ) * pagingUtil.pageSize ) + varStatus.count }"/></td>	
		<td><openmrs:formatDate date="${queue.admissionDate}" type="textbox"/></td>
		<td>
			<a href="#" title="Go to dashboard" onclick="ACT.go('gotoDashboard.htm?id=${queue.id}');">
				${queue.patientIdentifier}
			</a>
		</td>
		<td>${queue.patientName}</td>
		<td>${queue.age }</td>
		<td>${queue.gender}</td>
		<td width="50">${queue.admittedWard.name}</td>
		<td>${queue.bed}</td>
		<c:set var="person" value="${queue.ipdAdmittedUser.person }"/>
		<td width="50">${person.givenName} ${person.middleName } ${person.familyName }</td>
		<td><input type="button" class="ui-button ui-widget ui-state-default ui-corner-all"  value="Transfer" onclick="ADMITTED.transfer('${queue.id}');"/>
			<input type="button"  class="ui-button ui-widget ui-state-default ui-corner-all" value="Discharge" onclick="ADMITTED.discharge('${queue.id}');"/>
			<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Print" onclick="ADMITTED.print('${queue.id}');"/>
			<div id="printArea${queue.id}" style="display:none; margin: 10px auto; width: 981px; font-size: 1.5em;font-family:'Dot Matrix Normal',Arial,Helvetica,sans-serif;">
			<!-- 
			<img src="${pageContext.request.contextPath}/moduleResources/ipd/HEADEROPDSLIP.jpg" width="981" height="170"></img>
			 -->
			<p><b><h1>HOSPITAL</h1></b></p>
			
			<table width="100%" >
			<tr><td><spring:message code="ipd.patient.patientName"/>:&nbsp;<strong>${queue.patientName }</strong></td></tr>
			<tr><td><spring:message code="ipd.patient.patientId"/>:&nbsp;<strong>${queue.patientIdentifier}</strong></td></tr>
						<tr><td><spring:message code="ipd.patient.category"/>:&nbsp;<strong>${queue.patientCategory }</strong></td></tr>
			<tr><td><spring:message code="ipd.patient.age"/>:&nbsp;<strong>${queue.age}</strong></td></tr>
			<tr><td><spring:message code="ipd.patient.gender"/>:&nbsp;<strong>${queue.gender }</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.fatherName"/>: ${mapRelationName[queue.id]}</td></tr>
			<c:set var="personAddress" value="${queue.patient.personAddress }"/>
			<tr><td ><spring:message code="ipd.patient.homeAddress"/>: ${personAddress.countyDistrict } - ${personAddress.cityVillage }</td></tr>
			<tr></tr>
			<tr><td ><spring:message code="ipd.patient.monthlyIncome"/>: ${queue.monthlyIncome}</td></tr>
			<tr></tr>
			<tr><td ><spring:message code="ipd.patient.admittedWard"/>:<strong> ${queue.admittedWard.name}</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.treatingDoctor"/>:<strong> ${queue.ipdAdmittedUser.givenName}</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.bedNumber"/>: <strong>${queue.bed }</strong></td></tr>
		</table>
		<br/><br/><br/><br/><br/><br/>
		<span style="float:right;font-size: 1.5em">Signature of inventory clerk/ Stamp</span>
		</div>
		</td>
		
	</tr>
</c:forEach>
</c:when>
<c:otherwise>
<tr align="center" >
	<td colspan="6">No patient found</td>
</tr>
</c:otherwise>
</c:choose>
</table>