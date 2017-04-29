/**
 * Created by Zhenya on 06.04.2017.
 */

trigger ParentObject on ParentObject__c (before update) {
    List<ParentObject__c> parentObjects = Trigger.new;
    Handler.sendMessageToGrandParent(parentObjects);

}