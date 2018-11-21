USE [msdb]
GO

DECLARE @DatabaseName nvarchar(256) = N'IDOS';
DECLARE @JobName nvarchar(256) = @DatabaseName + N'_RoutePlanCurrentWeek';
DECLARE @OwnerLoginName nvarchar(256) = N'idos2_app';

BEGIN TRANSACTION;
DECLARE @ReturnCode int = 0;

IF (NOT EXISTS(SELECT [name] FROM [msdb].[dbo].[syscategories]
    WHERE ([name] = N'[Uncategorized (Local)]') AND (category_class = 1)))
BEGIN
    EXEC @ReturnCode = [msdb].[dbo].[sp_add_category] @class = N'JOB', @type = N'LOCAL', @name = N'[Uncategorized (Local)]';
    IF ((@@ERROR != 0) OR (@ReturnCode != 0))
        GOTO QuitWithRollback;
END

DECLARE @jobId BINARY(16);

EXEC @ReturnCode = [msdb].[dbo].[sp_add_job]
        @job_name = @JobName,
        @enabled = 1,
		@notify_level_eventlog = 0,
		@notify_level_email = 0,
		@notify_level_netsend = 0,
		@notify_level_page = 0,
		@delete_level = 0,
		@description = N'Job for update route plan current week value.',
		@category_name = N'[Uncategorized (Local)]',
		@owner_login_name = @OwnerLoginName,
        @job_id = @jobId OUTPUT;

IF ((@@ERROR != 0) OR (@ReturnCode != 0))
    GOTO QuitWithRollback;

EXEC @ReturnCode = [msdb].[dbo].[sp_add_jobstep]
        @job_id = @jobId,
        @step_name = N'Execute Update Procedures',
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0,
        @subsystem=N'TSQL', 
		@command = N'
            EXEC [dbo].[spRoutePlanCurrentWeek];
        ', 
		@database_name = @DatabaseName, 
		@flags = 0;

IF ((@@ERROR != 0) OR (@ReturnCode != 0))
    GOTO QuitWithRollback;

EXEC @ReturnCode = [msdb].[dbo].[sp_update_job] @job_id = @jobId, @start_step_id = 1;

IF ((@@ERROR != 0) OR (@ReturnCode != 0))
    GOTO QuitWithRollback;

EXEC @ReturnCode = [msdb].[dbo].[sp_add_jobschedule]
        @job_id = @jobId,
        @name = N'Weekly Execute Update Procedures',
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=2, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20170102, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'83A188A9-29A0-49AD-9B17-57C018BB4E20';

IF ((@@ERROR != 0) OR (@ReturnCode != 0))
    GOTO QuitWithRollback;

EXEC @ReturnCode = [msdb].[dbo].[sp_add_jobserver] @job_id = @jobId, @server_name = N'(local)';

IF ((@@ERROR != 0) OR (@ReturnCode != 0))
    GOTO QuitWithRollback;

COMMIT TRANSACTION;
GOTO EndSave;

QuitWithRollback:
    IF (@@TRANCOUNT > 0)
        ROLLBACK TRANSACTION;
EndSave:
GO
