package com.github.savonik.chat.common;

import com.github.savonik.chat.client.Client;
import com.github.savonik.chat.client.UI;
import com.github.savonik.chat.server.Server;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;

/**
 * @author Tatiana Savonik
 */
public class Connection {

    private final Socket socket;
    private final BufferedReader in;
    private final BufferedWriter out;
    private final Thread thread;

    public Connection(Client client, String ipAdr, int port) throws IOException {

        UI ui = client.getUI();
        this.socket = new Socket(ipAdr, port);
        in = getBufferedReader(socket);
        out = getBufferedWriter(socket);

        thread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    ui.printMsg("Connection ready");
                    while (!thread.isInterrupted()) {
                        String msg = in.readLine();
                        ui.printMsg(msg);
                    }
                } catch (IOException e) {
                    disconnect();
                    e.printStackTrace();
                } finally {
                    ui.printMsg("Connection closed");
                }

            }
        });
        thread.start();
    }

    public Connection(Server server, Socket socket) throws IOException {

        this.socket = socket;
        in = getBufferedReader(socket);
        out = getBufferedWriter(socket);

        thread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    server.sendMsgToAllConnection( "New user joined");
                    while (!thread.isInterrupted()) {
                        String msg = in.readLine();
                        server.sendMsgToAllConnection(msg);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    server.removeConnection(Connection.this);
                    server.sendMsgToAllConnection("Client disconnected: " + Connection.this);
                }
            }
        });
        thread.start();
    }

    public synchronized void sendMsg(String msg) {
        try {
            out.write(msg + "\r\n");
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
            disconnect();
        }
    }

    public synchronized void disconnect() {
        thread.interrupt();
        try {
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private synchronized BufferedReader getBufferedReader(Socket socket) throws IOException {
        return new BufferedReader(new InputStreamReader(socket.getInputStream()));
    }

    private synchronized BufferedWriter getBufferedWriter(Socket socket) throws IOException {
        return new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
    }

}
