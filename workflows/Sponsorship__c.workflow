<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Orphan_Alert</fullName>
        <description>Send Orphan Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Donor__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>customercare@humanappeal.org.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Donor_Care_UK/Orphan_New_Supporter</template>
    </alerts>
    <alerts>
        <fullName>Sponsorship_Orphan_Pack_Email_ACK3</fullName>
        <description>Sponsorship Orphan Pack Email ACK</description>
        <protected>false</protected>
        <recipients>
            <field>Donor__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>customercare@humanappeal.org.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Donor_Care_UK/Orphan_New_Supporter_With_Orphan_Pack</template>
    </alerts>
    <fieldUpdates>
        <fullName>Sponsorship_Acknowledgment_Status_Update</fullName>
        <field>Acknowledgment_Status__c</field>
        <literalValue>Acknowledged</literalValue>
        <name>Sponsorship Acknowledgment Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Send New Orphan Alert</fullName>
        <actions>
            <name>Send_Orphan_Alert</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Sponsorship__c.IsActive__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Sponsorship Orphan Pack</fullName>
        <actions>
            <name>Sponsorship_Orphan_Pack_Email_ACK3</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Sponsorship__c.IsActive__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Alias</field>
            <operation>notEqual</operation>
            <value>sdanka</value>
        </criteriaItems>
        <description>Email Alert For Sponsorship with Orphan pack on Record Creation and Active</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Sponsorship Orphan Pack Email Acknowledgment</fullName>
        <actions>
            <name>Sponsorship_Orphan_Pack_Email_ACK3</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Sponsorship_Acknowledgment_Status_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Workflow to automate sending Orphan Packs to Donors that begin a Sponsorship.</description>
        <formula>Text(Acknowledgment_Status__c) = $Label.npsp__sendacknowledgmentfirestatus &amp;&amp; Donor__r.Email &lt;&gt; NULL</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
