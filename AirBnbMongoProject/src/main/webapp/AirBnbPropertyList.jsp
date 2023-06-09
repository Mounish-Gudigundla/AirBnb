<%@page import="java.net.URLEncoder"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.BasicBSONObject"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="org.bson.BsonDecimal128"%>
<%@page import="org.bson.types.Decimal128"%>
<%@page import="com.mongodb.client.model.Projections"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.client.model.Sorts"%>
<%@page import="com.mongodb.client.AggregateIterable"%>
<%@page import="com.mongodb.Block"%>
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
	crossorigin="anonymous"></script>
<meta charset="ISO-8859-1">
<title>AirBnb Property List</title>
</head>
<body>
	<p>
		<%
		String property_type = request.getParameter("property_type");
		MongoClient mongoClient = new MongoClient("localhost", 27017);
		MongoDatabase database = mongoClient.getDatabase("sample_airbnb");
		MongoCollection<Document> collection = database.getCollection("listingsAndReviews");

		AggregateIterable<Document> doc = collection.aggregate(Arrays.asList(
				Aggregates.match(Filters.and((Filters.eq("property_type", property_type)), Filters.nin("name", ""))),
				Aggregates.sort(Sorts.ascending("name"))));
		MongoCursor<Document> cursor = doc.iterator();
		Document res = null;
		%>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th scope="col">NAME</th>
				<th scope="col">ADDRESS</th>
				<th scope="col">PRICE</th>
				<th scope="col">BEDROOMS</th>
			</tr>
		</thead>
		<%
		String url = "";
		String property_name ="";
		while (cursor.hasNext()) {
			res = cursor.next();
			property_name = res.getString("name");
			url = "/AirBnbMongoProject/HotelDetails.jsp?property_name="+URLEncoder.encode(property_name);
		%>
		<tbody>
			<tr scope="row">
				<td><a
					href=<%=url %>><%=property_name%></a></td>
				<td><%=res.get("address", Document.class).get("street")%></td>
				<td><%=res.get("price")%></td>
				<td><%=res.getInteger("bedrooms")%></td>
			</tr>
		</tbody>
		<%
		}
		mongoClient.close();
		%>
	</table>
</body>
</html>