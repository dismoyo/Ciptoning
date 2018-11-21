USE IDOS_LIVE;
GO

UPDATE
        [dbo].[SalesOrderReturn]
    SET
        [RawTotalGross] = ([RawTotalPrice] - [RawTotalDiscountStrata1Amount]),
        [RawTotalTax]= ([RawTotalPrice] - [RawTotalDiscountStrata1Amount]) * 0.1,
        [RawTotal] = ([RawTotalPrice] - [RawTotalDiscountStrata1Amount]) + (([RawTotalPrice] - [RawTotalDiscountStrata1Amount]) * 0.1),
        [RawTotalDiscountStrata2Amount] = 0,
        [RawTotalDiscountStrata3Amount] = 0,
	    [RawTotalDiscountStrata4Amount] = 0,
        [RawTotalDiscountStrata5Amount] = 0,
	    [RawTotalAddDiscountStrataAmount] = 0,
        [TotalGross] = CAST((CAST([TotalPrice] AS decimal(14, 4)) - CAST([TotalDiscountStrata1Amount] AS decimal(14, 4))) AS decimal(14, 4)),
        [TotalTax] = CAST((CAST([TotalPrice] AS decimal(14, 4)) - CAST([TotalDiscountStrata1Amount] AS decimal(14, 4))) * 0.1 AS decimal(14, 4)),
        [Total] = CAST((CAST([TotalPrice] AS decimal(14, 4)) - CAST([TotalDiscountStrata1Amount] AS decimal(14, 4))) + CAST(((CAST([TotalPrice] AS decimal(14, 4)) - CAST([TotalDiscountStrata1Amount] AS decimal(14, 4))) * 0.1) AS decimal(14, 4)) AS decimal(14, 4)),
        [TotalDiscountStrata2Amount] = 0,
        [TotalDiscountStrata3Amount] = 0,
	    [TotalDiscountStrata4Amount] = 0,
        [TotalDiscountStrata5Amount] = 0,
	    [TotalAddDiscountStrataAmount] = 0
    FROM
        [dbo].[SalesOrderReturn]
    WHERE
	    ([RawTotalDiscountStrata2Amount] > 0) OR
        ([RawTotalDiscountStrata3Amount] > 0) OR
	    ([RawTotalDiscountStrata4Amount] > 0) OR
        ([RawTotalDiscountStrata5Amount] > 0) OR
	    ([RawTotalAddDiscountStrataAmount] > 0)
    

SELECT
        ([RawTotalPrice] - [RawTotalDiscountStrata1Amount]) [RawTotalGross],
        ([RawTotalPrice] - [RawTotalDiscountStrata1Amount]) * 0.1 [RawTotalTax],
        ([RawTotalPrice] - [RawTotalDiscountStrata1Amount]) + (([RawTotalPrice] - [RawTotalDiscountStrata1Amount]) * 0.1) [RawTotal],
        0 [RawTotalDiscountStrata2Amount],
        0 [RawTotalDiscountStrata3Amount],
	    0 [RawTotalDiscountStrata4Amount],
        0 [RawTotalDiscountStrata5Amount],
	    0 [RawTotalAddDiscountStrataAmount],
        CAST((CAST([TotalPrice] AS decimal(14, 4)) - CAST([TotalDiscountStrata1Amount] AS decimal(14, 4))) AS decimal(14, 4)) [TotalGross],
        CAST((CAST([TotalPrice] AS decimal(14, 4)) - CAST([TotalDiscountStrata1Amount] AS decimal(14, 4))) * 0.1 AS decimal(14, 4)) [TotalTax],
        CAST((CAST([TotalPrice] AS decimal(14, 4)) - CAST([TotalDiscountStrata1Amount] AS decimal(14, 4))) + CAST(((CAST([TotalPrice] AS decimal(14, 4)) - CAST([TotalDiscountStrata1Amount] AS decimal(14, 4))) * 0.1) AS decimal(14, 4)) AS decimal(14, 4)) [Total],
        0 [TotalDiscountStrata2Amount],
        0 [TotalDiscountStrata3Amount],
	    0 [TotalDiscountStrata4Amount],
        0 [TotalDiscountStrata5Amount],
	    0 [TotalAddDiscountStrataAmount]
    FROM
        [dbo].[SalesOrderReturn]
    WHERE
	    ([RawTotalDiscountStrata2Amount] > 0) OR
        ([RawTotalDiscountStrata3Amount] > 0) OR
	    ([RawTotalDiscountStrata4Amount] > 0) OR
        ([RawTotalDiscountStrata5Amount] > 0) OR
	    ([RawTotalAddDiscountStrataAmount] > 0)



