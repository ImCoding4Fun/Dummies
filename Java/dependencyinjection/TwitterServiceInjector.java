package dependencyinjection;

public class TwitterServiceInjector implements IMessageServiceInjector {
	@Override
    public Consumer getConsumer() {
        return new MyDIApplication(new TwitterServiceImpl());
    }
}
