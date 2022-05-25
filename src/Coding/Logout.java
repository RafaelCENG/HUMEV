package Coding;

import Forms.LoginForm;
import javax.swing.JFrame;

public class Logout {
    public static void logOut(JFrame context, LoginForm loginScreen){
        LoginSession.isLoggedIn = false;
        context.setVisible(false);
        loginScreen.setVisible(true);
    }
}
