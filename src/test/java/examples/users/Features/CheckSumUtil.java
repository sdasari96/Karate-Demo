package examples.users.Features;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class CheckSumUtil {

    /*public static void main(String[] args) {
        String hashString=new CheckSumUtil().getCheckSum("100001000021400|REGISTER_USER|20190626160449|6361812853","ZgWs13a3lm6a3COmLAEjOAwzPMT7S7nmViIWJiF0HW6WoaxWabmI3FkKRCZ29pmu51zQmf5dhTQCtVZE6smDsvgtknVkJzAbHsO6clJALmgC10ERZkFJTtSzJe63LavB9SV3WqBZk0zKYpafzUmnTBXQOkTJEVIIM8wfEj0gKysFJkRXdtfwGQvSQ3sFP9VNdlIZm2H08OsZjIl3asr4FYaPW1J6bpsAMz1jNpgYn1ZQ4KBHbYJxNFfu5QU12StN",
                "HmacSHA256");
        System.out.println(hashString);
    }*/



    public static String getCheckSum(String data, String secret, String algo){
        String digest = null;
        try {
            SecretKeySpec key = new SecretKeySpec((secret).getBytes("UTF-8"), algo);
            Mac mac = Mac.getInstance(algo);
            mac.init(key);

            byte[] bytes = mac.doFinal(data.getBytes("UTF-8"));

            StringBuffer hash = new StringBuffer();
            for (int i = 0; i < bytes.length; i++) {
                String hex = Integer.toHexString(0xFF & bytes[i]);
                if (hex.length() == 1) {
                    hash.append('0');
                }
                hash.append(hex);
            }
            digest = hash.toString();
        } catch(Exception e) {
            throw new RuntimeException(e);
        }
        return digest;
    }

    public static List<String> getCheckSumData(String api_name,String mobileNumber,String merchantId,String timestamp){

        if(timestamp==null) {
            timestamp = getCurrentTimeStamp();
        }

        String data = merchantId+"|"+api_name+"|"+timestamp+"|"+mobileNumber;

        System.out.printf("\n Data for which checksum should be generated : " + data);

        List<String> list = new ArrayList<>();

        System.out.println("\n Timestamp is : " + timestamp);

        list.add(data);
        list.add(timestamp);

        return list;

    }


    public String getCheckSumRefund(String merchantId, String apiName, String timestamp,String tranRefNo,String txnAmount,String orgJmTranRefNo,String orgTxnTimestamp,String additionalInfo,String checksumseed) {
        String resultString = "";
        //Map<String, String> requestDataMap = new ObjectMapper().convertValue(obj.getRequest().getPayloadData(), Map.class);
        //System.out.println(requestDataMap);
        if (merchantId != null)
            resultString += merchantId;
        if (apiName != null)
            resultString += "|" + apiName;
        if (timestamp != null)
            resultString += "|" + timestamp;
        if (tranRefNo != null)
            resultString += "|" + tranRefNo;
        if (txnAmount != null)
            resultString += "|" + txnAmount;
        if (orgJmTranRefNo != null)
            resultString += "|" + orgJmTranRefNo;
        if (orgTxnTimestamp != null)
            resultString += "|" + orgTxnTimestamp;
        if (additionalInfo != null)
            resultString += "|" + additionalInfo;
// Edge condition to handle extra pipes at the end of checksum string

        System.out.println(resultString);
        return getCheckSum(resultString, checksumseed, "HmacSHA256");
    }

    public String getCheckSumPurchase(String apiName,String timestamp, String apiVer, String clientId, String merchantId, String transRef, String txnType, String amount, String checksumseed) {
        String resultString = "";
        if (apiName != null)
            resultString += apiName;
        if (timestamp != null)
            resultString += "|" + timestamp;
        if (apiVer != null)
            resultString += "|" + apiVer ;
        if (clientId != null)
            resultString += "|" + clientId;
        if (merchantId != null)
            resultString += "|" + merchantId;
        if (transRef != null)
            resultString += "|" + transRef;
        if (txnType != null)
            resultString += "|" + txnType;
        if (amount != null)
            resultString += "|" + amount;
        if (amount != null)
            resultString += "|123456789";
        if (amount != null)
            resultString += "|9324739689";
        if (amount != null)
            resultString += "|UPI";
        if (amount != null)
            resultString += "||||||";
        if (amount != null)
            resultString += "|9324739689@jio";
        if (amount != null)
            resultString += "|30||";
// Edge condition to handle extra pipes at the end of checksum string

        System.out.println(resultString);
        return getCheckSum(resultString, checksumseed, "HmacSHA256");
    }

    public static String getTransReference(){

        String AlphaNumericString = "abcdefghijklmnopqrstuvwxyz"
                + "0123456789" ;

        StringBuilder sb = new StringBuilder(12);

        for (int i = 0; i < 10; i++) {

            int index
                    = (int)(AlphaNumericString.length()
                    * Math.random());

            sb.append(AlphaNumericString
                    .charAt(index));
        }

        return sb.toString().toUpperCase();
    }

    public static String getCurrentTimeStamp(){
        DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        Date date = new Date();
        String timestamp = dateFormat.format(date);

        return timestamp;
    }

    public static String getDate(int noOfHours){
        Calendar calendar= Calendar.getInstance();
        calendar.add(Calendar.HOUR,noOfHours);

        String finalDate=new SimpleDateFormat("yyyyMMddHHmmss").format(calendar.getTime());
        return finalDate;
    }

}

