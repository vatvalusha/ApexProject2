public with sharing class WrapperItem {
    public Item__c id { get; set; }
    public Integer counter { get; set; }

    public WrapperItem(Item__c id, Integer counter) {
        this.id = id;
        this.counter = counter;
    }
}