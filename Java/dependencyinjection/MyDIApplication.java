package dependencyinjection;

public class MyDIApplication implements Consumer {

	public MyDIApplication(IMessageService svc) {
		this.service = svc;
	}

	private IMessageService service;
	
	@Override
	public void processMessages(String msg, String rec) {
		//do some message validation, manipulation logic etc
        this.service.sendMessage(msg, rec);
	}
}
