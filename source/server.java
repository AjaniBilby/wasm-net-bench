import java.io.*;
import java.net.*;

public class server {
	private static final String RESPONSE =
		"HTTP/1.1 200 OK\r\n" +
		"Content-Type: text/plain\r\n" +
		"Content-Length: 13\r\n" +
		"\r\n" +
		"Hello, World!";
	private static final int PORT = 8080;
	private static final int BACKLOG = 100;

	public static void main(String[] args) {
		try {
			// Create server socket
			ServerSocket serverSocket = new ServerSocket(PORT, BACKLOG);
			System.out.println("Server listening on port " + PORT);

			while (true) {
				// Accept incoming connection
				Socket clientSocket = serverSocket.accept();

				// Write HTTP response
				OutputStream outputStream = clientSocket.getOutputStream();
				outputStream.write(RESPONSE.getBytes());
				outputStream.flush();

				// Shutdown and close the client socket
				clientSocket.shutdownOutput();
				clientSocket.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}
