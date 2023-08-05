package servlets;

import java.util.ArrayList;

import dbaccess.Order;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

public class OrderDataFetcher {
	   public static ArrayList<Order> fetchOrdersData() {
	        ArrayList<Order> OrderList = new ArrayList<>();
	        try {
	            Client client = ClientBuilder.newClient();
	            String restUrl = "http://localhost:8081/user-ws/getAllOrder";
	            WebTarget target = client.target(restUrl);
	            Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
	            Response resp = invocationBuilder.get();
	            System.out.println("status:" + resp.getStatus());

	            if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
	                System.out.println("Success");
	                OrderList = resp.readEntity(new GenericType<ArrayList<Order>>() {});
	            } else {
	                System.out.println("failed");
	            }
	        } catch (Exception e) {
	            System.out.println("Exception: " + e);
	        }
	        return OrderList;
	    }
}
