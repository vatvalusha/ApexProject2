/**
 * Created by Zhenya on 21.04.2017.
 */

trigger TriggerForAccount on Account (before insert, before update, before delete) {
    if (Trigger.isDelete) {
        AccountHandler.beforeDelete(Trigger.new, Trigger.old);
    } else if (Trigger.isInsert) {
        AccountHandler.beforeInsert(Trigger.new);
    }else if(Trigger.isUpdate){
        AccountHandler.beforeDelete(Trigger.new,Trigger.old);
    }
}