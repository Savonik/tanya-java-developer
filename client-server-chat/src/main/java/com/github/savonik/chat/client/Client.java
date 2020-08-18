package com.github.savonik.chat.client;

import com.github.savonik.chat.common.Connection;

import javax.swing.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.util.Scanner;

/**
 * @author Tatiana Savonik
 */
public class Client {

    private static final String IP_ADD = "localhost";
    private static final int PORT = 8189;
    private UI ui;
    private Connection connection;

    public Connection getConnection() {
        return connection;
    }

    public static void main(String[] args) {
        Client client = new Client();
        client.createConnection();
    }

    private void createConnection() {
        try {
            connection = new Connection(this, IP_ADD, PORT);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public UI getUI() {
        if (ui != null) {
            return ui;
        } else {
            ui = new UI(this);
            return ui;
        }
    }
}
    
   
    

