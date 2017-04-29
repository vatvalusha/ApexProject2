/**
 * Created by Zhenya on 06.04.2017.
 */

trigger GrandChildObject on GrandChildObject__c (before insert) {
    List<GrandChildObject__c> grandChildObjects=Trigger.new;
    Handler.beforeInsert(grandChildObjects);

}