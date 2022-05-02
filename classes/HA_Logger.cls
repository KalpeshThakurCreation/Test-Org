/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 02-08-2021
 * @last modified by  : Iamsfdeveloper
 * Modifications Log 
 * Ver   Date         Author           Modification
 * 1.0   02-08-2021   Iamsfdeveloper   Initial Version
**/
public with sharing class HA_Logger {
    public static void CreateErrorLog(String ErrorDetails,String ObjectName,String ErrorContext){
        insert new Recurring_Donation_Batch_Errors__c(EventDetails__c =ErrorDetails,Object__c=ObjectName,Error_Context__c=ErrorContext);
    }
}