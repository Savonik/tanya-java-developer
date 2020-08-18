package com.github.savonik.chat.client;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * @author Tatiana Savonik
 */
public class UI extends JFrame implements ActionListener {
    
    private JTextArea conversation;
    private JTextField msg;
    private JTextField nickname;
    private final Client client;

    public UI(Client client) throws HeadlessException {
        this.client = client;
        this.init();
        this.setVisible(true);
    }

    private void init() {
        this.setSize(600, 600);
        this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        this.setName("Belegram");

        add(getConversationField(), BorderLayout.CENTER);
        add(getMsgField(), BorderLayout.SOUTH);
        msg.addActionListener(this);
        msg.setFont(new Font("My phone", Font.BOLD, 20));
        add(getNickname(), BorderLayout.NORTH);
    }

    private JTextField getNickname() {
        if (nickname != null) {
            return nickname;
        }
        nickname = new JTextField("Your name");
        nickname.setFont(new Font(" ", Font.BOLD, 22));
        nickname.setBackground(Color.pink);
        return nickname;
    }

    private JTextArea getConversationField() {
        if (conversation == null) {
            conversation = new JTextArea();
        }
        conversation.setFont(new Font(" ", Font.ITALIC, 20));
        conversation.setForeground(Color.WHITE);
        conversation.setBackground(Color.gray);
        conversation.setEditable(false);
        return conversation;
    }

    private JTextField getMsgField() {
        if (msg == null) {
            msg = new JTextField();
        }
        return msg;
    }

    public synchronized void printMsg(final String msg) {
        conversation.append(msg + "\n");
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String message = getMsgField().getText();
        if ("".equals(message.replace(" ", ""))) {
            return;
        }
        msg.setText(null);
        client.getConnection().sendMsg(nickname.getText() + ": " + message);
    }
}
