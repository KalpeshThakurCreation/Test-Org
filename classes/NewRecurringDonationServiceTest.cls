/**
 * @File Name          : NewRecurringDonationServiceTest.cls
 * @Description        :
 * @Author             : agentgill
 * @Group              :
 * @Last Modified By   : agentgill
 * @Last Modified On   : 07-05-2020
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    12/06/2020   agentgill     Initial Version
 **/
@isTest
public  class NewRecurringDonationServiceTest {
    private static final string STAGE_PROCESSING_FAILED = 'Processing Failed';
    private static final string STAGE_PLEDGE = 'Pledge';

    @TestSetup
    static void makeData() {
        List<Contact> contacts = (List<Contact>) TestFactory.createSObjectList(
            new Contact(Gift_Aid_Status__c='Yes'),
            1,
            true
        );
		Opportunity opp = new Opportunity(npsp__Primary_Contact__c = contacts[0].Id);
        opp.Name = 'testOpp';
        opp.Amount = 100;
        opp.StageName = 'Pledge';
        opp.CloseDate = Date.Today();
        insert opp;        
       List<npe03__Recurring_Donation__c> rds = new List<npe03__Recurring_Donation__c>();

        for (Contact c : [
            SELECT Id, AccountId
            FROM Contact
            WHERE MailingCountry= 'test@humanappeal.org.uk.test'
        ]) {
             npe03__Recurring_Donation__c rd = (npe03__Recurring_Donation__c) TestFactory.createSObject(
                new npe03__Recurring_Donation__c(
                    npe03__Contact__c = c.Id,
                    npe03__Amount__c = 100,
                    npsp__StartDate__c = Date.today(),
                    npe03__Date_Established__c = Date.today(),
                    npsp__PaymentMethod__c = 'Card Payment',
                    npsp__Day_of_Month__c = String.valueOf(Date.today().day())
                ),
                'TestFactoryDefaults.RDDefaults'
            );
            rds.add(rd);
        }
for (Contact c : [
            SELECT Id, AccountId
            FROM Contact
            WHERE MailingCountry= 'test@humanappeal.org.uk.test'
        ]) {

             npe03__Recurring_Donation__c rd = (npe03__Recurring_Donation__c) TestFactory.createSObject(
                new npe03__Recurring_Donation__c(
                    Opportunity__c=opp.ID,
                    npe03__Contact__c = c.Id,
                    npe03__Amount__c = 100,
                    npsp__StartDate__c = Date.today(),
                    npe03__Date_Established__c = Date.today(),
                    npsp__PaymentMethod__c = 'Card Payment',
                    npsp__Day_of_Month__c = String.valueOf(Date.today().day())
                ),
                'TestFactoryDefaults.RDDefaults'
            );
            rds.add(rd);
        }
        insert rds;
    }
@isTest
    private static void giftAidPositive() {
        Test.startTest();
        for (Contact c : [
            SELECT Id, AccountId
            FROM Contact
            WHERE MailingCountry= 'test@humanappeal.org.uk.test'
        ]) {
            Insert new Gift_Aid_Declaration__c(Active__c=true,Gift_Aid_Status__c='Yes',Gift_Aid_Effective_Date__c=System.Today(),Donor__c=c.Id,Gift_Aid_Source__c='Verbal',Gift_Aid_Start_Date__c=System.today());
        }
        Test.stopTest();
    }
    /**
     * @description Positive Test
     * @author agentgill | 12/06/2020
     * @return void
     **/
    @isTest
    private static void testMyBatchPositive() {
        

        Test.startTest();
         
        NewRecurringDonationService myBatch = new NewRecurringDonationService();
        Database.executeBatch(myBatch);
        Test.stopTest();

        System.assertEquals(
            STAGE_PLEDGE,
            [SELECT Id, StageName FROM Opportunity LIMIT 1]
            .StageName,
            'Something went wrong'
        );
    }


}