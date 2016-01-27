package dependencyinjection.test;

import dependencyinjection.Consumer;
import dependencyinjection.EmailServiceInjector;
import dependencyinjection.FacebookServiceInjector;
import dependencyinjection.IMessageServiceInjector;
import dependencyinjection.SMSServiceInjector;
import dependencyinjection.TwitterServiceInjector;

public class MyMessageDITest {
	//Credits:
	//http://www.journaldev.com/2394/dependency-injection-design-pattern-in-java-example-tutorial
	public static void main(String[] args) {
		String msg = "Hi User8899";
		String email = "user@email.com";
		String phone = "888999888";
		String twitterAccount ="@user8899";
        String facebookAccount = "User8899";
        
		IMessageServiceInjector injector = null;
		Consumer app = null;
		
		//Send email
		injector = new EmailServiceInjector();
		app = injector.getConsumer();
		app.processMessages(msg, email);
		
		//Send SMS
		injector = new SMSServiceInjector();
		app = injector.getConsumer();
		app.processMessages(msg, phone);
		
		//Send Tweet
        injector = new TwitterServiceInjector();
        app = injector.getConsumer();
        app.processMessages(msg, twitterAccount);
        
        //Post to Facebook
        injector = new FacebookServiceInjector();
        app = injector.getConsumer();
        app.processMessages(msg, facebookAccount);
	}
}
