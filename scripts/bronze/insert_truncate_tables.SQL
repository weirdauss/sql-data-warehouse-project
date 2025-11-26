/*

purpose: Filling the tables

*/


USE [Data Warehouse]
GO
/****** Object:  StoredProcedure [bronze].[load_bronze]    Script Date: 26-Nov-25 2:37:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [bronze].[load_bronze] AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_load DATETIME, @end_load DATETIME;
	BEGIN TRY
		PRINT '==============================================='
		PRINT 'Loading Bronze Layer'
		PRINT '==============================================='

		SET @start_load = GETDATE();

		PRINT '-----------------------------------------------'
		PRINT 'Loading CRM Tables'
		PRINT '-----------------------------------------------'

		
		PRINT '>> Truncating Table: bronze.crm_cust_info'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info; --empty it first before adding
		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\Users\ILHAM FIRDAUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:	' + CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR) +' Seconds';
		PRINT '-------------------------'

		PRINT '>> Truncating Table: bronze.crm_prd_info'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info; --empty it first before adding
		BULK INSERT bronze.crm_prd_info 
		FROM 'C:\Users\ILHAM FIRDAUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:	' + CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR) +' Seconds';
		PRINT '-------------------------'

		PRINT '>> Truncating Table: bronze.crm_sales_details'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details; --empty it first before adding
		BULK INSERT bronze.crm_sales_details 
		FROM 'C:\Users\ILHAM FIRDAUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:	' + CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR) +' Seconds';
		PRINT '-------------------------'

		PRINT '-----------------------------------------------'
		PRINT 'Loading ERP Tables'
		PRINT '-----------------------------------------------'

		PRINT '>> Truncating Table: bronze.erp_cust_az12'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12; --empty it first before adding
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\ILHAM FIRDAUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:	' + CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR) +' Seconds';
		PRINT '-------------------------'

		PRINT '>> Truncating bronze.erp_loc_a101'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101; --empty it first before adding
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\ILHAM FIRDAUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:	' + CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR) +' Seconds';
		PRINT '-------------------------'

		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2; --empty it first before adding
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\ILHAM FIRDAUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION:	' + CAST(DATEDIFF(SECOND,@start_time, @end_time) AS NVARCHAR) +' Seconds';
		PRINT '-------------------------'

		SET @end_load = GETDATE();

		PRINT '===================================='
		PRINT 'LOADING BRONZE LAYER IS COMPLETE'
		PRINT 'TOTAL LOAD DURATION:	' + CAST(DATEDIFF(SECOND,@start_load, @end_load) AS NVARCHAR) +' Seconds';
		PRINT '===================================='
	END TRY
BEGIN CATCH
	PRINT '--------------------------------------------'
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message' +	ERROR_MESSAGE();
	PRINT 'Error Message' +	CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message' +	CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '--------------------------------------------'
END CATCH
END 
