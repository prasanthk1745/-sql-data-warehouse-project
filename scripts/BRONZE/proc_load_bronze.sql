/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

  CREATE OR ALTER PROCEDURE BRONZE.LOAD_BRONZE AS
   BEGIN
       DECLARE @START_TIME DATETIME , @END_TIME DATETIME,@BATCH_START_TIME DATETIME,@BATCH_END_TIME DATETIME;
        BEGIN TRY
          SET @BATCH_START_TIME = GETDATE();
          PRINT'------------------------------------------------------'
          PRINT 'LOADING BRONZE LAYER';
          PRINT'------------------------------------------------------';


          PRINT'------------------------------------------------------';
          PRINT' LOADING CRM TABLES'
          PRINT'------------------------------------------------------';

      
            SET @START_TIME = GETDATE();
          PRINT'>> TRUNCATING TABLE :bronze.CRM_CUST_INFO';
            TRUNCATE TABLE bronze.CRM_CUST_INFO;

        
          PRINT '>> INSERTING DATA INTO :BRONZE.CRM_CUST_INFO';
            BULK INSERT BRONZE.CRM_CUST_INFO
            FROM 'C:\Users\Prasanth\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
            WITH (
                    FIRSTROW = 2,
                    FIELDTERMINATOR = ',',
                    TABLOCK
            );
               SET @END_TIME = GETDATE();
               PRINT'>> LOAD DURTAION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
               PRINT '---------------';


           
            SET @START_TIME = GETDATE();
            PRINT'>> TRUNCATING TABLE :bronze.CRM_PRD_INFO';
            TRUNCATE TABLE BRONZE.CRM_PRD_INFO

            PRINT'>> INSERTING DATA INTO:BRONZE.CRM_PRD_INFO';
            BULK INSERT BRONZE.CRM_PRD_INFO
            FROM 'C:\Users\Prasanth\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
            WITH
            (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                TABLOCK
            );
             SET @END_TIME = GETDATE();
               PRINT'>> LOAD DURTAION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
               PRINT '---------------';


               SET @START_TIME = GETDATE();
            PRINT'>> TRUNCAING TABLE :bronze.crm_sales_details';
            TRUNCATE TABLE bronze.crm_sales_details

            PRINT'>> INSERTING DATA INTO:BRONZE.CRM_SALES_DETAILS';
            BULK INSERT BRONZE.CRM_SALES_DETAILS
            FROM 'C:\Users\Prasanth\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
               WITH
            (
                  FIRSTROW = 2,
                  FIELDTERMINATOR = ',',
                  TABLOCK
            );
   
               SET @END_TIME = GETDATE();
               PRINT'>> LOAD DURTAION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
               PRINT '---------------';


        
          
          PRINT'------------------------------------------------------';
          PRINT' LOADING ERP TABLES'
          PRINT'------------------------------------------------------';

      
               SET @START_TIME = GETDATE();
          PRINT'>> TRUNCATING TABLE :BRONZE.ERP_CUST_AZ12';
            TRUNCATE TABLE BRONZE.ERP_CUST_AZ12

            PRINT'>> INSERTING DATA INTO: BRONZE.ERP_CUST_AZ12';
            BULK INSERT bronze.erp_cust_az12
            FROM 'C:\Users\Prasanth\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
            WITH
            (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                TABLOCK
            );
               SET @END_TIME = GETDATE();
               PRINT'>> LOAD DURTAION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
               PRINT '---------------';


               SET @START_TIME = GETDATE();
            PRINT'>> TRUNCATING TABLE BRONZE:ERP_LOC_A101';
            TRUNCATE TABLE BRONZE.ERP_LOC_A101

            PRINT'>>INSERING DATA INTO :BRONZE.ERP_LOC_A101';
            BULK INSERT BRONZE.ERP_LOC_A101
            FROM 'C:\Users\Prasanth\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
            WITH
            (
               FIRSTROW = 2,
               FIELDTERMINATOR=',',
               TABLOCK
            );
               SET @END_TIME = GETDATE();
               PRINT'>> LOAD DURTAION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
               PRINT '---------------';


                SET @START_TIME = GETDATE();
            PRINT'>> TRUNCATING TABLE :BRONZE.ERP_PX_CAT_G1V2';
            TRUNCATE TABLE BRONZE.ERP_PX_CAT_G1V2

            PRINT'>> INSERTING DATA INTO:BRONZE.ERP_PX_CAT_G1V2';
            BULK INSERT BRONZE.ERP_PX_CAT_G1V2
            FROM 'C:\Users\Prasanth\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
            WITH
            (
               FIRSTROW = 2,
               FIELDTERMINATOR = ',',
               TABLOCK
            );
            SET @END_TIME = GETDATE();
               PRINT'>> LOAD DURTAION:' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + 'SECONDS';
               PRINT '---------------';

               SET @BATCH_END_TIME = GETDATE();
               PRINT'====================';
               PRINT'LOADING BRONZE LAYER IS COMPLETED';
               PRINT' - TOTAL LOAD DURATION:' + CAST(DATEDIFF(SECOND,@BATCH_START_TIME,@BATCH_END_TIME) AS NVARCHAR) + ' SECONDS';
               PRINT'=====================';

            END TRY
            BEGIN CATCH
            PRINT'>>--------------------------------------';
            PRINT'ERROR MESSAGE' +  ERROR_MESSAGE();
            PRINT'ERROR MESSAGE' +  CAST(ERROR_NUMBER() AS NVARCHAR);
            PRINT'ERROR MESSAGE' +  CAST(ERROR_STATE () AS NVARCHAR);
            PRINT'-----------------------------------------';
     END CATCH
    END



