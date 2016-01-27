package dependencyinjection;

public class SMSServiceImpl implements IMessageService {
	 
    @Override
    public void sendMessage(String msg, String rec) {
        //logic to send SMS
        System.out.println("SMS sent to "+rec+ " with Message="+msg);
    }
}