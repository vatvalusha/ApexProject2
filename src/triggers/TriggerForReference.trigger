/**
 * Created by Zhenya on 19.04.2017.
 */

trigger TriggerForReference on Reference__c (after insert, after update, after delete) {


    if(Trigger.isDelete){
        ReferenceHandler.beforeDelete(Trigger.old);
    }
    else if(Trigger.isInsert){
        ReferenceHandler.beforeInsert(Trigger.new);

    }
    else if(Trigger.isUpdate){
        ReferenceHandler.beforeUpdate(Trigger.old,Trigger.new);

    }

}