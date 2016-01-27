package dependencyinjection;

public class TwitterServiceImpl implements IMessageService {
	@Override
    public void sendMessage(String msg, String rec) {
        //logic to tweet to the receiver account
        System.out.println("Twitter mention to "+rec+ " with Message="+msg);
    }
}
