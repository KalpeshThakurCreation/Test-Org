@isTest
public with sharing class TriggerHandler_CardPaymentHistoryTest
{
    private static void setupTestConfig(){
        TriggerSettings__c triggersettings = new TriggerSettings__c();
        triggersettings.Card_Payment_History_Trigger__c = true;
        triggersettings.Card_Payment_Trigger__c = true;
        triggersettings.Payment_Schedule_Trigger__c = false;
        insert triggersettings;
    }

    @isTest static void testPaymentScheduleSetToFailed() {
        setupTestConfig();

        Contact member = new Contact();
        member.FirstName = 'testFirst';
        member.LastName = 'testLast';
        member.Email = 'example@example.com';
        member.MailingStreet = 'Street'; 
        member.MailingCity = 'City';
        member.MailingState = 'State';
        member.MailingCountry = 'Country';
        member.MailingPostalCode = 'Country';
        insert member;

        Opportunity opp = new Opportunity();
        opp.Name = 'testOpp';
        opp.Amount = 5;
        opp.StageName = 'test';
        opp.CloseDate = Date.Today();
        insert opp;

        Test.startTest();

        npe03__Recurring_Donation__c rd = (npe03__Recurring_Donation__c) TestFactory.createSObject(
                new npe03__Recurring_Donation__c(
                    npe03__Contact__c = member.Id,
                    npe03__Amount__c = 100,
                    npsp__StartDate__c = Date.today(),
                    npsp__PaymentMethod__c = 'Card Payment',
                    npe03__Date_Established__c = Date.today(),
                    npsp__Day_of_Month__c = String.valueOf(Date.today().day())
                ),
                'TestFactoryDefaults.RDDefaults'
            );
        insert rd;

        Income_Card_Payment__c cardPayment = new Income_Card_Payment__c(Opportunity__c = opp.Id, Recurring_Donation__c = rd.Id, Contact__c = member.Id, Payment_Status__c = 'Created', Transaction_Type__c = 'Sale', Internal_Payment_Description__c=opp.Id);
        insert cardPayment;

        cardPayment.Payment_Status__c = 'Failed';
        update cardPayment;

        Income_Card_Payment_History__c cardPaymentHistory = new Income_Card_Payment_History__c(Income_Card_Payment__c = cardPayment.Id, Payment_Status__c = 'Failed', Transaction_Type__c = 'Sale', Transaction_Date__c = Date.Today() + 5);
        insert cardPaymentHistory;  

        Test.stopTest();
    }

    @isTest static void testPaymentScheduleSetToSuccess() {
        setupTestConfig();

        Contact member = new Contact();
        member.FirstName = 'testFirst';
        member.LastName = 'testLast';  
        member.Email = 'example@example.com';      
        member.MailingStreet = 'Street'; 
        member.MailingCity = 'City';
        member.MailingState = 'State';
        member.MailingCountry = 'Country';
        member.MailingPostalCode = 'Country';
        insert member;

        npsp__General_Accounting_Unit__c item = new npsp__General_Accounting_Unit__c(npsp__Active__c=true,Donation_item_code__c='WFIU');
        insert item;

        Opportunity opp = new Opportunity();
        opp.Name = 'testOpp';
        opp.Amount = 5;
        opp.StageName = 'test';
        opp.CloseDate = Date.Today();
        opp.npsp__Primary_Contact__c = member.Id;
        insert opp;

		npsp__Allocation__c itemAllocation = new npsp__Allocation__c(npsp__General_Accounting_Unit__c =item.Id ,npsp__Amount__c=5,npsp__Opportunity__c=opp.Id);
        insert itemAllocation;

        Test.startTest();
        
        npe03__Recurring_Donation__c rd = (npe03__Recurring_Donation__c) TestFactory.createSObject(
                new npe03__Recurring_Donation__c(
                    npe03__Contact__c = member.Id,
                    npe03__Amount__c = 100,
                    npsp__StartDate__c = Date.today(),
                    npsp__PaymentMethod__c = 'Card Payment',
                    npe03__Date_Established__c = Date.today(),
                    npsp__Day_of_Month__c = String.valueOf(Date.today().day())
                ),
                'TestFactoryDefaults.RDDefaults'
            );
        insert rd;
        
        Income_Card_Payment__c cardPayment = new Income_Card_Payment__c(Opportunity__c = opp.Id, Recurring_Donation__c = rd.Id, Contact__c = member.Id, Payment_Status__c = 'Created', Transaction_Type__c = 'Sale');
        insert cardPayment;

        cardPayment.Internal_Payment_Description__c=opp.Id;
        cardPayment.Payment_Status__c = 'Successful';
        update cardPayment;

        Income_Card_Payment_History__c cardPaymentHistory = new Income_Card_Payment_History__c(Income_Card_Payment__c = cardPayment.Id, Payment_Status__c = 'Successful', Transaction_Type__c = 'Sale', Transaction_Date__c = Date.Today() + 5);
        insert cardPaymentHistory;  

        Test.stopTest();
    }

    @isTest static void testNormalPaymentToSuccess() {
        setupTestConfig();

        List<Contact> contacts = (List<Contact>) TestFactory.createSObjectList(
            new Contact(Email = 'test@test.com'),
            1,
            true
        );

        npsp__General_Accounting_Unit__c item = new npsp__General_Accounting_Unit__c(npsp__Active__c=true,Donation_item_code__c='WFIU');
        insert item;

        Contact member = [SELECT Id, AccountId FROM Contact];

        HA_Payment_Schedule__c paymentSchedule = new HA_Payment_Schedule__c(
            Name = 'Single Donation',                 
            Code__c = 'SD',                              
            Start_Date__c = Date.parse('30/11/2020'),  
            End_Date__c = Date.parse('30/11/2099'),    
            Frequency__c = 'Single',                    
            Processing_Time__c = 'AM',
            Payment_Methods__c = 'Credit/Debit Card'                  
          );
        insert paymentSchedule;

        Opportunity opp = new Opportunity();
        opp.Name = 'testOpp';
        opp.Amount = 5;
        opp.StageName = 'Awaiting Payment Details';
        opp.CloseDate = Date.Today();
        //opp.AccountId = member.AccountId;
        opp.npsp__Primary_Contact__c = member.Id;
        opp.ContactId = member.Id;
        opp.Payment_Schedule__c = paymentSchedule.Id;
        opp.Recurring_Type__c = 'Open';
        opp.Number_of_Installments__c = 12;
        opp.Donation_Type__c = 'SD';
        insert opp;

        npsp__Allocation__c itemAllocation = new npsp__Allocation__c(npsp__General_Accounting_Unit__c =item.Id ,npsp__Amount__c=5,npsp__Opportunity__c=opp.Id);
        insert itemAllocation;   

        Test.startTest();        
        Income_Card_Payment__c cardPayment = new Income_Card_Payment__c(Opportunity__c = opp.Id, Contact__c = contacts[0].Id, Payment_Status__c = 'Created', Transaction_Type__c = 'Sale');
        insert cardPayment;

        /* try { */
            cardPayment.Internal_Payment_Description__c=opp.Id;
            cardPayment.Payment_Status__c = 'Successful';
            update cardPayment;

            Income_Card_Payment_History__c cardPaymentHistory = new Income_Card_Payment_History__c(Income_Card_Payment__c = cardPayment.Id, Payment_Status__c = 'Successful', Transaction_Type__c = 'Sale', Transaction_Date__c = Date.Today() + 5);
            insert cardPaymentHistory;  
       /*  } catch (Exception) {
            
        }    */     

        Test.stopTest();
    }
}