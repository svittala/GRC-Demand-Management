<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_For_Resource_and_Resource_Manager_for_Position_Allotment</fullName>
        <description>Notification For Resource and Resource Manager for Position Allotment</description>
        <protected>false</protected>
        <recipients>
            <field>Profile_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notification_For_Resource_and_Resource</template>
    </alerts>
    <fieldUpdates>
        <fullName>Set_email_of_Profile_on_Resource_Pool</fullName>
        <description>Set email of Profile on Resource Pool</description>
        <field>Profile_Email__c</field>
        <formula>Profile_ID__r.Email__c</formula>
        <name>Set email of Profile on Resource Pool</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Position Allocation For A Resource</fullName>
        <actions>
            <name>Notification_For_Resource_and_Resource_Manager_for_Position_Allotment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Resource_Pool__c.Current_Position__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>Position Allocation For A Resource</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Profile Email on Resource Pool</fullName>
        <actions>
            <name>Set_email_of_Profile_on_Resource_Pool</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Profile Email on Resource Pool</description>
        <formula>Profile_ID__r.Email__c  != null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
