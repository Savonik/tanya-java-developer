package com.github.savonik.chat.server;

import com.github.savonik.chat.common.Connection;

import java.io.IOException;
import java.net.ServerSocket;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Tatiana Savonik
 */
public class Server {
    
    private static final int PORT = 8189;
    private final List<Connection> connections = new ArrayList<>();
    
    public static void main(String[] args) {
        Server server = new Server();
        server.run();
    }
    
    public void run(){
        System.out.println("Server running...");
        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            while (true) {
                try {
                    connections.add(new Connection(this, serverSocket.accept()));
                } catch (IOException e) {
                  e.printStackTrace();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public synchronized void addConnection(Connection connection){
        connections.add(connection);
    }

    public synchronized void removeConnection(Connection connection){
        connections.remove(connection);
    }
    
    public synchronized void sendMsgToAllConnection(String msg){
        for (Connection connection: connections){
            connection.sendMsg(msg);
        }
    }
}
