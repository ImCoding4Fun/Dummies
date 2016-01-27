package dependencyinjection;

public class EmailServiceImpl implements IMessageService {
    
	@Override
    public void sendMessage(String msg, String rec) {
        //logic to send email
        System.out.println("Email sent to "+rec+ " with Message="+msg);
    }
}

