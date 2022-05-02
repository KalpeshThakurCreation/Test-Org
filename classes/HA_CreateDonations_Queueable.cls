/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 04-09-2021
 * @last modified by  : Iamsfdeveloper
 * Modifications Log 
 * Ver   Date         Author           Modification
 * 1.0   03-31-2021   Iamsfdeveloper   Initial Version
**/
public without sharing class HA_CreateDonations_Queueable  implements Queueable {
       public List<npsp__Allocation__c> allocationList;
        public Opportunity SourceDonation;
        public List<Opportunity> recurringDonationsList; 
        public HA_CreateDonations_Queueable(Id DonationId,List<npsp__Allocation__c> allocationList,List<Opportunity> recurringDonationsList){
            this.SourceDonation = [Select Id,CurrencyISOCode,Donation_Type__c,CampaignId,Medium__c,Source__c,AccountId,Amount,npsp__Primary_Contact__c,Website_Code__c,Recurring_Type__c,Number_of_Installments__c,Effective_Date__c FROM opportunity Where Id=:DonationId];
            this.allocationList = allocationList;
            this.recurringDonationsList = recurringDonationsList;
        }
            public void execute(QueueableContext context) {
                npe03__Recurring_Donation__c rd = new npe03__Recurring_Donation__c(CurrencyISOCode =SourceDonation.CurrencyISOCode, Opportunity__c = SourceDonation.Id,npe03__Contact__c=SourceDonation.npsp__Primary_Contact__c,
                                                    npe03__Organization__c = (SourceDonation.npsp__Primary_Contact__c==null)?SourceDonation.AccountId:null,
                                                    npe03__Amount__c = SourceDonation.Amount,
                                                    Donation_Type__c = SourceDonation.Donation_Type__c,
                                                    npe03__Recurring_Donation_Campaign__c = SourceDonation.CampaignId,
                                                    npsp__RecurringType__c = SourceDonation.Recurring_Type__c,
                                                    npe03__Installments__c = SourceDonation.Number_of_Installments__c,
                                                    npsp__StartDate__c = SourceDonation.Effective_Date__c,
                                                    npe03__Installment_Period__c = 'Daily',Medium__c=SourceDonation.Medium__c,Source__c=SourceDonation.Source__c
                                                    );
                
                insert rd;
                List<npsp__Allocation__c> allocToInsert = new List<npsp__Allocation__c>();
                for(npsp__Allocation__c alloc : allocationList){
                    decimal currentAllocPercentage = ((alloc.npsp__Amount__c/SourceDonation.Amount)*100).setScale(2);
                    allocToInsert.add(new npsp__Allocation__c(npsp__Recurring_Donation__c = rd.Id,npsp__General_Accounting_Unit__c = alloc.npsp__General_Accounting_Unit__c, npsp__Percent__c =currentAllocPercentage, Stipulation_Type__c=alloc.Stipulation_Type__c));
                }
                if(allocToInsert.size()>0)
                    insert allocToInsert;
                List<Opportunity> toInsert = new List<Opportunity>();
                for(Opportunity opp : this.recurringDonationsList){
                    if(opp.Amount>0.00){
                        opp.Id= null;
                        opp.CurrencyISOCode =SourceDonation.CurrencyISOCode;
                        opp.npe03__Recurring_Donation__c = rd.Id;
                        opp.Donation_Type__c = this.SourceDonation.Donation_Type__c;
                        opp.CampaignId = this.SourceDonation.CampaignId;
                        opp.AccountId = this.SourceDonation.AccountId;
                        opp.Website_Code__c = SourceDonation.Website_Code__c;
                        opp.npsp__Primary_Contact__c =this.SourceDonation.npsp__Primary_Contact__c;
                        toInsert.add(opp);
                }
                }     
                insert toInsert;               
            }
        
}