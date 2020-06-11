package examples.users.Features;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.android.AndroidElement;
import io.appium.java_client.pagefactory.AndroidFindBy;
import io.appium.java_client.pagefactory.AppiumFieldDecorator;
import io.appium.java_client.remote.AndroidMobileCapabilityType;
import io.appium.java_client.remote.MobileCapabilityType;
import org.apache.logging.log4j.LogManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.io.IOException;
import java.net.URL;

public class MyJioMobilePage {

    public static AppiumDriver driver;
    public static WebDriverWait wait;

    @FindBy(xpath="//*[@text='MORE']")
    WebElement moreButton;

    @FindBy(xpath = "//*[@text='UPI']")
    private AndroidElement bhimUpi;

    @FindBy(xpath = "//*[@text='Pay']")
    public WebElement payUPIButton;

    @AndroidFindBy(id = "btnSendMoney")
    private AndroidElement sendMoneyBtn;

    @AndroidFindBy(id = "confirmDialogAmount")
    private MobileElement confirmDialogAmount;

    @AndroidFindBy(uiAutomator = "new UiSelector().text(\"Confirm\")")
    private MobileElement confirmButtonDialog;

    @AndroidFindBy(uiAutomator = "new UiSelector().text(\"ENTER UPI PIN\")")
    private AndroidElement npciPageTitle;

    @AndroidFindBy(xpath = "//android.widget.TableLayout//android.widget.ImageView[2]")
    private MobileElement submitButttonForMpin;

    @FindBy(id="tv_ref_no_value")
    private MobileElement referenceNumber;

    public MyJioMobilePage()
    {
        startAppiumServer();
        PageFactory.initElements(new AppiumFieldDecorator(driver),this);
        wait = new WebDriverWait(driver, 60);
    }


    public void startAppiumServer() {
        try
        {
            DesiredCapabilities cap = getDesireCapabilities();
            driver = new AndroidDriver(new URL("http://0.0.0.0:4723/wd/hub"), cap);
        }
        catch (Exception ex)
        {
            throw new RuntimeException("Error in starting appium server : "+ex.getMessage());
        }

    }


    public static DesiredCapabilities getDesireCapabilities() {
        DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability(CapabilityType.PLATFORM_NAME, "Android");
        capabilities.setCapability(CapabilityType.VERSION, "9");
        capabilities.setCapability("udid", "RZ8M51CE05A");
        capabilities.setCapability("deviceName", "a70q");
        capabilities.setCapability("appPackage", "com.jio.myjio");
        capabilities.setCapability("appActivity", "com.jio.myjio.dashboard.activities.DashboardActivity");
        capabilities.setCapability("noReset", true);
        capabilities.setCapability("autoGrantPermissions", true);
        capabilities.setCapability("newCommandTimeout", "100000");
        capabilities.setCapability("adbExecTimeout", "100000");
        return capabilities;
    }

    public String checkUPIRequestInMyjio()
    {
        String txnRef="";
        try {
            clickUpiTab();
            clickOnUPIPayCard();
            verifyAndConfirm("1.00");
            enterMpin("1357");
            waitForElement(referenceNumber);
            txnRef = referenceNumber.getText();
            System.out.println(txnRef);
        }
        catch (Exception ex)
        {
            throw new RuntimeException("Error in check UPI : "+ ex.getMessage());
        }
        return txnRef;
    }

    public void clickUpiTab() {
        waitForElement(moreButton);
        clickOnElement(moreButton);
        waitForElement(bhimUpi);
        clickOnElement(bhimUpi);
    }

    public void clickOnUPIPayCard()
    {
        waitForElement(payUPIButton);
        clickOnElement(payUPIButton);
        waitForElement(sendMoneyBtn);
        clickOnElement(sendMoneyBtn);
    }

    public void verifyAndConfirm(String amount) {
        String amountOnDialog = confirmDialogAmount.getText().split("₹")[1];
        if (amount.equals(amountOnDialog)) {
            clickOnElement(confirmButtonDialog);
        }
        else{
            throw new AssertionError("Entered amount "+amount+" and amount in the dialog "+amountOnDialog +" are not equal");
        }
    }

    public void waitForElement(WebElement element) {
        int retryCount = 0;
        while (retryCount < 5) {
            try {
                wait.until(ExpectedConditions.visibilityOf(element));
                break;
            } catch (Exception ex) {
                String desc = element + " is not VISIBLE";
                retryCount++;
            }
        }
    }
    public void clickOnElement(WebElement element) {
        try
        {
            element.click();

        }
        catch(Exception ex)
        {
            String desc=element+" not CLICKED";
        }
    }

    public void enterMpin(String mPin){
        waitForElement(npciPageTitle);
        for(int i=0;i<mPin.length();i++){
            char pin= mPin.charAt(i);
            driver.findElement(By.xpath("//android.widget.TextView[@text='"+pin+"']")).click();
        }
        clickOnElement(submitButttonForMpin);

    }

    public static void main(String[] args) {
        new MyJioMobilePage().checkUPIRequestInMyjio();
    }
}
