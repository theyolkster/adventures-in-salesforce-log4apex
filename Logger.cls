/*
 * This class wraps the system.debug and utilises the custom setting
 * Logger Setting to print or not to print to the apex logs
 * # Author : Ashis Kumar Maharaa
 * # Date   : 8/16/2020
*/
public with sharing class Logger {
    private String decorator;
    private String className;    
    private Map<String, Boolean> loggerConfig;
    private String INIT_MESSAGE {
        get{
            return this.decorator + ' Logger Initialized for {0} ' + this.decorator;
        }
        set;
    }
    private String DECORATED_MSG {
        get {
            return this.decorator + ' {0} ' + this.decorator;
        }
        set;
    }
    
    public Logger(String className) {
        this.className = className;
        this.decorator = '#####';
        System.debug(String.format(this.INIT_MESSAGE, new String[] { className }));
        // get all logger settings and store them in logger config
        for(LoggerSetting__c eachSetting : LoggerSetting__c.getAll().values()) {
            if (this.loggerConfig == NULL) {
                this.loggerConfig = new Map<String, Boolean>();
            }
            this.loggerConfig.put(eachSetting.LoggingLevel__c.toUpperCase(), eachSetting.IsEnabled__c);
        }
    }

    public void setDecorator(String decorator) {
        this.decorator = decorator;
    }

    // print to console only if logging level is enabled in logger setting
    private void log(System.LoggingLevel level, String message) {
        if (this.loggerConfig.get(level.name()) == false) { return; }
        System.debug(level, String.format(this.DECORATED_MSG, new String[] { message }));
    }

    // logging to console for each type of logging level
    public void debug(String message) {
        this.log(System.LoggingLevel.DEBUG, message);
    }
    public void error(String message) {
        this.log(System.LoggingLevel.ERROR, message);
    }
    public void info(String message) {
        this.log(System.LoggingLevel.INFO, message);
    }
    public void none(String message) {
        this.log(System.LoggingLevel.NONE, message);
    }
    public void warn(String message) {
        this.log(System.LoggingLevel.WARN, message);
    }
}
