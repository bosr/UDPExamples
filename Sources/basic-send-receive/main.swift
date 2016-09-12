import UDP
import struct C7.Data

let udpSocket = try? UDPSocket(ip: IP(port: 5050))
try udpSocket?.send(Data("Hello world"), ip: IP(port: 5051))
