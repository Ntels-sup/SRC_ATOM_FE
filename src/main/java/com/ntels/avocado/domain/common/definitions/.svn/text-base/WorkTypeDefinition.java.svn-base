package com.ntels.avocado.domain.common.definitions;

public interface WorkTypeDefinition {

    static final int WORK_TYPE_MOVE_PAGE   = 35;
	
    static final int WORK_TYPE_SEARCH  = 0;
    static final int WORK_TYPE_INSERT  = 1;
    static final int WORK_TYPE_DELETE  = 2;
    static final int WORK_TYPE_UPDATE  = 3;
    static final int WORK_TYPE_SAVE    = 4;
    static final int WORK_TYPE_SAVE_AS = 5;

    // Online Process
    static final int WORK_TYPE_CMDID_APP_RUN		= 6;  // to PMS
    static final int WORK_TYPE_CMDID_INIT	        = 7;  // to MES
    static final int WORK_TYPE_CMDID_APP_STOP	  	= 8;  // to MES
    static final int WORK_TYPE_CMDID_APP_KILL           = 9;  // to PMS

    static final int WORK_TYPE_CMDID_PFM_PROCESS_RUN_MORE = 10;  // to PMS

    static final int WORK_TYPE_FILE_LOGLEVEL_DEBUG        = 11;  // to LMS
    static final int WORK_TYPE_FILE_LOGLEVEL_INFO         = 12;  // to LMS
    static final int WORK_TYPE_FILE_LOGLEVEL_NOTIFY	  = 13;  // to LMS
    static final int WORK_TYPE_FILE_LOGLEVEL_WARNING      = 14;  // to LMS
    static final int WORK_TYPE_FILE_LOGLEVEL_ERROR        = 15;  // to LMS

    // Mgmt Component
    static final int WORK_TYPE_CMDID_PFM_RESOURCE_STATUS_QUERY  = 16;   // to RMS
    //static final int WORK_TYPE_CMDID_PFM_QUEUE_STATUS	        = 17;   // to MES
    static final int WORK_TYPE_CMDID_APP_QUEUE_STATUS	        = 17;   // to MES
    static final int WORK_TYPE_CMDID_PFM_FLOW_RULE_RELOAD       = 18;   // to MES
    static final int WORK_TYPE_CMDID_PFM_CONNECTION_STATUS	= 19;   // to UAS
    static final int WORK_TYPE_CMDID_PFM_PROCESS_STATUS	        = 20;   // to PMS
    static final int WORK_TYPE_CMDID_PFM_BATCH_GROUP_STATUS	= 21;   // to BJS

    static final int WORK_TYPE_LOGLEVEL_DEBUG		= 22;   // to LMS
    static final int WORK_TYPE_LOGLEVEL_INFO            = 23;   // to LMS
    static final int WORK_TYPE_LOGLEVEL_NOTIFY          = 24;   // to LMS
    static final int WORK_TYPE_LOGLEVEL_WARNING         = 25;   // to LMS
    static final int WORK_TYPE_LOGLEVEL_ERROR           = 26;   // to LMS

    // Batch Process
    static final int WORK_TYPE_CMDID_PFM_BATCH_JOB_START	= 27;   // to BJA
    static final int WORK_TYPE_CMDID_PFM_BATCH_JOB_STOP	    = 28;   // to BJA

    static final int WORK_TYPE_CMDID_PFM_BATCH_GROUP_START	= 29;  // to BJS
    static final int WORK_TYPE_CMDID_PFM_BATCH_GROUP_STOP	= 30;  // to BJS
    static final int WORK_TYPE_CMDID_PFM_BATCH_GROUP_SCHEDULER_SKIP_ON	= 31;  //to BJS
    static final int WORK_TYPE_CMDID_PFM_BATCH_GROUP_SCHEDULER_SKIP_OFF	= 32;  //to BJS

    static final int WORK_TYPE_IMPORT = 33;
    static final int WORK_TYPE_COPY   = 34;

    
    static final String[] WORK_TYPE_NAME = new String[]{
    	"Display",
        "Insert",
        "Delete",
        "Update",
        "Save",
        "Save As",

        "Run",
        "Init",
        "Stop",
        "Kill",

        "Process Run More",

        "Change File Log Level-Debug",
        "Change File Log Level-Info",
        "Change File Log Level-Notify",
        "Change File Log Level-Warning",
        "Change File Log Level-Error",

        "Resource Status Request",
        "Queue Status Request",
        "Init", // MES
        "Mgmt. PS Status Request",
        "Process Status Request",
        "Batch Status Request",

        "Change Log Level-Debug",
        "Change Log Level-Info",
        "Change Log Level-Notify",
        "Change Log Level-Warning",
        "Change Log Level-Error",

        "Run",
        "Stop",

        "Run",
        "Stop",
        "Suspend On",
        "Suspend Off",

        "Import",
        "Copy",

        "Menu Select",
    };
    
    // 온라인 설계 이력, 배치 설계 이력이 위의 WORK_TYPE_NAME을 사용하는 부분에서 작업 유형 이상으로 
    // 아래의 FLOW_WORK_TYPE_NAME을 추가함.
    // 복귀후 확인이 필요
    static final String[] FLOW_WORK_TYPE_NAME = new String[]{
        "Display",
        "Insert",
        "Delete",
        "Update",
        "Insert",
        "Delete",

        "Insert",
        "Delete",
        "Copy",
        "Update",

        "Process Run More",

        "Change File Log Level-Debug",
        "Change File Log Level-Info",
        "Change File Log Level-Notify",
        "Change File Log Level-Warning",
        "Change File Log Level-Error",

        "Resource Status Request",
        "Queue Status Request",
        "Init", // MES
        "Mgmt. PS Status Request",
        "Process Status Request",
        "Batch Status Request",

        "Change Log Level-Debug",
        "Change Log Level-Info",
        "Change Log Level-Notify",
        "Change Log Level-Warning",
        "Change Log Level-Error",

        "Run",
        "Stop",

        "Run",
        "Stop",
        "Suspend On",
        "Suspend Off",

        "Import",
        "Copy",
    };
}
