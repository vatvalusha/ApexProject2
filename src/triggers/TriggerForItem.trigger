/**
 * Created by valeriyartemenko on 26.04.17.
 */

trigger TriggerForItem on Item__c (before insert, before update) {

    if (Trigger.isUpdate) {
        ItemHandler.checkUddateOrInsert(Trigger.new);
    }
}