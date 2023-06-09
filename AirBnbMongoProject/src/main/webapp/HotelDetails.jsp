<%@page import="java.net.URLEncoder"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.awt.Window"%>
<%@page import="com.mongodb.client.FindIterable"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.BasicBSONObject"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.MongoClient"%>
<%@page language="java" pageEncoding="utf-8"
	contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="HotelDetailsStyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<title>Property Details</title>
</head>
<body>

	<%
	MongoClient mongoClient = new MongoClient("localhost", 27017);
	MongoDatabase database = mongoClient.getDatabase("sample_airbnb");
	MongoCollection<Document> collection = database.getCollection("listingsAndReviews");

	Document document = collection.find(Filters.eq("name", request.getParameter("property_name"))).first();
	%>

	<div class="container">
		<div class="row">
		<div class="text-right p-1">
		<a href="/AirBnbMongoProject/index.jsp" class="btn btn-outline-dark pull-right" role="button" aria-pressed="true">Main Page</a>	
		</div>
			<h2>
				<a href="<%=document.get("host", Document.class).get("host_url")%>"
					target="_blank"><%=document.getString("name")%></a>
			</h2>
				</div>
		<div class="row">
			<div class="col-md-5">
				<img class="img-fluid"
					src="<%=document.get("images", Document.class).get("picture_url")%>"
					alt="Card image cap">
			</div>
			<div class="col-md-7">
				<p>
					<b>Id</b> :
					<%=document.get("_id")%></p>
				<p>
					<b>Name</b> :
					<%=document.getString("name")%></p>
				<p>
					<b>Summary</b> :
					<%=document.getString("summary")%></p>
				<p>
					<b>Interaction</b> :
					<%=document.getString("interaction")%></p>
				<p>
					<b>House Rules</b> :
					<%=document.getString("house_rules")%></p>
				<p>
					<b>Property Type</b> :
					<%=document.getString("property_type")%></p>
				<p>
					<b>Room Type</b> :
					<%=document.getString("room_type")%></p>
				<p>
					<b>Bed Type</b> :
					<%=document.getString("bed_type")%></p>
				<p>
					<b>Minimum Nights</b> :
					<%=document.getString("minimum_nights")%></p>
				<p>
					<b>Maximum Nights</b> :
					<%=document.getString("maximum_nights")%></p>
				<p>
					<b>Cancellation Policy</b> :
					<%=document.getString("cancellation_policy")%></p>
				<p>
					<b>Accommodates</b> :
					<%=document.getInteger("accommodates")%></p>
				<p>
					<b>Bedrooms</b> :
					<%=document.getInteger("bedrooms")%></p>
				<p>
					<b>Beds</b> :
					<%=document.getInteger("beds")%></p>
				<p>
					<b>Number Of Reviews</b> :
					<%=document.getInteger("number_of_reviews")%></p>
				<%
				Document doc = document.get("review_scores", Document.class);
				float rating = 0, stars = 0;
				if (!doc.isEmpty() && document.getInteger("number_of_reviews") != 0) {
					rating = doc.getInteger("review_scores_rating");
					stars = (Math.round(rating) / 20);
				%>

				<%
				if (!doc.isEmpty() && document.getInteger("number_of_reviews") != 0) {
					float accuracy = doc.getInteger("review_scores_accuracy");
					float cleanliness = doc.getInteger("review_scores_cleanliness");
					float checkin = doc.getInteger("review_scores_checkin");
					float communication = doc.getInteger("review_scores_communication");
					float location = doc.getInteger("review_scores_location");
					float value = doc.getInteger("review_scores_value");
					float barRating = doc.getInteger("review_scores_rating");
				%>
				<div class="container-fluid px-1 py-1 mx-auto">
					<div class="row">
						<div class="col-xl-7 col-lg-8 col-md-10 col-12 text-center mb-5">
							<div class="cardh">
								<div class="row justify-content-left d-flex">
									<div class="col-md-4 d-flex flex-column">
										<div class="rating-box">
											<h1 class="pt-4"><%=rating / 20%></h1>
											<p class="">out of 5</p>
										</div>
										<div>
											<%
											for (int i = 0; i < stars; i++) {
											%>
											<span class="fa fa-star star-active mx-1"></span>
											<%
											}
											%>
											<%
											for (int i = 0; i < 5 - stars; i++) {
												if (5 - stars == 1) {
											%>
											<span class="fa fa-star-half-full mx-1"
												style="color: #FBC02D"></span>
											<%
											} else {
											%>
											<span class="fa fa-star star-inactive mx-1"></span>

											<%
											}
											}
											%>

										</div>
									</div>
									<div class="col-md-8">
										<div class="rating-bar0 justify-content-center">
											<table class="text-left mx-auto">
												<tr>
													<td class="rating-label">accuracy</td>
													<td class="rating-bar">
														<div class="bar-container">
															<div class="bar" style="width :<%=accuracy * 10%>%"></div>
														</div>
													</td>
													<td class="text-right"><%=doc.getInteger("review_scores_accuracy")%></td>
												</tr>
												<tr>
													<td class="rating-label">cleanliness</td>
													<td class="rating-bar">
														<div class="bar-container">
															<div class="bar" style="width :<%=cleanliness * 10%>%"></div>
														</div>
													</td>
													<td class="text-right"><%=doc.getInteger("review_scores_cleanliness")%></td>
												</tr>
												<tr>
													<td class="rating-label">checkin</td>
													<td class="rating-bar">
														<div class="bar-container">
															<div class="bar" style="width :<%=checkin * 10%>%"></div>
														</div>
													</td>
													<td class="text-right"><%=doc.getInteger("review_scores_checkin")%></td>
												</tr>
												<tr>
													<td class="rating-label">communication</td>
													<td class="rating-bar">
														<div class="bar-container">
															<div class="bar" style="width :<%=communication * 10%>%"></div>
														</div>
													</td>
													<td class="text-right"><%=doc.getInteger("review_scores_communication")%></td>
												</tr>
												<tr>
													<td class="rating-label">location</td>
													<td class="rating-bar">
														<div class="bar-container">
															<div class="bar" style="width :<%=location * 10%>%"></div>
														</div>
													</td>
													<td class="text-right"><%=doc.getInteger("review_scores_location")%></td>
												</tr>
												<tr>
													<td class="rating-label">value</td>
													<td class="rating-bar">
														<div class="bar-container">
															<div class="bar" style="width :<%=value * 10%>%"></div>
														</div>
													</td>
													<td class="text-right"><%=doc.getInteger("review_scores_value")%></td>
												</tr>
												<tr>
													<td class="rating-label">rating</td>
													<td class="rating-bar">
														<div class="bar-container">
															<div class="bar" style="width : <%=barRating%>%"></div>
														</div>
													</td>
													<td class="text-right"><%=doc.getInteger("review_scores_rating")%></td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							%>

						</div>
					</div>
				</div>

			</div>
		</div>

		<div class="accordion accordion-flush"
			style="border-radius: 5px; background-color: #fff; padding-left: 15px; padding-right: 15px; margin-top: 20px; margin-bottom: 30px; padding-top: 15px; padding-bottom: 15px"
			id="accordionFlushExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="flush-headingOne">
					<button class="accordion-button collapsed"
						style="font-weight: bold" type="button" data-bs-toggle="collapse"
						data-bs-target="#flush-collapseOne" aria-expanded="false"
						aria-controls="flush-collapseOne">
						Reviews #
						<%=document.getInteger("number_of_reviews")%>
					</button>
				</h2>
				<div id="flush-collapseOne" class="accordion-collapse collapse"
					aria-labelledby="flush-headingOne"
					data-bs-parent="#accordionFlushExample">
					<%
					ArrayList<Document> reviews = document.get("reviews", ArrayList.class);
					Document review = null;
					if (!reviews.isEmpty()) {
						for (int i = 0; i < reviews.size(); i++) {
							review = reviews.get(i);
					%>
					<div class="accordion-body">
						<div class="cardh" style="width: 100%">
							<div class="row d-flex">
								<div class="">
									<img class="profile-pic"
										src="https://source.unsplash.com/random">
								</div>
								<div class="d-flex flex-column">
									<h3 class="mt-2 mb-0"><%=review.getString("reviewer_name")%></h3>
								</div>
								<div class="ml-auto">
									<p class="text-muted pt-5 pt-sm-3"><%=review.getDate("date")%></p>
								</div>
							</div>
							<div class="row text-left">
								<p class="content"><%=review.getString("comments")%></p>
							</div>
						</div>
					</div>
					<%}}} %>
				</div>
			</div>

		</div>
			<div class="container-fluid" style="padding-left: 10px">
		<div class="row justify-content-center">
			<%
			if (document != null || !document.isEmpty()) {
				BasicDBObject nearQuery = new BasicDBObject("address.location", new BasicDBObject("$near", new BasicDBObject("type",
				document.get("address", Document.class).get("location", Document.class).get("type")).append("coordinates",
						document.get("address", Document.class).get("location", Document.class).get("coordinates"))));
				FindIterable<Document> nearHotels = collection.find(nearQuery).limit(6);
				MongoCursor<Document> cur = nearHotels.iterator();
				Document nearbyhotel = null;
				while (cur.hasNext()){
					nearbyhotel = cur.next();
			%>
			<div class="p-3 col-md-2">
				<div class="card shadow h-100" style="width: 10rem;">
					<div class="inner">
						<a
							href="/AirBnbMongoProject/HotelDetails.jsp?property_name=<%=URLEncoder.encode(nearbyhotel.getString("name"))%>">
							<img class="card-img-top" style="height: 10vw;" src="<%=nearbyhotel.get("images", Document.class).get("picture_url")%>"
							alt="Card image cap">
						</a>
					</div>
					<div class="card-body text-center">
						<H5 class="card-title"><%=nearbyhotel.getString("name")%></H5>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>
	</div>
</body>
</html>