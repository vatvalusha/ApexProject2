/**
 * Created by Zhenya on 06.04.2017.
 */

trigger ChildObject on ChildObject__c (before update) {
    List<ChildObject__c> childObjects= Trigger.new;
    Handler.childbeforeUpdate(childObjects);

}