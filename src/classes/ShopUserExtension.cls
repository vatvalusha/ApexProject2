public with sharing class ShopUserExtension {
    /**
        save current user in session
     */
    public ShopUser__c user { get; set; }
    /**
        id user for save in cookie
     */
    public String idUser;
    /**
        check if cookie ii true/false
     */
    public Boolean checkCookie { get; set; }
    /**
        check session user
     */
    public Boolean logIn { get; set; }

    /**
        List All users from DB
     */
    List<ShopUser__c> shopUsers { get; set; }

    /**
        instance for create new cookies
     */
    CookieJar cookieJar = new CookieJar();

    public ShopUserExtension(ApexPages.StandardSetController controller) {
        this.user = new ShopUser__c();

        Cookie theCookie;
        theCookie = ApexPages.currentPage().getCookies().get('user');

        if (theCookie != null) {
            checkCookie = true;
        }
        shopUsers = [
                SELECT id, Email__c,Login__c,Password__c,UserName__c
                FROM ShopUser__c
        ];
    }

    /**
        Cookie theCookie - get current cookei for param 'user'
        @return id user if the exist
     */
    public String getidUser() {
        Cookie theCookie = ApexPages.currentPage().getCookies().get('user');
        if (theCookie != null) {
            for (ShopUser__c shop: shopUsers) {
                if (ID.valueOf(theCookie.getValue()) == shop.id) {
                    idUser = shop.Email__c;
                }
            }
        } else {
            idUser = null;
        }
        return idUser;
    }


    /**
        @return BasketPAge
     */
    public PageReference basketPage() {
        return new PageReference(Label.basketPage);
    }
    /**
        @return RegistrPage
     */
    public PageReference registerPage() {
        return new PageReference(Label.pageRegistration);
    }
    /**
        @return indexPage
     */
    public PageReference indexPage() {
        return new PageReference(Label.IndexPage);
    }


    /**
        Cookie cookie - get current cookei for param 'user'
        @return pageIndex
     */
    public PageReference logOut() {
        Cookie cookie = ApexPages.currentPage().getCookies().get('user');
        if (cookie != null) {
            cookieJar.clearCookie(cookie);
        }
        checkCookie = false;
        return new PageReference(Label.IndexPage);
    }

    /**
        Change visible button LogIn on Page
     */
    public void changeLogIn() {
//        if (logIn == false) {
            logIn = true;
//        } else logIn = false;

    }


    /**
        CookieUser cookieUser;
        Boolean check
        String login
        String pass
        Check if exist user on DB
     */
    public PageReference checkUserInDB() {
        CookieUser cookieUser;
        Boolean check = true;
        String login = user.Login__c;
        String pass = user.Password__c;

        for (ShopUser__c shop: shopUsers) {
            if (shop.Login__c == login && shop.Password__c == pass) {
                check = false;
                cookieUser = new CookieUser(shop.id);
                checkCookie = true;
                return new PageReference(Label.IndexPage);
            }
        }
        if (check) {
            throw new EmailException(Label.userError);
        }
        return null;
    }


    /**
    CookieUser cookieUser
    @return pageIndex
     */
    public PageReference register() {
        insert user;
        CookieUser cookieUser = new CookieUser(user.Id);
        checkCookie = true;
        return new PageReference(Label.IndexPage);
    }

    /**
    class for creating cookies for registered user
     */
    class CookieUser {
        public CookieUser(String userId) {
            Cookie idUser = new Cookie('user', userId, null, -1, false);
            ApexPages.currentPage().setCookies(new Cookie[]{
                    idUser
            });
        }
    }
}