public with sharing class CategoryController{
    public List<Item__c> items {get;set;}

    public CategoryController(ApexPages.StandardSetController controller){
        items = [
                SELECT Id, Name, Price__c, Category__c, Count__c
                FROM Item__c
                WHERE Category__c =: ApexPages.currentPage().getParameters().get('id')
        ];

    }

    public void showItems(){

        items = [SELECT Id, Name, Price__c, Category__c, Count__c
                FROM Item__c
                WHERE Category__c =: ApexPages.currentPage().getParameters().get('id')
        ];
    }

    public List<Item__c> getItems(){
        return items;
    }


}