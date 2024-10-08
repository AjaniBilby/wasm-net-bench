const net = require('net');

// Define the HTTP response
const response =
	"HTTP/1.1 200 OK\r\n" +
	"Content-Type: text/plain\r\n" +
	"Content-Length: 13\r\n\r\n" +
	"Hello, World!";

// Create a TCP server
const nothing = ()=>{};
const server = net.createServer((socket) => {
	socket.on("error", nothing);
	socket.write(response);
	socket.end();
});

// Define the port to listen on
const PORT = 8080;

// Start the server and listen for incoming requests
server.listen(PORT, () => {
	console.log(`Server listening on port ${PORT}`);
});
