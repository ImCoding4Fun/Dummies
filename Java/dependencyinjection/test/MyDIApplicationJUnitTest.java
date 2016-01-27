package dependencyinjection.test;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import dependencyinjection.Consumer;
import dependencyinjection.IMessageService;
import dependencyinjection.IMessageServiceInjector;
import dependencyinjection.MyDIApplication;

public class MyDIApplicationJUnitTest {
	private IMessageServiceInjector injector;
	
	@Before
	public void setUp(){
		//mock the injector with anonymous class
		injector = new IMessageServiceInjector() {
			
			@Override
			public Consumer getConsumer() {
				//mock the message service
				return new MyDIApplication(new IMessageService() {
					
					@Override
					public void sendMessage(String msg, String rec) {
						System.out.println("Mock Message Service implementation");
					}
				});
			}
		};
	}
	
	@Test
	public void test() {
		Consumer consumer = injector.getConsumer();
		consumer.processMessages("Hi Pankaj", "pankaj@abc.com");
	}
	
	@After
	public void tear(){
		injector = null;
	}
}
