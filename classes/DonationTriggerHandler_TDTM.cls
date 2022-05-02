/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 11-05-2021
 * @last modified by  : Iamsfdeveloper
**/
global class DonationTriggerHandler_TDTM extends npsp.TDTM_Runnable  {
    
    global override npsp.TDTM_Runnable.DmlWrapper run(List<SObject> newlist,
                                                      List<SObject> oldlist,
                                                      npsp.TDTM_Runnable.Action triggerAction,
                                                      Schema.DescribeSObjectResult objResult) {
                                                          
                                                          npsp.TDTM_Runnable.dmlWrapper dmlWrapper = new npsp.TDTM_Runnable.DmlWrapper();
                                                          List<Opportunity> newOppList = (List<Opportunity>) newlist;
                                                          List<Opportunity> oldOppList = (List<Opportunity>) oldlist; 
                                                          Map<Id,Opportunity> basketStatusOppMap = new Map<Id,Opportunity>();
                                                          Map<Id,Opportunity> nonTicketItemsOppMap = new Map<Id,Opportunity>();
                                                          set<Id> wonOppIds = new set<Id>();
                                                          set<Id> contactIds = new set<Id>();
                                                          Map<Id,Contact> contactMapValue = new Map<Id,Contact>();
                                                          Map<Id,String> contactToItemCode = new Map<Id,String>();                                        
                                                          if (triggerAction == npsp.TDTM_Runnable.Action.AfterUpdate) {
                                                              for(Integer i=0;i<newOppList.size();i++){
                                                                  if(newOppList[i].isWon && !oldOppList[i].isWon &&  newOppList[i].npsp__Primary_Contact__c != null && (newOppList[i].Donation_Type__c =='SD' || newOppList[i].Type=='Payment Plan - Source')){
                                                                      wonOppIds.add(newOppList[i].Id);
                                                                      contactIds.add(newOppList[i].npsp__Primary_Contact__c);
                                                                      
                                                                  }
                                                              }
                                                              System.debug('wonOppIds===>'+wonOppIds);
                                                              if(contactIds.size()>0)
                                                                  contactMapValue.putAll([SELECT Id, Products_purchased__c  From Contact Where Id IN: contactIds]);
                                                              
                                                              if(contactIds.size()>0 && wonOppIds.size()>0)
                                                                  for (npsp__Allocation__c allo : [Select Id,npsp__Opportunity__c,npsp__Opportunity__r.npsp__Primary_Contact__c,npsp__General_Accounting_Unit__r.Product_Type__c, Donation_Item_Code__c  From Npsp__Allocation__c Where npsp__Opportunity__c IN:wonOppIds ]) {
                                                                      if (contactMapValue.keyset().contains(allo.npsp__Opportunity__r.npsp__Primary_Contact__c)){
                                                                          contact temp = contactMapValue.get(allo.npsp__Opportunity__r.npsp__Primary_Contact__c);
                                                                          if(temp.Products_purchased__c == null)
                                                                              temp.Products_purchased__c = allo.Donation_Item_Code__c;
                                                                          else if(!temp.Products_purchased__c.containsIgnoreCase(allo.Donation_Item_Code__c))
                                                                              temp.Products_purchased__c +=';'+allo.Donation_Item_Code__c;
                                                                          contactMapValue.put(temp.Id,temp);
                                                                      }
                                                                      /****Basket Status is set 1 , contains Only Ticket  Item */
                                                                      if(allo.npsp__General_Accounting_Unit__r.Product_Type__c == 'Ticket'){
                                                                          basketStatusOppMap.put(allo.npsp__Opportunity__c,new Opportunity(Id=allo.npsp__Opportunity__c,Basket_Status__c  = '1'));
                                                                      }
                                                                      /****Basket Status is set 2 , contains Both Ticket & non Ticket Item */
                                                                      if(allo.npsp__General_Accounting_Unit__r.Product_Type__c != 'Ticket' && basketStatusOppMap.keySet().contains(allo.npsp__Opportunity__c))
                                                                          basketStatusOppMap.put(allo.npsp__Opportunity__c,new Opportunity(Id=allo.npsp__Opportunity__c,Basket_Status__c  = '2'));
                                                                  }
                                                              System.debug('contactsToUpdate===>'+contactMapValue.values());
                                                              if(contactMapValue.size()>0)
                                                                  update contactMapValue.values();
                                                          
                                                          if(basketStatusOppMap.size()>0)
                                                              Update basketStatusOppMap.values();
                                                          } 
                                                          return dmlWrapper;
                                                      }
}