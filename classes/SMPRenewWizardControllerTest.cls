@isTest
public inherited sharing class SMPRenewWizardControllerTest {
  
    
    public static void CreateTestFrameWork()
    {
        TriggerSettings__c triggerSetting = new TriggerSettings__c();
        triggerSetting.Card_Payment_Trigger__c = false;
        triggerSetting.Direct_Debit_Trigger__c = false;

        insert triggerSetting;

        Account account = new Account(
            Name = 'Test'// Account Name      
          );
        insert account;

        Contact contact = new Contact(
            LastName = 'Test',
            Donor_ID__c = 'UK0188921',                                           // Donor ID
            AccountId = account.ID,                                       // Account Name
            npe01__PreferredPhone__c = 'Mobile',                                 // Preferred Phone
            Email = 'salma_93@hotmail.co.uk',                                    // Email
            MobilePhone = '07740030241',                                         // Mobile
            npe01__WorkPhone__c = '07740030241',                           // Work Phone
            MailingStreet = 'Test',
            MailingCity = 'Test',
            MailingCountry = 'Test',
            MailingPostalCode = 'Test'
            );
        insert contact;

        npe03__Recurring_Donation__c donation = new npe03__Recurring_Donation__c(
            npsp__RecurringType__c = 'Open',                         // Recurring Type
            npe03__Amount__c = 40.00,                                  // Amount
            npe03__Installment_Period__c = 'Monthly',                  // Installment Period
            npsp__InstallmentFrequency__c = 1,                       // Installment Frequency
            npsp__Day_of_Month__c = '1',                               // Day of Month
            npsp__StartDate__c = Date.today(),                         // Effective Date
            npe03__Next_Payment_Date__c = Date.today(),                // Next Donation Date
            npsp__PaymentMethod__c = 'Direct Debit',                   // Payment Method
            npe03__Contact__c = contact.Id,                     // Contact
            // Opportunity__c = '0064J00000CKDRZ',                        // Opportunity (Source)
            npe03__Date_Established__c = Date.today(),                 // Date Established
            npsp__Status__c = 'Active',                                // Status
            npsp__CurrentYearValue__c = 360.00,                        // Current Year Value
            npsp__NextYearValue__c = 480.00                           // Next Year Value
          );
          insert donation;
    }
    @isTest static void testGetRecurringDonation() 
    {
        CreateTestFrameWork();

        Id donationID = [SELECT Id FROM npe03__Recurring_Donation__c].Id;
        npe03__Recurring_Donation__c result = SMPRenewWizardController.getRecurringDonation(donationID);

        System.assertEquals(donationID, result.Id);
    }
   
    @isTest static void testSaveDirectDebitWithoutCurrentDirectDebit() 
    {

        CreateTestFrameWork();

        npe03__Recurring_Donation__c donation = [SELECT Id, npe03__Amount__c, Opportunity__c, Direct_Debit_Detail__c, npe03__Contact__c FROM npe03__Recurring_Donation__c];
        System.debug('#### donation: ' + donation);

        Income_Direct_Debit__c dd = new Income_Direct_Debit__c(
            Recurring_Donation__c = donation.Id,
            DD_Bank_Address__c = 'P.O. Box 8888, Nationwide Hse, Pipers Way',// DD Bank Address
            DD_Bank_City__c = 'Swindon L',                                     // DD Bank City
            DD_Bank_Postcode__c = 'SN38 1NW',                                  // DD Bank Postcode
            DD_Bank_Phone__c = '0800 302011',                                  // DD Bank Phone
            DD_Single_Account_Holder__c = false,                               // DD Single Account Holder
            DD_Status__c = 'Cancelled',                                        // Status
            DD_Collection_Day__c = '1',                                        // Collection Day
            DD_Bank_Sort_Code__c = '074456',                                   // Bank Sort Code
            DD_Collection_Period__c = 'Monthly',                               // Collection Period
            DD_Bank_Account_Number__c = '11104102',                            // Bank Account Number
            DD_Collection_Stretch__c = '1',                                    // Collection Stretch
            DD_Bank_Account_Name__c = 'Name',                                  // Bank Account Name
            DD_Collection_Type__c = 'Fixed',                                   // Collection Type
            DD_First_Collection_Amount__c = 40.00,                             // First Collection Amount
            DD_Collection_Reference__c = 'Donation',                           // Collection Reference
            DD_Last_Collection_Failed__c = false,                              // Last Collection Failed
            DD_Start_Date__c = Date.today(),                     // Start Date
            DD_End_Date__c = Date.today()                       // End Date

        );
        String responseBody = '{"ProcessNewDDFirstCollectionDateResult":{"FirstCollectionDate":"11/05/2017","Error":""}}';
        HttpRestCallOutMock fakeResponse = new HttpRestCallOutMock(200, responseBody);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        SMPRenewWizardController.saveDirectDebit(dd, donation);
        Test.stopTest();

        dd = [SELECT Id, DD_Status__c, DD_First_Collection_Amount__c, Contact__c FROM Income_Direct_Debit__c];
        System.debug('#### dd: ' + dd);
        donation = [SELECT Id, npe03__Amount__c, Opportunity__c, Direct_Debit_Detail__c, npe03__Contact__c FROM npe03__Recurring_Donation__c];

        System.assertNotEquals(null, dd.Id);
        System.assertEquals('New Instruction', dd.DD_Status__c);
        System.assertEquals(40.00, dd.DD_First_Collection_Amount__c);
        System.assertEquals(dd.Id, donation.Direct_Debit_Detail__c);
    }
    @isTest
    private static void modulusCheckDirectDebitDateTest() 
    {
        
        String sortCode = '074456';
        String accountNumber = '11104102';

        Income_Direct_Debit__c dd = new Income_Direct_Debit__c();

        dd.DD_Bank_Sort_Code__c = sortCode;
        dd.DD_Bank_Account_Number__c = accountNumber;

        SmarterPay_Direct_Debit_Settings__c config = new SmarterPay_Direct_Debit_Settings__c(Bank_Account_Checker_Endpoint__c = 'www.test.com',
        User_Id__c = '123456');
        insert config;
        
        Income_Direct_Debit__c response = SMPRenewWizardController.modulusCheckDirectDebit(dd);

        System.assertEquals(false, response.DD_Account_Number_OK__c);
        System.assertEquals(false, response.DD_Sort_Code_OK__c);
    }
    @isTest static void testGetAuthPaymentURL() 
    {
        CreateTestFrameWork();
        SmarterPay_Payment_Config__c paymentConfig = new SmarterPay_Payment_Config__c();
        paymentConfig.APIKey__c = '123456';
        paymentConfig.SmarterPay_User_Name__c = 'test';
    
        paymentConfig.Standard_MOTO__c = '/MOTO';
        paymentConfig.Standard_Ecommerce__c = '/Ecommerce';
        paymentConfig.Standard_Repeat__c = '/Repeat';
        paymentConfig.Standard_Refund__c = '/Refund';
        paymentConfig.Standard_Deferred_Capture_MOTO__c = '/DeferredCaptureMOTO';
        paymentConfig.Standard_Deferred_Capture_Ecommerce__c = '/DeferredCaptureEcommerce';
        paymentConfig.Standard_Deferred_Release__c = '/DeferredRelease'; 
        paymentConfig.Standard_Authenticate_Capture_MOTO__c = '/AuthenticateCaptureMOTO'; 
        paymentConfig.Standard_Authenticate_Capture_Ecommerce__c = '/AuthenticateCaptureEcommerce'; 
        paymentConfig.Standard_Authenticate_Release__c = '/AuthenticateRelease';

        insert paymentConfig;
        npe03__Recurring_Donation__c donation = [SELECT Id, Name, npe03__Amount__c, npe03__Contact__c, Opportunity__c, Direct_Debit_Detail__c, npe03__Contact__r.FirstName, npe03__Contact__r.LastName,
                                                    npe03__Contact__r.MailingStreet, npe03__Contact__r.MailingCity, CurrencyIsoCode,
                                                    npe03__Contact__r.MailingState, npe03__Contact__r.MailingPostalCode,
                                                    npe03__Contact__r.MailingCountry, npe03__Contact__r.Email 
                                                    FROM npe03__Recurring_Donation__c];


        System.assert(SMPRenewWizardController.getAuthPaymentURL(donation).contains('AuthenticateCaptureMOTO'));
    }
}