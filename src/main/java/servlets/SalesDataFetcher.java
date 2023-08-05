package servlets;

import dbaccess.Sale;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.ArrayList;

public class SalesDataFetcher {
    public static ArrayList<Sale> fetchSalesData() {
        ArrayList<Sale> saleList = new ArrayList<>();
        try {
            Client client = ClientBuilder.newClient();
            String restUrl = "http://localhost:8081/user-ws/getAllSale";
            WebTarget target = client.target(restUrl);
            Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
            Response resp = invocationBuilder.get();
            System.out.println("status:" + resp.getStatus());

            if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
                System.out.println("Success");
                saleList = resp.readEntity(new GenericType<ArrayList<Sale>>() {});
            } else {
                System.out.println("failed");
            }
        } catch (Exception e) {
            System.out.println("Exception: " + e);
        }
        return saleList;
    }
}
