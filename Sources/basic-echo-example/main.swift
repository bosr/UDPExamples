import Venice
import UDP
import struct C7.Data

let statusCh = Channel<Bool>()

let serverPort = 5150
let clientPort = 5151

co {
	do {
		// create an echo server on localhost:5150
		let socket = try UDPSocket(ip: IP(port: serverPort))
		print("UDPSocket listening at 127.0.0.1:\(serverPort)")

		// send status for the client to connect
		statusCh.send(true)

		while true {
			// waits for an incoming connection, receives 1024 bytes, sends them back
			let (data, sourceIP) = try socket.receive(upTo: 1024)
			print("server side: received: \(data) from ip: \(sourceIP)")
			let destinationIP = sourceIP
			try socket.send(data, ip: destinationIP)
		}
	} catch {
		print(error)
		statusCh.send(false)
  }
}

// wait for the server to start
guard statusCh.receive()! else {
	print("Server could not start")
	exit(1)
}

print("creating the client")
// create a connection to UDP socket at localhost:5150
let clientSocket = try UDPSocket(ip: IP(port: clientPort))
try clientSocket.send(Data("Hello world"), ip: IP(port: serverPort))

let (data, sourceIP) = try clientSocket.receive(upTo: 1024)
print("client side: received: \(data) from ip: \(sourceIP)")
