/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_npe03_Recurring_DonationTest
{
    @IsTest
    private static void testTrigger()
    {
Contact con = new Contact(Lastname = 'Test');
insert con;

SavePoint sp = Database.setSavepoint();
dlrs.RollupService.testHandler(new npe03__Recurring_Donation__c(npe03__Contact__c = con.id));
Database.rollback(sp);
    }
}