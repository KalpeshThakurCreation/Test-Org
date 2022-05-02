/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 06-15-2021
 * @last modified by  : Iamsfdeveloper
 * Modifications Log 
 * Ver   Date         Author           Modification
 * 1.0   06-15-2021   Iamsfdeveloper   Initial Version
**/
global class RecurringDonations_TDTM_Runnable extends npsp.TDTM_Runnable {

    global override npsp.TDTM_Runnable.DmlWrapper run(List<SObject> newlist,
                                             List<SObject> oldlist,
                                             npsp.TDTM_Runnable.Action triggerAction,
                                             Schema.DescribeSObjectResult objResult) {
                                                 
        npsp.TDTM_Runnable.dmlWrapper dmlWrapper = new npsp.TDTM_Runnable.DmlWrapper();
       list<Opportunity> DonationsToInsert = new List<Opportunity>();
        list<npe03__Recurring_Donation__c> RdsList = new List<npe03__Recurring_Donation__c>();
        List<npe03__Recurring_Donation__c> listNew=(List<npe03__Recurring_Donation__c>)newList;
		List<npsp__Trigger_Handler__c> handlers = npsp.TDTM_Config_API.getCachedRecords();
        /*if (triggerAction == npsp.TDTM_Runnable.Action.AfterUpdate && !HA_Utility.isExecuted) {
                Map<Id,npe03__Recurring_Donation__c> TirggerNewMap = new Map<Id,npe03__Recurring_Donation__c>(listNew);
                //DonationsToInsert = HA_CreateDonations.getDonationsFromNotes(TirggerNewMap.keySet());
                //System.debug('DonationsToInsert===>'+DonationsToInsert.size());
                //dmlWrapper.objectsToInsert.addAll((List<Opportunity>)DonationsToInsert);
            	HA_Utility.isExecuted = true;
        }else {*///if (triggerAction == npsp.TDTM_Runnable.Action.BeforeUpdate || triggerAction == npsp.TDTM_Runnable.Action.BeforeInsert)
           // System.debug(dmlWrapper.objectsToUpdate);
            for(npe03__Recurring_Donation__c rd : listNew){
                if(rd.Donation_Type__c =='30N' || rd.Donation_Type__c =='10N' || rd.Donation_Type__c =='10D')
                 for (npsp__Trigger_Handler__c th : handlers) {
                    if (th.npsp__Object__c == 'npe03__Recurring_Donation__c' && th.npsp__Class__c == 'RD2_RecurringDonations_TDTM') {
                        th.npsp__Active__c = false;
                    }
                }
            }
            
        //}

      return dmlWrapper;
    }
}