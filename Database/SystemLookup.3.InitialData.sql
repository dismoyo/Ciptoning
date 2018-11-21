USE [IDOS];
GO

DELETE FROM [dbo].[SystemLookup];
GO

DBCC CHECKIDENT (SystemLookup, RESEED, 0);
GO

DECLARE @Group nvarchar(128);
DECLARE @ParentID int;
DECLARE @Name nvarchar(128);
DECLARE @Value_Int32 int;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- BOOLEAN YES NO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'BooleanYesNo';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'YES';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, @Value_Int32, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'NO';
    SET @Value_Int32 = 0;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, @Value_Int32, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- USER STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'UserStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- PRODUCT STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'ProductItemStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'GOOD';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'HOLD';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'BAD';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'DISPOSED';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- COMPANY STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'CompanyStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SITE DISTRIBUTION TYPE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SiteDistributionType';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'DISTRIBUTOR';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'BRANCH';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'DEPOT';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SITE STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SiteStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- WAREHOUSE TYPE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'WarehouseType';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'MAIN';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'SALESMAN';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- WAREHOUSE STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'WarehouseStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- PRODUCT STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'ProductStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- PRODUCT PRICE STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'ProductPriceStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- PRODUCT PRICE GROUP
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'ProductPriceGroup';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'STANDARD PRICE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'STANDARD ONLINE PRICE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'ONLINE PRICE';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- PRODUCT LOT STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'ProductLotStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- TRANSACTION TYPE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'TransactionType';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'Sales Order';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'Sales Order Return';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sales Order Swap';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sales Order Sample';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
    
    SET @Name = 'Sales Order FOC';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Opname';
	SET @Value_Int32 = 6;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Changes';
	SET @Value_Int32 = 7;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Transfer';
	SET @Value_Int32 = 8;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Disposal';
	SET @Value_Int32 = 9;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Receival';
	SET @Value_Int32 = 12;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- PRODUCT STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'DocumentStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'DRAFT';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'POSTED';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'DISCARDED';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'VOIDED';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- DELIVERY ORDER REFERENCE TRANSACTION TYPE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'DORefTransactionType';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'Sales Order';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'Sales Order Return';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sales Order Swap';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sales Order Sample';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
    
    SET @Name = 'Sales Order FOC';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Transfer';
	SET @Value_Int32 = 8;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SALESMAN CATEGORY
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SalesmanCategory';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'DIRECT SALES (DSA)';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, 'DSA', NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	--SET @Name = 'TAKING ORDER (TO)';
	--SET @Value_Int32 = 2;
	--INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	--	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'TAKING ORDER GROSIR (TOG)';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, 'TOG', NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'TAKING ORDER MM (TOM)';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, 'TOM', NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'SPREADER (SPD)';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, 'SPD', NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'TAKING ORDER RETAIL (TOR)';
	SET @Value_Int32 = 6;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, 'TOR', NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
	
	SET @Name = 'TAKING ORDER ALL (TOA)';
	SET @Value_Int32 = 7;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, 'TOA', NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SALESMAN GROUP
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SalesmanGroup';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'MIX';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'EXCLUSIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SALESMAN STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SalesmanStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- DISCOUNT GROUP STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'DiscountGroupStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- DISCOUNT STRATA STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'DiscountStrataStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- CUSTOMER STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'CustomerStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

    SET @Name = 'NEW';
	SET @Value_Int32 = 0;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'CLOSED';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
				

                
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- CUSTOMER TERM OF PAYMENT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'CustomerTermOfPayment';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = '0 DAY';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = '7 DAYS';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = '14 DAYS';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = '21 DAYS';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = '28 DAYS';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = '60 DAYS';
	SET @Value_Int32 = 6;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = '90 DAYS';
	SET @Value_Int32 = 7;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SALES ORDER TRANSACTION TYPE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SOTransactionType';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'Sales Order';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'Sales Order Return';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sales Order Swap';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sales Order Sample';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
    
    SET @Name = 'Sales Order FOC';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SALES ORDER REFERENCE TRANSACTION TYPE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SORefTransactionType';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'Sales Order';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'Sales Order Swap';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sales Order Sample';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
    
    SET @Name = 'Sales Order FOC';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- PRODUCT UOM
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'ProductUOM';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'PCS';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'BAR';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'BANDED';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'HANGER';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'CLUSTER';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'BOX';
	SET @Value_Int32 = 6;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'CARD BOX';
	SET @Value_Int32 = 7;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);


		
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SO RETURN REASON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SOReturnReason';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

    SET @Name = 'Packaging is broken';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'Product not sold';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Expired product items';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'Permanently closed customer';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
	
    SET @Name = 'Incorrect data entry';
	SET @Value_Int32 = 0;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

		
	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SO CANCEL TRANSACTION TYPE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SOCancelTransactionType';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'Sales Order';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'Sales Order Sample';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
    
    SET @Name = 'Sales Order FOC';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);


		
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- WEEK
--------------------------------------------------------------------------------------------------------------------------------------------------------------------		

