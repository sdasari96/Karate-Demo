package examples.users.Features;


import org.openqa.selenium.*;

import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import java.net.URL;
import java.util.concurrent.TimeUnit;
import io.appium.java_client.android.AndroidDriver;

public class AppiumConnector
{
    public static AndroidDriver androidDriver;

    public AppiumConnector()
    {

    }

    public static AndroidDriver getAndroidDriver() {
        try
        {
            androidDriver = new AndroidDriver(new URL("http://127.0.0.1:4723/wd/hub"),desireCapabilitiesForChrome());
            androidDriver.navigate().back();
            return androidDriver;
        }
        catch (Exception ex)
        {
            throw new RuntimeException("Error in getAndroidDriver(): "+ex.getMessage());
        }
    }

    public static String fetchOTP()
    {
        AndroidDriver androidDriver = getAndroidDriver();
        androidDriver.manage().timeouts().implicitlyWait(20, TimeUnit.SECONDS);
        androidDriver.openNotifications();
        androidDriver.manage().timeouts().implicitlyWait(40,TimeUnit.SECONDS);
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        String otpmessage= androidDriver.findElement(By.xpath("//*[@resource-id='android:id/message_text' and contains(@text,'OTP')]")).getText();
        //String otp=otpmessage.substring(16,22);
        //String otp = getAllIntegerInString(otpmessage).trim();
        System.out.println("******************************************************* \n"+otpmessage);
        String otp = otpmessage.replaceAll("[^0-9]","").trim();
        androidDriver.findElement(By.xpath("//android.widget.TextView[@resource-id='com.android.systemui:id/clear_all']")).click();
        androidDriver.quit();
        System.out.println("**********************otp******************** \n"+otp);
        return otp;
        //return "123456";
    }

public static DesiredCapabilities  desireCapabilitiesForChrome() {
        DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability(CapabilityType.PLATFORM_NAME,"Android");
        capabilities.setCapability(CapabilityType.VERSION,"9");
        capabilities.setCapability("udid", "RZ8M51CE05A");
        capabilities.setCapability("deviceName","GALAXY A70");
        capabilities.setCapability("appPackage","com.android.chrome");
        capabilities.setCapability("appActivity","com.google.android.apps.chrome.Main");
        return capabilities;
    }


    /*public static void main(String[] args) {
        fetchOTP();
    }*/


}
