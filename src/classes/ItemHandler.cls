public with sharing class ItemHandler {

    public static void checkUddateOrInsert(List<Item__c> items) {
        /**
        Get All List Items from Database
         */
        List<Item__c> allListTerrs = [
                SELECT id, name, Count__c
                FROM Item__c
        ];

        /**
        Checking count on every items and Increases the if less than 3
         */
        for(Integer i = 0 ; i< items.size();i++){
            if(items.get(i).Count__c < 3)
                items.get(i).Count__c = 7;
        }
    }

}