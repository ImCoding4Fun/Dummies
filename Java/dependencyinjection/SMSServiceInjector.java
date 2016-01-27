package dependencyinjection;

public class SMSServiceInjector implements IMessageServiceInjector {
	
	@Override
    public Consumer getConsumer() {
        return new MyDIApplication(new SMSServiceImpl());
    }
}
