<%@page import="java.net.URLEncoder"%>
<%@page import="com.mongodb.client.model.Sorts"%>
<%@page import="com.mongodb.client.AggregateIterable"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bson.conversions.Bson"%>
<%@page import="com.mongodb.client.model.Accumulators"%>
<%@page import="com.mongodb.client.model.Aggregates"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.mongodb.client.FindIterable"%>
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
<link rel="stylesheet" href="AirBnbLauchPage.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous">
	
</script>

<title>AirBnb Property Types</title>
</head>
<body>
	<%
	MongoClient mongoClient = new MongoClient("localhost", 27017);
	MongoDatabase database = mongoClient.getDatabase("sample_airbnb");
	MongoCollection<Document> collection = database.getCollection("listingsAndReviews");

	AggregateIterable<Document> doc = collection.aggregate(Arrays.asList(
			Aggregates.group("$property_type", Accumulators.sum("count", 1)), Aggregates.sort(Sorts.descending("count"))));
	MongoCursor<Document> cursor = doc.iterator();
	Document res = null;
	%>
	<div class="container-fluid" style="padding-left: 50px">
		<div class="row justify-content-center">
			<%
			String property_type = "";
			int property_count = 0;
			while (cursor.hasNext()) {
				res = cursor.next();
				property_type = res.getString("_id");
				property_count = res.getInteger("count");
			%>
			<div class="p-3 col-md-4">
				<div class="card shadow h-100" style="width: 22rem;">
					<div class="inner">
						<a
							href="/AirBnbMongoProject/AirBnbPropertyList.jsp?property_type=<%=property_type%>">
							<%
							if (property_type.equalsIgnoreCase("Camper/RV")) {
							%> <img class="card-img-top" style="height: 18vw";
							src="images/Camper.jpg"> <%
							} else {
 							%> <img class="card-img-top" style="height: 18vw";
 							src="images/<%=property_type%>.jpg"
							alt="Card image cap"> 
							<%}%>
						</a>
					</div>
					<div class="card-body text-center">
						<H5 class="card-title"><%=property_type%></H5>
						<p class="card-text"><%=property_count%></p>
					</div>
				</div>
			</div>
			<%
			}
			mongoClient.close();
			%>
		</div>
	</div>
</body>
</html>