/**
 * Created by Zhenya on 21.04.2017.
 */

trigger TriggerForTerr on Terr__c (before insert, before update) {

    if (Trigger.isInsert || Trigger.isUpdate) {

        TerrHandler.checkForUnique(Trigger.new);

    }
}