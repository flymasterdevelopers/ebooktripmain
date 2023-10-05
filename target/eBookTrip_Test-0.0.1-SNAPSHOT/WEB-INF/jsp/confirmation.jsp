<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Flight Confirmation</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href='https://fonts.googleapis.com/css?family=Chivo' rel='stylesheet'>
        <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet'>
        <link rel="stylesheet" href="/resources/css/confirmation.css" type="text/css">
        <link rel="icon" href="/resources/images/favicon.png">
		
		<script>
			function timeConvert(n) {
		var num = n;
		var hours = (num / 60);
		var rhours = Math.floor(hours);
		var minutes = (hours - rhours) * 60;
		var rminutes = Math.round(minutes);
		return rhours + " h " + rminutes + " m";
		}
		
		function getCabin(id)
		{
				var cabin = "Economy";
				if(id == 1){
					cabin = "Economy";
				}
				else if(id == 2){
					cabin = "Premium Economy";
				}
				else if(id == 3){
					cabin = "Business";
				}
				else if(id == 4){
					cabin = "First";
				}
				return cabin;
		}
		</script>

    <jsp:include page="tag-manager-head.jsp" />
    
    <!-- Event snippet for conversion page -->  
    
<script>
dataLayer.push({
'value': '<fmt:formatNumber type="number" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.grandTotal}"/>',
'currency': 'USD',
'trip_type': <c:choose><c:when test="${searchRequest.tripType==1}">'OneWay'</c:when><c:when test="${searchRequest.tripType==2}">'RoundTrip'</c:when><c:otherwise>'Other'</c:otherwise></c:choose>,
'passengers_total': ${searchRequest.adults+searchRequest.child+searchRequest.infantsWs+searchRequest.infants},
'passengers_adult': ${searchRequest.adults},
'passengers_child': ${searchRequest.child},
'passengers_infant_in_seat': ${searchRequest.infantsWs},
'passengers_infant_in_lap': ${searchRequest.infants},       
'items': [<c:forEach var="outbound" items="${bookingRequest.flightResult.outBound}" varStatus="loop"><c:set var = "vOutCount" scope = "session" value = "${loop.count}"/></c:forEach><c:forEach var="outbound" items="${bookingRequest.flightResult.outBound}" varStatus="loop">
{
	'travel_class':<c:choose><c:when test="${outbound.cabinClass==1}">'Economy'</c:when><c:when test="${outbound.cabinClass==2}">'Premium Economy'</c:when><c:when test="${outbound.cabinClass==3}">'Business'</c:when><c:when test="${outbound.cabinClass==4}">'First'</c:when><c:otherwise>'Economy'</c:otherwise></c:choose>,
	'fare_product':<c:choose><c:when test="${outbound.cabinClass==1}">'Economy'</c:when><c:when test="${outbound.cabinClass==2}">'Premium Economy'</c:when><c:when test="${outbound.cabinClass==3}">'Business'</c:when><c:when test="${outbound.cabinClass==4}">'First'</c:when><c:otherwise>'Economy'</c:otherwise></c:choose>,
	'booking_code':'${outbound.resDesignCode}',
	'flight_number':'${outbound.airline}${outbound.flightNo}',
	'origin':'${outbound.fromAirport}',
	'destination':'${outbound.toAirport}',
	'start_date':'${outbound.depDate.split("T")[0]}',
}<c:choose><c:when test="${vOutCount!=loop.count}">,</c:when><c:when test="${vOutCount==loop.count}"></c:when></c:choose></c:forEach><c:if test="${searchRequest.tripType==2}">
<c:forEach var="inbound" items="${bookingRequest.flightResult.inBound}" varStatus="loop">,{
	'travel_class':<c:choose><c:when test="${inbound.cabinClass==1}">'Economy'</c:when><c:when test="${inbound.cabinClass==2}">'Premium Economy'</c:when><c:when test="${inbound.cabinClass==3}">'Business'</c:when><c:when test="${inbound.cabinClass==4}">'First'</c:when><c:otherwise>'Economy'</c:otherwise></c:choose>,
	'fare_product': <c:choose><c:when test="${inbound.cabinClass==1}">'Economy'</c:when><c:when test="${inbound.cabinClass==2}">'Premium Economy'</c:when><c:when test="${inbound.cabinClass==3}">'Business'</c:when><c:when test="${inbound.cabinClass==4}">'First'</c:when><c:otherwise>'Economy'</c:otherwise></c:choose>,
	'booking_code':'${inbound.resDesignCode}',
	'flight_number':'${inbound.airline}${inbound.flightNo}',
	'origin':'${inbound.fromAirport}',
	'destination':'${inbound.toAirport}',
	'start_date':'${inbound.depDate.split("T")[0]}',
}
</c:forEach></c:if>]});



