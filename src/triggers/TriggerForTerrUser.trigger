/**
 * Created by Zhenya on 21.04.2017.
 */

trigger TriggerForTerrUser on TerrUser__c (before insert, before update, before delete) {

    List<TerrUser__c> newTerrUsers = Trigger.new;
    List<TerrUser__c> oldTerrUsers = Trigger.old;

    if(Trigger.isDelete) {
        TerrUserTriggerHandler.beforeDelete(oldTerrUsers);
    }
    else if(Trigger.isInsert){
        TerrUserTriggerHandler.beforeInsert(newTerrUsers);
    }
    else if(Trigger.isUpdate){
        TerrUserTriggerHandler.beforeUpdate(oldTerrUsers,newTerrUsers);
    }


}