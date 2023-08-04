package servlets;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.fasterxml.jackson.databind.ObjectMapper;


/**
 * Servlet implementation class UploadBook
 */
@WebServlet("/UploadBook")
@MultipartConfig(location = "", maxFileSize = 10485760, maxRequestSize = 20971520, fileSizeThreshold = 5242880)
public class UploadBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UploadBook() {
        super();
  
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		if (request.getParameter("title") != null) {
		    // Retrieve form field values
		    String title = request.getParameter("title");
		    String author = request.getParameter("author");
		    double price = Double.parseDouble(request.getParameter("price"));
		    int quantity = Integer.parseInt(request.getParameter("quantity"));
		    String publisher = request.getParameter("publisher");
		    String publicationDate = request.getParameter("publicationDate");
		    String isbn = request.getParameter("isbn");
		    String genre = request.getParameter("genre");
		    double rating = Double.parseDouble(request.getParameter("rating"));
		    String description = request.getParameter("description");
		    String image = "";
		    
		    try {
		    	 	ObjectMapper obj = new ObjectMapper();
				    String key = "book/";
				    Part filePart = request.getPart("image");
				    
//				    InputStream fileInputStream = filePart.getInputStream();
//			        ByteArrayOutputStream output = new ByteArrayOutputStream();
//
//			        byte[] buffer = new byte[1024];
//			        int bytesRead;
//			        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
//			            output.write(buffer, 0, bytesRead);
//			        }
//
//			        byte[] fileContent = output.toByteArray();
//			        fileInputStream.close();
//
//			        // All bytes in 'fileContent' are guaranteed to be the content of the uploaded file.
//			        // Now, you can encode the content as Base64, if needed.
//			        byte[] encoded = java.util.Base64.getEncoder().encode(fileContent);
//			        String encodedFile = new String(encoded);
				    
//				    InputStream imageStream = filePart.getInputStream();
//				    byte[] imageBytes = imageStream.readAllBytes();
//				    String base64ImageData = Base64.encodeBase64String(imageBytes);
				    String fileName = filePart.getSubmittedFileName();
				    
				    System.out.println("FileName " + fileName);
				    
				    String submittedFileName = filePart.getSubmittedFileName();
				    int index = submittedFileName.indexOf(".");
				    if(index != -1) {
				    	fileName = title.toLowerCase() + submittedFileName.substring(index).trim();
				    }
				    else {
				    	
				    }
				    
//				    ImageRequest imagerequest = new ImageRequest();
//				    imagerequest.setImage_data(encodedFile);
//				    imagerequest.setKey(key);
//				    imagerequest.setImage_name(fileName);
//				    
//				    String json = obj.writeValueAsString(imagerequest);
//				    System.out.println(json);
				    
				    HttpClient httpClient = HttpClients.createDefault();
				    HttpPost httpPost = new HttpPost("http://localhost:8081/user-ws/uploadImage/book");

					MultipartEntityBuilder builder = MultipartEntityBuilder.create();
					builder.addBinaryBody("image", filePart.getInputStream(), ContentType.DEFAULT_BINARY, fileName);

					HttpEntity multipartEntity = builder.build();
					httpPost.setEntity(multipartEntity);

					HttpResponse httpResponse = httpClient.execute(httpPost);
					int statusCode = httpResponse.getStatusLine().getStatusCode();

					if (statusCode == 200) {
						HttpEntity httpEntity = httpResponse.getEntity();
						String responseStr = EntityUtils.toString(httpEntity);
						boolean condition = Boolean.parseBoolean(responseStr);
						if(condition) {
							System.out.println("Image uploaded successfully!");
						}
						// Image uploaded successfully
						// Handle the response if needed
					} 
					else {
						System.out.println("Image upload failed!");
						// Error occurred while uploading the image
						// Handle the error response if needed
					}
					
					image = "http://s3.us-east-1.amazonaws.com/horwart-images-charmtzy/" + fileName;
		    }
		    catch(Exception e) {
		    	e.printStackTrace();
		    }
		    
		    
		    

		    try {
		        Class.forName("com.mysql.jdbc.Driver");
		        String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC&useSSL=false";
		        Connection conn = DriverManager.getConnection(connURL);
		        
		        // Step 1: Retrieve the genre ID based on the selected genre name
		        PreparedStatement genreStmt = conn.prepareStatement("SELECT id FROM genre WHERE genre = ?");
		        genreStmt.setString(1, genre);
		        ResultSet genreRs = genreStmt.executeQuery();
		        
		        int genreId = -1; // Default value if genre is not found
		        if (genreRs.next()) {
		            genreId = genreRs.getInt("id");
		        }
		        
		        genreRs.close();
		        genreStmt.close();
		        
		        // Step 2: Insert the book into the books table with the corresponding genre_id
		        PreparedStatement pstmt = conn.prepareStatement("INSERT INTO books (title, author, price, quantity, publisher, publication_date, isbn, genre_id, rating, description, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		        pstmt.setString(1, title);
		        pstmt.setString(2, author);
		        pstmt.setDouble(3, price);
		        pstmt.setInt(4, quantity);
		        pstmt.setString(5, publisher);
		        pstmt.setString(6, publicationDate);
		        pstmt.setString(7, isbn);
		        pstmt.setInt(8, genreId);
		        pstmt.setDouble(9, rating);
		        pstmt.setString(10, description);
		        pstmt.setString(11, image);

		        pstmt.executeUpdate();
		        pstmt.close();
		        conn.close();
		        
		    } catch (ClassNotFoundException e) {
		        out.println("Error: " + e);
		    } catch (Exception e) {
		        out.println("Error: " + e);
		    }
		}
	}

}