</script>
    
    
    
    </head>
    <body><jsp:include page="tag-manager-body.jsp" />
        <!--Header Area Starts Here-->
        <div class="header">
            <div class="logo-fh">
                <a href="/"><img src="/resources/images/logo.png"></a>
            </div>
            <div class="navbar-main">
                <div class="expert-talk">
            <a href="tel:+1(800)404-0025"><span>Get Customer Support: </span><span> +1-800-404-0025</span></a>
            </div>
            </div>
            <div class="side-navbar-button" style="display:none">
                <button type="button" onclick="showsidenav()"><i class="fa fa-bars"></i></button>
            </div>
        </div>
        <div class="side-navbar" id="sidenavbar">
            <li><button type="button" onclick="hidesidenav()"><i class="fa fa-close"></i></button></li>
            <!-- <li><a href="#">Sign In</a></li>
            <li><a href="#">Register</a></li>
            <li><a href="#">My Bookings</a></li>
            <li><a href="#">Customer Support</a></li>
            <li><a href="#">Track Credit/Refund</a></li> -->
            <li><a href="/contactus">Contact Us</a></li>
        <li><a href="/terms-and-conditions">Terms & Conditions</a></li>
        <li><a href="/privacy-policy">Privacy Policy</a></li>
            <p>&copy 2020 Ebooktrip.com All Rights Reserved</p>
        </div>
	
	<!-- ladybug Pixel Work -->
	<img src="//pix.ladybug.com/pix/conversion.pic?partner=7821&value=<c:out value='${bookingRequest.flightResult.fare.grandTotal}' />">
	<!-- ladybug Pixel Work -->
	
        <div class="screen-overlay" id="screenoverlay" onclick="hidesidenav();"></div>
        <div id="screenoverlay2" onclick="enginehide();"></div>
        <div class="mycontainer">
        	<c:choose>
        	<c:when test="${bookingRequest.getSourceMedia() eq 'google'}">
        	   <div class="booking-confirm">
                <img src="/resources/images/confirm.png">
                <div>Payment Successful - Your trip is now booked and in process.</div>
                <div>Your E-Tickets will be sent shortly in a separate email once the process is completed.</div>
                <div>For immediate help on your booking, please call us at <a href="tel:+1(800)404-0025"> +1-800-404-0025</a> between 8am to 9pm (EST).</div>
                <div>Your booking reference number is</div>
                <div class="ebookbookingid">${bookingRequest.bookingID}</div>
        	</c:when>
        	<c:otherwise>
        		<div class="booking-confirm">
                <img src="/resources/images/confirm.png">
                <div>Your trip is now booked and in process.</div>
                <div>Your E-Tickets will be sent shortly in a separate email once the process is completed.</div>
                <div>For immediate help on your booking, please call us at <a href="tel:+1(800)404-0025"> +1-800-404-0025</a> between 8am to 9pm (EST).</div>
                <div>Your booking reference number is</div>
                <div class="ebookbookingid">${bookingRequest.bookingID}</div>
            </div>
        	</c:otherwise>
        	</c:choose>
            <div class="flight-summary">
                <div class="fshead">
                    <i class="fa fa-plane"></i>&nbsp&nbspFlight Summary
                </div>
                <div class="dr-flights">
                    <div class="drfhead">Departure Flights <span>| 
					<fmt:parseDate value="${searchRequest.segment[0].travelDate}" var="dateObject" pattern="MM/dd/yyyy" />
					<fmt:formatDate value="${dateObject }" pattern="EEE, MMM dd yyyy" /></span></div> 
					
					<c:forEach var="outbound" items="${bookingRequest.flightResult.outBound}" varStatus="loop">
                    <div class="fdetails">
                        <div class="col1">
                            <div><img src="/resources/images/airline-logo/${outbound.airline}.png"> ${outbound.airlineName}</div>
							<c:set var="depDate" value="${fn:replace(outbound.depDate,'T', ' ')}" />
									<fmt:parseDate value="${depDate}" var="dateObject" pattern="yyyy-MM-dd HH:mm:ss" />
                            <div><fmt:formatDate value="${dateObject }" pattern="EEE, MMM dd" />,<fmt:formatDate value="${dateObject }" pattern="hh:mm a" /></div>
                            <div>${outbound.fromAirport}<span>(${outbound.froCityName})</span></div>
                            <div>${outbound.fromAirportName}</div>
                        </div>
                        <div class="col2">
                            <div>Flight No: <span>${outbound.flightNo}</span></div>
                            <c:if test="${not empty outbound.eft}">
                            	<div><i class="fa fa-clock-o"></i><span><script>document.write(timeConvert(<c:out value='${outbound.eft}' />))</script></span></div>
                            </c:if>
                            <div><i class="fa fa-long-arrow-right"></i></div>
                            <div>Non-Stop</div>
                        </div>
                        <div class="col3">
                            <div>Class: <span><script>document.write(getCabin(<c:out value='${outbound.cabinClass}' />))</script></span></div>
							<c:set var="reachDate" value="${fn:replace(outbound.reachDate,'T', ' ')}" />
									<fmt:parseDate value="${reachDate}" var="reachObject" pattern="yyyy-MM-dd HH:mm:ss" />
                            <div><fmt:formatDate value="${reachObject }" pattern="dd, MMM yyyy" />,<fmt:formatDate value="${reachObject }" pattern="hh:mm a" /></div>
                            <div>${outbound.toAirport}<span>(${outbound.toCityName})</span></div>
                            <div>${outbound.toAirportName}</div>
                        </div>
                    </div>
                    
                    <c:if test="${!loop.last}">
                    	<c:if test="${not empty outbound.layOverTime}">
                    		<h2 class="stop-divider"><span><i class="fa fa-clock-o"></i> <script>document.write(timeConvert(<c:out value='${outbound.layOverTime}' />))</script> layover in ${outbound.toCityName} (${outbound.toAirport})</span></h2>
						</c:if>
					</c:if>
					
                    </c:forEach>
                </div>
				<c:if test="${searchRequest.tripType != 1}">
                <hr>
                <div class="dr-flights">
                    <div class="drfhead">
					<c:if test="${searchRequest.tripType == 2}">Return Flights </c:if>
					<c:if test="${searchRequest.tripType == 3}">Departure Flights </c:if>
					<span>| 
					<fmt:parseDate value="${searchRequest.segment[1].travelDate}" var="dateObject" pattern="MM/dd/yyyy" />
					<fmt:formatDate value="${dateObject }" pattern="EEE, MMM dd yyyy" />
					</span></div>
					<c:forEach var="inbound" items="${bookingRequest.flightResult.inBound}" varStatus="loop">
                    <div class="fdetails">
                        <div class="col1">
                            <div><img src="/resources/images/airline-logo/${inbound.airline}.png"> ${inbound.airlineName}</div>
							<c:set var="depDate" value="${fn:replace(inbound.depDate,'T', ' ')}" />
							<fmt:parseDate value="${depDate}" var="dateObject" pattern="yyyy-MM-dd HH:mm:ss" />
                            <div><fmt:formatDate value="${dateObject }" pattern="EEE, MMM dd" />,<fmt:formatDate value="${dateObject }" pattern="hh:mm a" /></div>
                            <div>${inbound.fromAirport}<span>(${inbound.froCityName})</span></div>
                            <div>${inbound.fromAirportName}</div>
                        </div>
                        <div class="col2">
                            <div>Flight No: <span>${inbound.flightNo}</span></div>
                            <c:if test="${not empty inbound.eft}">
                            	<div><i class="fa fa-clock-o"></i><span><script>document.write(timeConvert(<c:out value='${inbound.eft}' />))</script></span></div>
                            </c:if>
                            <div><i class="fa fa-long-arrow-right"></i></div>
                            <div>Non-Stop</div>
                        </div>
                        <div class="col3">
                            <div>Class: <span><script>document.write(getCabin(<c:out value='${outbound.cabinClass}' />))</script></span></div>
							<c:set var="reachDate" value="${fn:replace(inbound.reachDate,'T', ' ')}" />
									<fmt:parseDate value="${reachDate}" var="reachObject" pattern="yyyy-MM-dd HH:mm:ss" />
                            <div><fmt:formatDate value="${reachObject }" pattern="dd, MMM yyyy" />,<fmt:formatDate value="${reachObject }" pattern="hh:mm a" /></div>
                            <div>${inbound.toAirport}<span>(${inbound.toCityName})</span></div>
                            <div>${inbound.toAirportName}</div>
                        </div>
                    </div>
                    
					<c:if test="${!loop.last}">
						<c:if test="${not empty inbound.layOverTime}">
                    		<h2 class="stop-divider"><span><i class="fa fa-clock-o"></i> <script>document.write(timeConvert(<c:out value='${inbound.layOverTime}' />))</script> layover in ${inbound.toCityName} (${inbound.toAirport})</span></h2>
						</c:if>
					</c:if>
					
					</c:forEach>
                </div>
				</c:if>
				<c:if test="${searchRequest.tripType == 3}">
				<c:forEach var="otherBound" items="${bookingRequest.flightResult.otherBound}" varStatus="loop">
				<div class="dr-flights">
                    <div class="drfhead">Departure Flights <span>| 
					<fmt:parseDate value="${searchRequest.segment[loop.index+2].travelDate}" var="dateObject" pattern="MM/dd/yyyy" />
					<fmt:formatDate value="${dateObject }" pattern="EEE, MMM dd yyyy" /></span></div>
					
					<c:forEach var="outbound" items="${otherBound}" varStatus="loop">
                    <div class="fdetails">
                        <div class="col1">
                            <div><img src="/resources/images/airline-logo/${outbound.airline}.png"> ${outbound.airlineName}</div>
							<c:set var="depDate" value="${fn:replace(outbound.depDate,'T', ' ')}" />
							<fmt:parseDate value="${depDate}" var="dateObject" pattern="yyyy-MM-dd HH:mm:ss" />
                            <div><fmt:formatDate value="${dateObject }" pattern="EEE, MMM dd" />,<fmt:formatDate value="${dateObject }" pattern="hh:mm a" /></div>
                            <div>${outbound.fromAirport}<span>(${outbound.froCityName})</span> </div>
                            <div>${outbound.fromAirportName}</div>
                        </div>
                        <div class="col2">
                            <div>Flight No: <span>${outbound.flightNo}</span></div>
                            <c:if test="${not empty outbound.eft}">
                            	<div><i class="fa fa-clock-o"></i><span><script>document.write(timeConvert(<c:out value='${outbound.eft}' />))</script></span></div>
                            </c:if>
                            <div><i class="fa fa-long-arrow-right"></i></div>
                            <div>Non-Stop</div>
                        </div>
                        <div class="col3">
                            <div>Class: <span><script>document.write(getCabin(<c:out value='${outbound.cabinClass}' />))</script></span></div>
							<c:set var="reachDate" value="${fn:replace(outbound.reachDate,'T', ' ')}" />
									<fmt:parseDate value="${reachDate}" var="reachObject" pattern="yyyy-MM-dd HH:mm:ss" />
                            <div><fmt:formatDate value="${reachObject }" pattern="dd, MMM yyyy" />,<fmt:formatDate value="${reachObject }" pattern="hh:mm a" /></div>
                            <div>${outbound.toAirport}<span>(${outbound.toCityName})</span></div>
                            <div>${outbound.toAirportName}</div>
                        </div>
                    </div>
                    
                    <c:if test="${!loop.last}">
                    	<c:if test="${not empty outbound.layOverTime}">
                    		<h2 class="stop-divider"><span><i class="fa fa-clock-o"></i> <script>document.write(timeConvert(<c:out value='${outbound.layOverTime}' />))</script> layover in ${outbound.toCityName} (${outbound.toAirport})</span></h2>
						</c:if>
					</c:if>
					
                    </c:forEach>
                </div>
				</c:forEach>
				</c:if>
            </div>
            <div class="traveler-details">
                <div class="tdhead">
                    <i class="fa fa-user"></i>&nbsp&nbspTraveler(s) Details
                </div>
                <table class="tdtable">
                    <tr>
                        <th>S.No</th>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>DOB</th>
                    </tr>
                    <c:forEach items="${bookingRequest.passengerDetails}" var="passenger" varStatus="indexed">
                    <tr>
                        <td>1.</td>
                        <td>${passenger.firstName} &nbsp; ${passenger.middleName} &nbsp; ${passenger.lastName}</td>
                        <c:if test="${passenger.gender == 1}">
                                  <td>Male</td> 
                                </c:if>
                                <c:if test="${passenger.gender == 2}">
                                  <td>Female</td> 
                                </c:if>
                        <td>${passenger.dobDay}/${passenger.dateOfMonth}/${passenger.dateOfYear}</td>
                    </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="contact-details">
                <div class="cdhead">
                    <i class="fa fa-phone"></i>&nbsp&nbspContact Details
                </div>
                <div class="cdtable">
                    <div>
                        <span>Billing Phone</span>
                        <span> ${bookingRequest.phoneNo}</span>
                    </div>
                    <div>
                        <span>Alternate Phone</span>
                        <span> ${bookingRequest.mobileNo}</span>
                    </div>
                    <div>
                        <span>Email</span>
                        <span> ${bookingRequest.emailID}</span>
                    </div>
                </div>
            </div>
            <div class="price-details">
                <div class="pdhead">
                    <i class="fa fa-money"></i>&nbsp&nbspPrice Details
                </div>
                <div class="person-price">
                    <div class="tpp">
                        <span><span><c:out value="${searchRequest.adults}" /></span> Traveler(s): <span>Adult</span></span>
                        <span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(bookingRequest.flightResult.fare.adultFare+bookingRequest.flightResult.fare.adultTax+bookingRequest.flightResult.fare.adultMarkup) * searchRequest.adults *currencyValue}"/> </span>
                    </div>
                    <div class="fcp">
                        <span>Flight Charges per <span>adult</span></span>
                        <span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(bookingRequest.flightResult.fare.adultFare+bookingRequest.flightResult.fare.adultTax+bookingRequest.flightResult.fare.adultMarkup)*currencyValue}"/> </span>
                    </div>
                    <%-- <div class="tfp">
                        <span>Taxes & Fees per <span>adult</span></span>
                        <span>$ <fmt:formatNumber type="number" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.adultTax+bookingRequest.flightResult.fare.adultMarkup}"/> </span>
                    </div> --%>
                </div>
				<c:if test="${searchRequest.child > 0}">
                <hr>
                <div class="person-price">
                    <div class="tpp">
                        <span><span><c:out value="${searchRequest.child}" /></span> Traveler(s): <span>Child</span></span>
                        <span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(bookingRequest.flightResult.fare.childFare+bookingRequest.flightResult.fare.childTax+bookingRequest.flightResult.fare.childMarkup) * searchRequest.child *currencyValue}"/></span>
                    </div>
                    <div class="fcp">
                        <span>Flight Charges per <span>child</span></span>
                        <span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(bookingRequest.flightResult.fare.childFare+bookingRequest.flightResult.fare.childTax+bookingRequest.flightResult.fare.childMarkup)*currencyValue}"/></span>
                    </div>
                    <%-- <div class="tfp">
                        <span>Taxes & Fees per <span>child</span></span>
                        <span>$ <fmt:formatNumber type="number" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.childTax+bookingRequest.flightResult.fare.childMarkup}"/></span>
                    </div> --%>
                </div>
				</c:if>
				<c:if test="${searchRequest.infants > 0}">
                <hr>
                <div class="person-price">
                    <div class="tpp">
                        <span><span><c:out value="${searchRequest.infants}" /></span> Traveler(s): <span>Infant</span></span>
                        <span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(bookingRequest.flightResult.fare.infantFare+bookingRequest.flightResult.fare.infantTax+bookingRequest.flightResult.fare.infantMarkup) * searchRequest.infants *currencyValue}"/></span>
                    </div>
                    <div class="fcp">
                        <span>Flight Charges per <span>Infant</span></span>
                        <span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(bookingRequest.flightResult.fare.infantFare+bookingRequest.flightResult.fare.infantTax+bookingRequest.flightResult.fare.infantMarkup)*currencyValue}"/></span>
                    </div>
                    <%-- <div class="tfp">
                        <span>Taxes & Fees per <span>Infant</span></span>
                        <span>$ <fmt:formatNumber type="number" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantTax+bookingRequest.flightResult.fare.infantMarkup}"/></span>
                    </div> --%>
                </div>
				</c:if>
				<c:if test="${searchRequest.infantsWs > 0}">
                <hr>
                <div class="person-price">
                    <div class="tpp">
                        <span><span><c:out value="${searchRequest.infantsWs}" /></span> Traveler(s): <span>InfantWs</span></span>
                        <span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(bookingRequest.flightResult.fare.infantWsFare+bookingRequest.flightResult.fare.infantWsTax+bookingRequest.flightResult.fare.infantWsMarkup) * searchRequest.infantsWs *currencyValue}"/></span>
                    </div>
                    <div class="fcp">
                        <span>Flight Charges per <span>InfantWs</span></span>
                        <span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${(bookingRequest.flightResult.fare.infantWsFare+bookingRequest.flightResult.fare.infantWsTax+bookingRequest.flightResult.fare.infantWsMarkup)*currencyValue}"/></span>
                    </div>
                    <%-- <div class="tfp">
                        <span>Taxes & Fees per <span>InfantWs</span></span>
                        <span>$ <fmt:formatNumber type="number" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantWsTax+bookingRequest.flightResult.fare.infantWsMarkup}"/></span>
                    </div> --%>
                </div>
				</c:if>
				
				<c:set var="tgPrice" value="0.00" />
				<c:set var="pdpPrice" value="0.00" />
				<c:set var="taPrice" value="0.00" />
				
				<c:if test="${bookingRequest.travelGuard=='Yes'}">
					<c:set var="tgPrice" value="${bookingRequest.travelGuardCost}" />
					<div class="person-price">
                    	<div class="tpp">
                    		<span>Travel Insurance Insurance </span></span>
                    		<span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.travelGuardCost*currencyValue}"/></span>
                    	</div>
                    </div>
				</c:if>
				
				<c:if test="${bookingRequest.priceDropTaken=='Yes'}">
					<c:set var="pdpPrice" value="${bookingRequest.priceDropAmount}" />
					<div class="person-price">
                    	<div class="tpp">
                    		<span>Price Drop Protection</span></span>
                    		<span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.priceDropAmount*currencyValue}"/></span>
                    	</div>
                    </div>
				</c:if>
				
				<c:if test="${bookingRequest.travelAssistTaken=='Yes'}">
					<c:set var="taPrice" value="${bookingRequest.travelAssistAmount}" />
					<div class="person-price">
                    	<div class="tpp">
                    		<span>Travel Assist</span></span>
                    		<span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.travelAssistAmount*currencyValue}"/></span>
                    	</div>
                    </div>
				</c:if>
				
				<c:if test="${bookingRequest.webcheckin=='Yes'}">
					<c:set var="webPrice" value="${bookingRequest.webcheckincost}" />
					<div class="person-price">
                    	<div class="tpp">
                    		<span>Web Check-in</span></span>
                    		<span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.webcheckincost*currencyValue}"/></span>
                    	</div>
                    </div>
				</c:if>
				
				<c:if test="${bookingRequest.upgradeTaken=='Yes'}">
					<c:set var="upPrice" value="${bookingRequest.upgradeAmount}" />
					<div class="person-price">
                    	<div class="tpp">
                    		<span>Upgrade (<c:out value="${bookingRequest.upgradePlan}" />)</span></span>
                    		<span>${currencySymbol} <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.upgradeAmount*currencyValue}"/></span>
                    	</div>
                    </div>
				</c:if>
                <div class="total-price">
                    <span>Final Total:</span><span>${currencySymbol} <fmt:formatNumber type="number" maxFractionDigits="2" value="${(bookingRequest.flightResult.fare.grandTotal+tgPrice+pdpPrice+taPrice+upPrice+webPrice)*currencyValue}"/></span>
                </div>
                <p>NOTE: All Fares displayed are quoted in ${currencySymbol} and inclusive of base fare, taxes and all fees. Additional baggage fees may apply as per the airline policies.</p> 
            </div>
            <div class="tcs">
                <h4>e - Ticket Status</h4>
                <p>Your e-Ticket will be emailed shortly, once your credit card verification has been completed.</p>
                <p>
                    <span>Note :</span> We are handling your reservation and will send you the confirmation after the completion of the reservation procedure and a ticket has been issued.
                    It would be ideal if you take a note that your purchase will be completed only when the ticket has been issued. Fares are not guaranteed until ticketed. 
                    In the rare event fares increase, you may opt to cancel your booking by contacting our customer support help desk. 
                </p>
                <p><span>Please note: </span> Some Airlines may charge baggage fees.</p>
            </div>
        </div>
        <div class="footer2">
            <p style="text-align:center;margin:5px 0;">Copyright &copy;  2021 - 2023, Ebooktrip. All rights reserved</p>
        </div>
        <div class="footer-icons">
        </div>
    </body>
    </html>