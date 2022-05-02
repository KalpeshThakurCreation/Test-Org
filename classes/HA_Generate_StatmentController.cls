public class HA_Generate_StatmentController {
    private Contact contactRecord;
    private ApexPages.StandardController sctrl;
    public Date startDate                 {get;set;}
    public Date endDate                   {get;set;}
    public Boolean showEmailSent          {get; set;}
    public Boolean showLogo               {get; set;}
    public String contactId               {get;set;}
    public HA_Generate_StatmentController(ApexPages.StandardController stdController) {
        this.sctrl = stdController;
        this.contactID = stdController.getId();
        this.contactRecord = [select FirstName,LastName,MailingPostalCode,Id,Name,MailingStreet,MailingState,MailingCountry,Email,Donor_Id__c From Contact Where Id=:stdController.getId()];
        this.showLogo = true;
        this.startDate = Date.newInstance(System.Today().year(),1,1);
        this.endDate = System.today();  
    }
    
   
        public pageReference show_SendEmail(){
          showEmailSent = false;
         return null;
        }
    public PageReference back()
    {
        PageReference cancel = sctrl.cancel();
        return cancel;
    }
    public pageReference sendEmail(){
        String subject = 'Donation Statement From '+startDate.format()+' To '+endDate.format();
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        PageReference pref = page.Donation_Statement_PDF; 
        pref.getParameters().put('Id',(String)this.contactRecord.Id);
        pref.getParameters().put('sDate',startDate.format());
        pref.getParameters().put('eDate',endDate.format());
        pref.setRedirect(true);
        Blob b = (Test.isRunningTest())?Blob.valueOf('This is the Test Class'):pref.getContent();
        attach.setFileName(subject +'.pdf');
        attach.setBody(b);
        semail.setToAddresses(new String[] { this.contactRecord.Id});
        semail.setSubject(subject);   
        //semail.setTargetObjectId(this.contactId);
        //semail.setTemplateId(Label.Generate_Donation_Template_Id);
        String messageBody = '<html><body>Salaam '+this.contactRecord.FirstName+',<br/> Thank you for your support.<br/>  Please find the attachment of your donation statement for the period '+startDate.format()+' To '+endDate.format()+'.<br/><br/>Regards,<br/>'+
            +'<b>Human Appeal Customer Care</b><br/>Email: customercare@humanappeal.org.uk<br/>'+
            +'HUMAN APPEAL • Cheadle Point, Carrs Road, Cheadle, SK8 2BL, UK <br/>'+
            +'humanappeal.org.uk • info@humanappeal.org.uk • 0161 225 0225 <br/>'+
            +'Charity Reg No. 1154288 • Company Reg No. 8553893 • Scottish Reg No. SC056481 <br/>'+
        +'</body>  </html>';
        semail.setHtmlBody(messageBody); 
        
        semail.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail}, true);
        showEmailSent = true;
        return null;
    }
     
    
    
    
    
}