UPDATE
        [dbo].[SalesOrderReturnSummary]
    SET
        [DiscountStrata2Percentage] = 0,
        [DiscountStrata3Percentage] = 0,
        [DiscountStrata4Percentage] = 0,
        [DiscountStrata5Percentage] = 0,
        [AddDiscountStrataPercentage] = 0,
        [RawSubtotalDiscountStrata2] = [RawSubtotalDiscountStrata1],
        [RawSubtotalDiscountStrata3] = [RawSubtotalDiscountStrata1],
        [RawSubtotalDiscountStrata4] = [RawSubtotalDiscountStrata1],
        [RawSubtotalDiscountStrata5] = [RawSubtotalDiscountStrata1],
        [RawSubtotalGross] = [RawSubtotalDiscountStrata1] / 1.1,
        [RawSubtotalTax] = [RawSubtotalDiscountStrata1] - ([RawSubtotalDiscountStrata1] / 1.1),
        [RawSubtotal] = [RawSubtotalDiscountStrata1],
        [SubtotalDiscountStrata2] = [SubtotalDiscountStrata1],
        [SubtotalDiscountStrata3] = [SubtotalDiscountStrata1],
        [SubtotalDiscountStrata4] = [SubtotalDiscountStrata1],
        [SubtotalDiscountStrata5] = [SubtotalDiscountStrata1],
        [SubtotalGross] = CAST(CAST([SubtotalDiscountStrata1] AS decimal(14, 4)) / 1.1 AS decimal(14, 4)),
        [SubtotalTax] = CAST(CAST([SubtotalDiscountStrata1] AS decimal(14, 4))- CAST(CAST([SubtotalDiscountStrata1] AS decimal(14, 4)) / 1.1 AS decimal(14, 4)) AS decimal(14, 4)),
        [Subtotal] = [SubtotalDiscountStrata1]
    FROM
        [dbo].[SalesOrderReturnSummary]
    WHERE
	    ([DiscountStrata2Percentage] > 0) OR
        ([DiscountStrata3Percentage] > 0) OR
	    ([DiscountStrata4Percentage] > 0) OR
        ([DiscountStrata5Percentage] > 0) OR
	    ([AddDiscountStrataPercentage] > 0)
    

SELECT
        0 [DiscountStrata2Percentage],
        0 [DiscountStrata3Percentage],
        0 [DiscountStrata4Percentage],
        0 [DiscountStrata5Percentage],
        0 [AddDiscountStrataPercentage],
        [RawSubtotalDiscountStrata1] [RawSubtotalDiscountStrata2],
        [RawSubtotalDiscountStrata1] [RawSubtotalDiscountStrata3],
        [RawSubtotalDiscountStrata1] [RawSubtotalDiscountStrata4],
        [RawSubtotalDiscountStrata1] [RawSubtotalDiscountStrata5],
        [RawSubtotalDiscountStrata1] / 1.1 [RawSubtotalGross],
        [RawSubtotalDiscountStrata1] - ([RawSubtotalDiscountStrata1] / 1.1) [RawSubtotalTax],
        [RawSubtotalDiscountStrata1] [RawSubtotal],
        [SubtotalDiscountStrata1] [SubtotalDiscountStrata2],
        [SubtotalDiscountStrata1] [SubtotalDiscountStrata3],
        [SubtotalDiscountStrata1] [SubtotalDiscountStrata4],
        [SubtotalDiscountStrata1] [SubtotalDiscountStrata5],
        CAST(CAST([SubtotalDiscountStrata1] AS decimal(14, 4)) / 1.1 AS decimal(14, 4)) [SubtotalGross],
        CAST(CAST([SubtotalDiscountStrata1] AS decimal(14, 4))- CAST(CAST([SubtotalDiscountStrata1] AS decimal(14, 4)) / 1.1 AS decimal(14, 4)) AS decimal(14, 4)) [SubtotalTax],
        [SubtotalDiscountStrata1] [Subtotal]
    FROM
        [dbo].[SalesOrderReturnSummary]
    WHERE
	    ([DiscountStrata2Percentage] > 0) OR
        ([DiscountStrata3Percentage] > 0) OR
	    ([DiscountStrata4Percentage] > 0) OR
        ([DiscountStrata5Percentage] > 0) OR
	    ([AddDiscountStrataPercentage] > 0)
    