/**
 * Created by Zhenya on 01.04.2017.
 */

trigger DefiningCategory on Auto__c (before insert) {

    Auto__c[] autos =Trigger.new;
    Auto.defineCategory(autos);

}