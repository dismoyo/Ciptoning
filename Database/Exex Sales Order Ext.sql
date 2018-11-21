--SELECT * FROM vSalesOrder

SELECT * FROM SystemLookup WHERE [Group] = 'TransactionType'
SELECT * FROM vSalesOrderSwap

SELECT * FROM SalesOrderExt

SELECT * FROM SalesOrderSwapExt
--EXEC [dbo].[spSalesOrderExt] '6364881C-7EA6-8AA2-7D5A-439CC9DDA33F'

--DECLARE @x nvarchar(512);
--EXEC [dbo].[spFlattenCustomerCategory] 10, @FlattenCategory = @x OUTPUT;
--SELECT @x;

--SELECT * FROM vCustomerCategory


DECLARE @DocumentID uniqueidentifier;
DECLARE CUR CURSOR FOR   
SELECT DocumentID FROM [dbo].[SalesOrderSwap]
  
OPEN CUR FETCH NEXT FROM CUR INTO @DocumentID
    WHILE (@@FETCH_STATUS = 0)
    BEGIN  
        --PRINT CAST(@DocumentID AS varchar(20)) + CHAR(13) + CHAR(10);  
        EXEC [dbo].[spSalesOrderSwapExt] @DocumentID;

        FETCH NEXT FROM CUR INTO @DocumentID;
    END   
CLOSE CUR;  
DEALLOCATE CUR;

--DELETE FROM SalesOrderExt WHERE DocumentID IN (SELECT DocumentID FROM SalesOrder WHERE DocumentStatusID != 2)