const http = require('http');

// Define the HTTP response
const responseText = 'Hello, World!';

const server = http.createServer((req, res) => {
	res.writeHead(200, {
		'Content-Type': 'text/plain',
		'Content-Length': responseText.length // using ascii so it is bytes
	});

	// Send the response
	res.end(responseText);
});

// Define the port to listen on
const PORT = 8080;

// Start the server and listen for incoming requests
server.listen(PORT, () => {
	console.log(`Server listening on port ${PORT}`);
});