SET @Group = 'Week';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);


	SET @Name = 'Odd';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'Even';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- DAY
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
SET @Group = 'Day';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	SET @Name = 'Sunday';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'Monday';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'Tuesday';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'Wednesday';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'Thursday';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'Friday';
	SET @Value_Int32 = 6;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'Saturday';
	SET @Value_Int32 = 7;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
	VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- PROMO PRODUCT STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'PromoProductStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SALESMAN CALL NO TRX REASON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SalesmanCallNoTrxReason';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'Temporary closed';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'Pic not available';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sufficient inventory';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Cash not available';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Collection only';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Overdue';
	SET @Value_Int32 = 6;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Relationship issue';
	SET @Value_Int32 = 7;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Price issue';
	SET @Value_Int32 = 8;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Quality issue';
	SET @Value_Int32 = 9;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SALESMAN CALL STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'SalesmanCallStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'CHECKOUT';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'NOT BUY';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- SO CANCEL TRANSACTION TYPE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'UserNotificationCategory';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	SET @Name = 'Sales Order';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'Sales Order Return';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sales Order Swap';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Sales Order Sample';
	SET @Value_Int32 = 4;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
    
    SET @Name = 'Sales Order FOC';
	SET @Value_Int32 = 5;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Opname';
	SET @Value_Int32 = 6;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Changes';
	SET @Value_Int32 = 7;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Transfer';
	SET @Value_Int32 = 8;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Disposal';
	SET @Value_Int32 = 9;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

    SET @Name = 'Stock Receival';
	SET @Value_Int32 = 12;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- REPORT CUSTOMER STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'ReportCustomerStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

    SET @Name = 'NEW';
	SET @Value_Int32 = 0;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'ACTIVE';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'INACTIVE';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
		
	SET @Name = 'CLOSED';
	SET @Value_Int32 = 3;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
				
    SET @Name = 'REGISTERED';
	SET @Value_Int32 = 10;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- REPORT CUSTOMER STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'PromoTermOfPayment';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

    SET @Name = 'Customer';
	SET @Value_Int32 = 0;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'Promo Product';
	SET @Value_Int32 = 7;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
   
   
   
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set lookup group.
-- CUSTOMER ROUTE STATUS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET @Group = 'CustomerRouteStatus';
SET @ParentID = NULL;
DELETE FROM [dbo].[SystemLookup] WHERE ([Group] = @Group);

	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Set lookup items.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

    SET @Name = 'ASSIGNED';
	SET @Value_Int32 = 1;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);

	SET @Name = 'UNASSIGNED';
	SET @Value_Int32 = 2;
	INSERT INTO [dbo].[SystemLookup] ([Name], [Value_Boolean], [Value_Int32], [Value_Double], [Value_String], [Value_Guid], [Value_DateTime], [ParentID], [Group], [SortIndex], [IsActive], [IsAuthorization], [CreatedDate], [ModifiedDate])
		VALUES (@Name, NULL, @Value_Int32, NULL, NULL, NULL, NULL, @ParentID, @Group, @Value_Int32, 1, 0, GETUTCDATE(), NULL);
	         