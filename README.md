# adventures-in-salesforce-log4apex

log4apex is inspired by log4j from apache in java

```apex
Logger log = new Logger(AccountAfterUpdateHandler.class.getName());
log.setDecorator('*****');

log.none('Custom Initialization Message');
log.debug('Running After Update Handler');
log.info('Total Accounts in context');
log.warn('Close to Governor Limits');
log.ERROR('Error Occured');
```
