package dependencyinjection;

public class EmailServiceInjector implements IMessageServiceInjector {
	
	@Override
    public Consumer getConsumer() {
        return new MyDIApplication(new EmailServiceImpl());
    }
}
