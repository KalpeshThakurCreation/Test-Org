<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Contact_Donation_Receipt</fullName>
        <description>Contact Donation Receipt - ACK</description>
        <protected>false</protected>
        <recipients>
            <field>npsp__Primary_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>customercare@humanappeal.org.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Payment_Emails/Payment_Receipt_Donation</template>
    </alerts>
    <alerts>
        <fullName>ES_Donation_Receipt_Email_Alert</fullName>
        <description>ES Donation Receipt Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>npsp__Primary_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>info@humanappeal.es</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Payment_Emails/ES_Payment_Receipt</template>
    </alerts>
    <alerts>
        <fullName>FR_Thirty_Ten_Nights_Donation_Reciept</fullName>
        <description>FR Donation Receipt Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>npsp__Primary_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>contact@humanappeal.fr</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Payment_Emails/FR_Payment_Receipt</template>
    </alerts>
    <alerts>
        <fullName>IE_Donation_Receipt_Email_Alert</fullName>
        <description>IE Donation Receipt Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>npsp__Primary_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>info@humanappeal.ie</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Payment_Emails/IE_Payment_Receipt</template>
    </alerts>
    <alerts>
        <fullName>UK_AR_Donation_Receipt_Alert</fullName>
        <description>UK/AR Donation Receipt Alert</description>
        <protected>false</protected>
        <recipients>
            <field>npsp__Primary_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Donor_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customercare@humanappeal.org.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Payment_Emails/Payment_Receipt_Donation</template>
    </alerts>
    <alerts>
        <fullName>UK_Ticket_Email_Alert</fullName>
        <description>UK Ticket Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>npsp__Primary_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Donor_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customercare@humanappeal.org.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Payment_Emails/Ticket_Receipt</template>
    </alerts>
    <alerts>
        <fullName>npsp__Opportunity_Email_Acknowledgment</fullName>
        <description>Opportunity Email Acknowledgment</description>
        <protected>false</protected>
        <recipients>
            <field>npsp__Primary_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>customercare@humanappeal.org.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Payment_Emails/Payment_Receipt_Donation</template>
    </alerts>
    <fieldUpdates>
        <fullName>Owner_to_SP_Integration_User</fullName>
        <field>OwnerId</field>
        <lookupValue>integration@smarterpay.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Owner to SP Integration User</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Donation_Code</fullName>
        <field>Website_Code__c</field>
        <formula>Text(npsp__Primary_Contact__r.Regional_Office_Code__c)</formula>
        <name>Set Donation Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npsp__Opportunity_AcknowledgmentStatus_Update</fullName>
        <description>Sets the Acknowledgment Status to &quot;Acknowledged&quot;</description>
        <field>npsp__Acknowledgment_Status__c</field>
        <literalValue>Acknowledged</literalValue>
        <name>Opportunity Acknowledgment Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npsp__Opportunity_Acknowledgment_Date_Update</fullName>
        <description>sets the Acknowledgment Date to Today.</description>
        <field>npsp__Acknowledgment_Date__c</field>
        <formula>Today()</formula>
        <name>Opportunity Acknowledgment Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npsp__Opportunity_Copy_FMV_to_Amount</fullName>
        <description>Copy the Opportunities Fair Market Value field to the Amount field.</description>
        <field>Amount</field>
        <formula>npsp__Fair_Market_Value__c</formula>
        <name>Opportunity Copy FMV to Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Automated Process to SP User Ownership Change</fullName>
        <actions>
            <name>Owner_to_SP_Integration_User</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Owner.Alias = &apos;autoproc&apos;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Contact Donation Email Acknowledgment</fullName>
        <actions>
            <name>Contact_Donation_Receipt</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>npsp__Opportunity_AcknowledgmentStatus_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>npsp__Opportunity_Acknowledgment_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Emails an acknowledgement to the Primary Contact for an Opportunity when the Acknowledgement Status is set to Email Acknowledgement Now.</description>
        <formula>TEXT(npsp__Acknowledgment_Status__c) = $Label.npsp__sendacknowledgmentfirestatus &amp;&amp;  npsp__Primary_Contact__r.Email &lt;&gt; NULL</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ES Donation Receipt Workflow Rule</fullName>
        <actions>
            <name>ES_Donation_Receipt_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>ES Donation Receipts</description>
        <formula>AND(npsp__Primary_Contact__r.Email &lt;&gt; null,ISCHANGED(StageName),ISPICKVAL(StageName, &apos;Paid&apos;),Text(Regional_Office_Code__c)=&apos;ES&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FR Donation Receipt Workflow Rule</fullName>
        <actions>
            <name>FR_Thirty_Ten_Nights_Donation_Reciept</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>FR Donation Receipts</description>
        <formula>AND(npsp__Primary_Contact__r.Email &lt;&gt; null,ISCHANGED(StageName),ISPICKVAL(StageName, &apos;Paid&apos;),Website_Code__c=&apos;FR&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>IE Donation Receipt Workflow Rule</fullName>
        <actions>
            <name>IE_Donation_Receipt_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>IE Donation Receipt Workflow rule</description>
        <formula>AND(npsp__Primary_Contact__r.Email &lt;&gt; null,ISCHANGED(StageName),ISPICKVAL(StageName, &apos;Paid&apos;),Text(Regional_Office_Code__c)=&apos;IE&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>IE_Thirty%2FTen Nights Donation Receipt</fullName>
        <active>false</active>
        <description>IE Donation Receipts</description>
        <formula>AND(Not(ISBLANK(Donor_Email__c)),ISCHANGED(StageName),ISPICKVAL(StageName, &apos;Paid&apos;),Website_Code__c=&apos;IE&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Donation Website Code</fullName>
        <actions>
            <name>Set_Donation_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set Donation Code for Selecting respective payment settings Website_Code__c</description>
        <formula>AND(NOT(ISNULL(npsp__Primary_Contact__c)),OR(Text(Donation_Type__c)==&apos;SD&apos;,Text(Type)==&apos;Payment Plan - Source&apos;),
ISBLANK(Website_Code__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>UK%2FAR Donation Receipt Workflow Rule</fullName>
        <actions>
            <name>UK_AR_Donation_Receipt_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>UK and AR Donation Receipt</description>
        <formula>AND( npsp__Primary_Contact__r.Email &lt;&gt; null,ISCHANGED(StageName),ISPICKVAL(StageName, &apos;Paid&apos;),OR(Text(Regional_Office_Code__c)=&apos;UK&apos;,Text(Regional_Office_Code__c)=&apos;AR&apos;),NOT(Skip_Process_Automation__c), OR(npe03__Recurring_Donation__c = null, AND(npe03__Recurring_Donation__c &lt;&gt; null, NOT(ISPICKVAL(npe03__Recurring_Donation__r.npsp__PaymentMethod__c, &apos;Direct Debit&apos;)))), NOT(ISPICKVAL(Basket_Status__c,&apos;1&apos;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UK%2FAR Ticket Receipt Workflow Rule</fullName>
        <actions>
            <name>UK_Ticket_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>UK and AR Ticket Receipt</description>
        <formula>AND(npsp__Primary_Contact__r.Email &lt;&gt; null,ISCHANGED(StageName),ISPICKVAL(StageName, &apos;Paid&apos;),OR(Text(Regional_Office_Code__c)=&apos;UK&apos;,Text(Regional_Office_Code__c)=&apos;AR&apos;),NOT(Skip_Process_Automation__c), OR(npe03__Recurring_Donation__c = null, AND(npe03__Recurring_Donation__c &lt;&gt; null, NOT(ISPICKVAL(npe03__Recurring_Donation__r.npsp__PaymentMethod__c, &apos;Direct Debit&apos;)))), NOT(ISPICKVAL(Basket_Status__c,&apos;0&apos;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npsp__Opportunity Copy FMV to Amount</fullName>
        <actions>
            <name>npsp__Opportunity_Copy_FMV_to_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND (3 AND 4)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>equals</operation>
            <value>GBP 0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.npsp__Fair_Market_Value__c</field>
            <operation>notEqual</operation>
            <value>GBP 0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.npsp__Fair_Market_Value__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Enable this rule to copy the Fair Market Value to the Amount field, when the Amount is zero or blank.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>npsp__Opportunity Email Acknowledgment</fullName>
        <actions>
            <name>npsp__Opportunity_Email_Acknowledgment</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>npsp__Opportunity_AcknowledgmentStatus_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>npsp__Opportunity_Acknowledgment_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Emails an acknowledgement to the Primary Contact for an Opportunity when the Acknowledgement Status is set to Email Acknowledgement Now.</description>
        <formula>TEXT(npsp__Acknowledgment_Status__c) = $Label.npsp__sendacknowledgmentfirestatus &amp;&amp;  npsp__Primary_Contact__r.Email &lt;&gt; NULL &amp;&amp;  npsp__Primary_Contact__r.npsp__Do_Not_Contact__c &lt;&gt; True &amp;&amp;  npsp__Primary_Contact__r.HasOptedOutOfEmail &lt;&gt; True &amp;&amp;  npsp__Primary_Contact__r.npsp__Deceased__c &lt;&gt; True</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
