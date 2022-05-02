/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_npsp_AllocationTest
{
    @IsTest
    private static void testTrigger()
    {
contact contact = new Contact();
contact.Firstname = 'Name1';
contact.Lastname = 'Name2';
        contact.MailingCity = 'sss';
        contact.MailingCountry = 'sss';
        contact.MailingStreet = 'sss';
        contact.MailingPostalCode = 'sss';

insert contact;


npsp__General_Accounting_Unit__c testProduct = new npsp__General_Accounting_Unit__c(
Name = 'Aqiqa',
Donation_Item_Code__c = 'WIFU',
Include_In_General_Receipt__c = true
);
insert testProduct;

Opportunity opp = new Opportunity();
opp.Name = 'testOpp';
opp.Amount = 5;
opp.StageName = 'Awaiting Payment Details';
opp.CloseDate = Date.Today();
opp.npsp__Primary_Contact__c = contact.Id;
insert opp;

npsp__Allocation__c guaAllication = new npsp__Allocation__c();
guaAllication.npsp__Opportunity__c = opp.Id;
guaAllication.npsp__Amount__c = 5;
guaAllication.CurrencyIsoCode = 'GBP';
guaAllication.npsp__General_Accounting_Unit__c = testProduct.Id;
insert guaAllication;
    }
}