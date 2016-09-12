import Venice
import UDP

let statusCh = Channel<Bool>()

co {
	do {
		// create an echo server on localhost:5150
		let host = "127.0.0.1"
		let port = 5150
		let socket = try UDPSocket(ip: IP(port: port))
		print("UDPSocket listening at \(host):\(port)")

		// send status for the client to connect
		statusCh.send(true)

		while true {
			// waits for an incoming connection, receives 1024 bytes, sends them back
			let (data, sourceIP) = try socket.receive(upTo: 1024)
			print("received: \(data) from ip: \(sourceIP)")
			try socket.send(data, ip: sourceIP)
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

let waitCh = Channel<Void>()
waitCh.receive()
