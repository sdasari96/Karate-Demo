package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

public class JavaFunctions {

    public String nonStaticFunction(String arg)
    {
        System.out.println("This is Non Static Function");
        return "Non Static Function: "+arg;
    }

    public static String staticFunction(String arg)
    {
        System.out.println("This is Static Function");
        return "Static Function: "+arg;
    }

    public String writeData(String data)
    {
        PrintWriter printWriter = null;
        try {
            printWriter = new PrintWriter("data.txt","UTF-8");
            printWriter.println(data);
            printWriter.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Data entered";

    }
    public static String writeData(String filename,String data)
    {
        PrintWriter printWriter = null;
        try {
            printWriter = new PrintWriter(filename,"UTF-8");
            printWriter.println(data);
            printWriter.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Data entered";

    }
}
