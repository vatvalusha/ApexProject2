public with sharing class ControllerItem {
    public List<Item__c> items { get; set; }
    private String globalItem { get; set; }
    public List<Category__c> categories { get; set; }
    public JunctionBasket__c junctionBasket { get; set; }
    public Integer count { get; set; }
    public Integer countCategory { get; set; }
    public List<WrapperItem> wrapperItems = new List<WrapperItem>();

    public ID idItem = ApexPages.currentPage().getParameters().get('item');
    public ApexPages.StandardSetController controller;


    public ControllerItem(ApexPages.StandardSetController controller) {
        this.controller = controller;
        items = [
                SELECT Name,Id,Photo__c
                FROM Item__c
                WHERE Category__c = :ApexPages.currentPage().getParameters().get('id')
        ];

        categories = [
                SELECT id, Name, (SELECT id FROM Items__r)
                FROM Category__c
        ];
        fullWrpper();
    }


    /**
    get List Items by id curren Categiry choose on page
     */
    public List<Item__c> getItems() {
        List<Item__c> items = [
                SELECT Name,Id,Photo__c,Description__c,Price__c
                FROM Item__c
                WHERE Category__c = :ApexPages.currentPage().getParameters().get('id')
        ];
        return items;
    }


    public void add() {
        Integer cInteger = wrapperFull();
        Cookie counter = ApexPages.currentPage().getCookies().get('item');
        if (counter == null) {
            globalItem = ApexPages.currentPage().getParameters().get('item');

            CookieJar cookieJar = new CookieJar(countingItems(globalItem,cInteger));
        } else {
            String currentItem = ApexPages.currentPage().getParameters().get('item');
            globalItem = counter.getValue() + countingItems(currentItem,cInteger);
            CookieJar cookieJar = new CookieJar(globalItem);
        }
    }

    public String countingItems(String currentItem, Integer count){
        String itemCount = currentItem;
        for (Integer i = 0; i < count - 1; i++) {
            itemCount = itemCount + ApexPages.currentPage().getParameters().get('item');
        }
        return itemCount;
    }

    /**

    return count repeat ids item
     */
    private Integer wrapperFull(){
        Integer intValuer = 0;
        for (WrapperItem wrapperItem : wrapperItems) {
            if (wrapperItem.id.id == ApexPages.currentPage().getParameters().get('item')) {
                intValuer = wrapperItem.counter;
            }
        }
        return intValuer;
    }


    /**
    Get item by curren page id item
     */
    public Item__c getItem() {
        Item__c item = [
                SELECT id,Name, Price__c, Photo__c, Description__c,Count__c
                FROM Item__c
                WHERE id = :ApexPages.currentPage().getParameters().get('ite')
        ];

        return item;
    }

    /**
    Fulling Wrapper Items
     */
    public void fullWrpper() {
        for (Item__c item : items) {
            wrapperItems.add(new WrapperItem(item, count));
        }
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////GET and SET//////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////

    public List<WrapperItem> getWrapperItems() {
        return wrapperItems;
    }


    public Id getItemId() {
        return idItem;
    }
}