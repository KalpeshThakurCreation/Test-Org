/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 04-14-2021
 * @last modified by  : Iamsfdeveloper
 * Modifications Log 
 * Ver   Date         Author           Modification
 * 1.0   03-16-2021   Iamsfdeveloper   Initial Version
**/
global without sharing class HA_CreateDonations {
    static final String PLEDGE_STAGE='Pledged';
    static final String DONATION_NAME='System Generated';
     public class FlowInputs {         
        @InvocableVariable public String RdId;       
    }
    global static list<Opportunity> getDonationsFromNotes(set<Id> newListKeySet){
        List<npsp__Trigger_Handler__c> handlers = npsp.TDTM_Config_API.getCachedRecords();
        list<Opportunity> DonationsToInsert = new List<Opportunity>();
        
        for(npe03__Recurring_Donation__c rd : [Select Id,Regional_Code__c,Opportunity__c,npe03__Organization__c,npe03__Contact__c,Donation_type__c,npe03__Recurring_Donation_Campaign__c,Opportunity__r.Source__c,Opportunity__r.Medium__c,CurrencyISOCode FROM npe03__Recurring_Donation__c Where Id IN:newListKeySet AND (Opportunity__r.DonationCode__c = '30N' or Opportunity__r.DonationCode__c = '10N' or Opportunity__r.DonationCode__c = '10D')]){
            Map<Integer,Opportunity> IntMapToOpp = new Map<Integer,Opportunity>();
            if(rd.Opportunity__c!=null && Limits.getQueries()<100){
                    for (npsp__Trigger_Handler__c th : handlers) {
                        if (th.npsp__Object__c == 'npe03__Recurring_Donation__c' && th.npsp__Class__c == 'RD2_RecurringDonations_TDTM') {
                            th.npsp__Active__c = false;
                        }
                    }
                    for(NewDonationBasketItemDataType.PaymentScheduleList temp:getPaymentListFromNotes(rd.Opportunity__c)){
                        Opportunity opp =  (IntMapToOpp.get(temp.Index) != null)?IntMapToOpp.get(temp.Index):new Opportunity(Name=DONATION_NAME,website_Code__c=rd.Regional_Code__c,CurrencyISOCode=rd.CurrencyISOCode,StageName= PLEDGE_STAGE,Donation_type__c=rd.Donation_type__c,CloseDate = date.newinstance(temp.Date_Time.year(), temp.Date_Time.month(), temp.Date_Time.day()),Amount=0.00, npe03__Recurring_Donation__c=rd.Id,npsp__Primary_Contact__c=rd.npe03__Contact__c,accountId=rd.npe03__Organization__c,CampaignId=rd.npe03__Recurring_Donation_Campaign__c,Source__c=rd.Opportunity__r.Source__c,Medium__c=rd.Opportunity__r.Medium__c);
                        opp.Amount +=temp.Amount;
                        IntMapToOpp.put(temp.Index,opp);
                         
                    }
                }
                DonationsToInsert.addAll(IntMapToOpp.values());
        }
        return DonationsToInsert;
    }
    @InvocableMethod(label='Create Donation From Notes ' description='insert Donations' category='npe03__Recurring_Donation__c')
     public static void getDonationsFromNotes(List<FlowInputs> requests){
         // get all Opportunity Ids
        List<Id> newListKeySet = new List<Id>();
        for (FlowInputs request : requests) {
            System.debug('request.RdId===>'+request.RdId);
            newListKeySet.add(request.RdId);
        }
        List<npsp__Trigger_Handler__c> handlers = npsp.TDTM_Config_API.getCachedRecords();
        list<Opportunity> DonationsToInsert = new List<Opportunity>();
        
        for(npe03__Recurring_Donation__c rd : [Select Id,Regional_Code__c,Opportunity__c,npe03__Organization__c,npe03__Contact__c,Donation_type__c,npe03__Recurring_Donation_Campaign__c,Opportunity__r.Source__c,Opportunity__r.Medium__c,CurrencyISOCode FROM npe03__Recurring_Donation__c Where Id IN:newListKeySet AND (Opportunity__r.DonationCode__c = '30N' or Opportunity__r.DonationCode__c = '10N' or Opportunity__r.DonationCode__c = '10D')]){
            Map<Integer,Opportunity> IntMapToOpp = new Map<Integer,Opportunity>();
            if(rd.Opportunity__c!=null && Limits.getQueries()<100){
                /*for (npsp__Trigger_Handler__c th : handlers) {
                    if (th.npsp__Object__c == 'npe03__Recurring_Donation__c' && th.npsp__Class__c == 'RD2_RecurringDonations_TDTM') {
                        th.npsp__Active__c = false;
                    }
                }*/
                for(NewDonationBasketItemDataType.PaymentScheduleList temp:getPaymentListFromNotes(rd.Opportunity__c)){
                    Opportunity opp =  (IntMapToOpp.get(temp.Index) != null)?IntMapToOpp.get(temp.Index):new Opportunity(Name=DONATION_NAME,website_Code__c=rd.Regional_Code__c,CurrencyISOCode=rd.CurrencyISOCode,StageName= PLEDGE_STAGE,Donation_type__c=rd.Donation_type__c,CloseDate = date.newinstance(temp.Date_Time.year(), temp.Date_Time.month(), temp.Date_Time.day()),Amount=0.00, npe03__Recurring_Donation__c=rd.Id,npsp__Primary_Contact__c=rd.npe03__Contact__c,accountId=rd.npe03__Organization__c,CampaignId=rd.npe03__Recurring_Donation_Campaign__c,Source__c=rd.Opportunity__r.Source__c,Medium__c=rd.Opportunity__r.Medium__c);
                    opp.Amount +=temp.Amount;
                    IntMapToOpp.put(temp.Index,opp);
                	 
                }
                }
                DonationsToInsert.addAll(IntMapToOpp.values());
        }
        insert DonationsToInsert;
    }
    public static NewDonationBasketItemDataType.PaymentScheduleList[] getPaymentListFromNotes(Id sourceOppId){
        NewDonationBasketItemDataType.PaymentScheduleList[] PaymentScheduleList = new NewDonationBasketItemDataType.PaymentScheduleList[]{};
        try{
            for(ContentVersion cn :[SELECT Id, ContentDocumentId, Title, FileType, VersionData, IsLatest, ContentUrl, TagCsv FROM ContentVersion Where Donation__c =: sourceOppId]){
                PaymentScheduleList.AddAll((NewDonationBasketItemDataType.PaymentScheduleList[])JSON.deserialize(cn.VersionData.toString(), NewDonationBasketItemDataType.PaymentScheduleList[].class));
            }
            
            
        }Catch(Exception ex){
           
        }
        return PaymentScheduleList;
    }
}