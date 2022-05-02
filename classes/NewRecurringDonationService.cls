/**
 * @File Name          : NewRecurringDonationService.cls
 * @Description        :
 * @Author             : agentgill
 * @Group              :
 * @Last Modified By   : Iamsfdeveloper
 * @Last Modified On   : 04-13-2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    07/06/2020   agentgill     Initial Version
 * 
    // TODO: Throw exception when not enough callouts are availabvle
    
    **Execute Anonymous Apex with Currently Selected Text**
    
    // Start
    NewRecurringDonationService myBatch = new NewRecurringDonationService();
    Database.executeBatch(myBatch, 100);
    // End

    **Execute SOQL Query with Currently Selected Text**
    
    SELECT Id, Amount, CurrencyIsoCode,npe03__Recurring_Donation__r.Card_Payment_Detail__c,npe03__Recurring_Donation__r.Card_Payment_Detail__r.Gateway_Customer_Reference__c
                FROM Opportunity
                WHERE npe03__Recurring_Donation__r.npsp__PaymentMethod__c = 'Card Payment' 
                      AND CloseDate = TODAY  
                      AND npe03__Recurring_Donation__r.npsp__Status__c = 'Active'
                      AND StageName = 'Pledged'
                ORDER BY Id
    
 * 
 **/
public without sharing class NewRecurringDonationService implements Database.stateful, Database.Batchable<sObject>, Database.AllowsCallouts, Database.RaisesPlatformEvents {
    public string lastGatewayCustomerReference;
    public string lastGUID;
	Public string query = 'SELECT Id, Amount, CurrencyIsoCode,npe03__Recurring_Donation__r.Regional_Code__c,npe03__Recurring_Donation__r.Card_Payment_Detail__c,npe03__Recurring_Donation__r.Card_Payment_Detail__r.Gateway_Customer_Reference__c'+
                +' FROM Opportunity  WHERE npe03__Recurring_Donation__r.npsp__PaymentMethod__c = \'Card Payment\''+
                      +' AND CloseDate = TODAY AND npe03__Recurring_Donation__r.npsp__Status__c = \'Active\' AND StageName = \'Pledged\' AND (npe03__Recurring_Donation__r.Donation_type__c !=\'10N\' OR npe03__Recurring_Donation__r.Donation_type__c !=\'30N\') ORDER BY Id';
    private Boolean calloutSuccessful = false;

    private final string PROCESSING_STAGE = 'In Payment Processing';
    private final string PROCESSING_FAILED = 'Processing Failed';

    public Database.QueryLocator start(Database.BatchableContext bc) {
       return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Sobject> scope) {
        List<Opportunity> opps = new List<Opportunity>();

        for (sobject s : scope) {
            Opportunity opp = (Opportunity)s;
            // Available Callouts
            if (
                Limits.getCallouts() <= 100 &&
                (lastGatewayCustomerReference != (String) opp.npe03__Recurring_Donation__r.Card_Payment_Detail__r.Gateway_Customer_Reference__c)
            ) {
                lastGUID = opp.Id;//generateGUID();
                NewPaymentService ps = (NewPaymentService) di_Injector.Org.getInstance( NewPaymentService.class);
                calloutSuccessful = ps.requestPayment(s, lastGUID);
            }

            if (calloutSuccessful) {opps.add(new Opportunity(Id = opp.Id, StageName = PROCESSING_STAGE, GUID__c = lastGUID));
            } else if (lastGatewayCustomerReference == (String) opp.npe03__Recurring_Donation__r.Card_Payment_Detail__r.Gateway_Customer_Reference__c ||!calloutSuccessful) {
                // TODO: REMOVE
                if (!calloutSuccessful) {
                    System.debug('@@@ calloutSuccessful FAILED');
                } else {
                    System.debug('@@@ calloutSuccessful ADD' + lastGUID);
                }

                // END
                opps.add(new Opportunity(Id = opp.Id, StageName = (calloutSuccessful ? PROCESSING_STAGE: PROCESSING_FAILED), GUID__c = lastGUID));
            }

            lastGatewayCustomerReference = opp.npe03__Recurring_Donation__r.Card_Payment_Detail__r.Gateway_Customer_Reference__c;
        }

        if (!opps.isEmpty()) {
            update opps; // Errors are sent to Event Bus - LogBatchApexEve
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('>>> NewRecurringDonationService finish nethod');
    }

    /**
     * @description Generate GUID as Integration Correlation Key
     * @author agentgill | 28/06/2020
     * @return String
     **/
    private static String generateGUID() {
        Blob b = Crypto.GenerateAESKey(128);String h = EncodingUtil.ConvertTohex(b);
        return h.SubString(0, 8) +'-' +h.SubString(8, 12) + '-' +h.SubString(12, 16) +'-' +h.SubString(16, 20) +'-' + h.substring(20);
    }
}