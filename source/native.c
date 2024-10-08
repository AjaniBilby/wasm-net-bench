#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define BACKLOG 100

void panic(int code, int lineNum) {
	if (code == 0) {
		return;
	}

	printf("Panic %d @ %d\n", code, lineNum);
	exit(code);
}

const char* response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: 13\r\n\r\nHello, World!";
int main() {
	int server_fd, new_socket, err = 0;
	struct sockaddr_in address = {0};
	int addrlen = sizeof(address);

	address.sin_family = AF_INET;
	address.sin_addr.s_addr = INADDR_ANY;
	address.sin_port = htons(8080);

	// Create socket
	server_fd = socket(AF_INET, SOCK_STREAM, 0);
	if (server_fd == 0) panic(0, 31);

	// Bind socket to address and port
	err = bind(server_fd, (struct sockaddr *)&address, sizeof(address));
	if (err < 0) panic(err, 35);

	// Listen for incoming connections
	err = listen(server_fd, BACKLOG);
	if (err < 0) panic(err, 39);

	while (1) {
		// Accept incoming connection
		err = (new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen));
		if (err < 0) panic(err, 44);

		// Send HTTP response
		ssize_t send_result = send(new_socket, response, strlen(response), 0);
		if (send_result < 0) panic(err, 48);

		// Shutdown and close the socket
		shutdown(new_socket, SHUT_RDWR);
		close(new_socket);
	}

	return 0;
}