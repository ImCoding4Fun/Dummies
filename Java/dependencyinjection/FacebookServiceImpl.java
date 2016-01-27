package dependencyinjection;

public class FacebookServiceImpl implements IMessageService{
	@Override
    public void sendMessage(String msg, String rec) {
        //logic to post to the receiver Facebook wall
        System.out.println("Facebook post to "+rec+ " with Message="+msg);
    }
}
