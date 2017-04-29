public with sharing class BackUp {

    private String basketList = Label.listBaskets;


    public Basket__c basket { get; set; }
    public Set<ID> itemsListIds = new Set<ID>();
    public List<Item__c> items { get; set; }

    public List<JunctionBasket__c> junctionBasketsForView{get;set;}


    public List<JunctionBasket__c> junctionBaskets { get; set; }
    public BackUp(ApexPages.StandardController controller) {

        basket = [
                SELECT id
                FROM Basket__c
                WHERE id = :ApexPages.currentPage().getParameters().get('id')
        ];

        junctionBaskets = [
                SELECT BasketReference__c,ItemReference__c, ItemCount__c
                FROM JunctionBasket__c
                WHERE BasketReference__c = :basket.id
        ];
        getListItems();
        items = [
                SELECT Count__c, id, Name__c
                FROM Item__c
                WHERE id IN:itemsListIds
        ];
        junctionBasketsForView=[
                SELECT id,
                        ItemReference__r.Name__c,
                        ItemReference__r.Price__c,
                        ItemCount__c
                FROM JunctionBasket__c
                WHERE BasketReference__c =:ApexPages.currentPage().getParameters().get('id')
        ];

    }


    private void getListItems() {
        for (JunctionBasket__c junctionBasket : junctionBaskets) {
            itemsListIds.add(junctionBasket.ItemReference__c);
        }
    }

    private void returenCountInItems() {
        for (Item__c item : items) {
            for (JunctionBasket__c junctionBasket : junctionBaskets) {
                if (junctionBasket.ItemReference__c == item.id) {
                    item.Count__c = item.Count__c + junctionBasket.ItemCount__c;
                }
            }
        }
        upsert items;
    }


    public PageReference backUp() {
        returenCountInItems();
        delete basket;
        return new PageReference(basketList);

    }

}