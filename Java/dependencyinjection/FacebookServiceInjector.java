package dependencyinjection;

public class FacebookServiceInjector implements IMessageServiceInjector {
	
	@Override
    public Consumer getConsumer() {
        return new MyDIApplication(new FacebookServiceImpl());
    }
}
