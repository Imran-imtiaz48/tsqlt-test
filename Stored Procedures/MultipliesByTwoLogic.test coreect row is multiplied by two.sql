SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [MultipliesByTwoLogic].[Test_CorrectRowIsMultipliedByTwo]
AS
BEGIN
    -- Set up a fake version of the 'Stuff' table using tSQLt
    EXEC tSQLt.FakeTable 'dbo', 'Stuff';

    -- Insert test data into the fake 'Stuff' table
    INSERT INTO dbo.Stuff (Id, StuffNumber) VALUES (1, 2);
    INSERT INTO dbo.Stuff (Id, StuffNumber) VALUES (2, 3);
    INSERT INTO dbo.Stuff (Id, StuffNumber) VALUES (3, 4);

    -- Create a temporary table to store the actual result
    CREATE TABLE #Actual (
        StuffNumber INT
    );

    -- Execute the procedure and store the result in the #Actual table
    INSERT INTO #Actual
    EXEC dbo.MultipliesByTwo '2';

    -- Create a temporary table to store the expected result
    CREATE TABLE #Expected (
        StuffNumber INT
    );

    -- Insert the expected value (3 * 2) into the #Expected table
    INSERT INTO #Expected (StuffNumber) VALUES (3 * 2);

    -- Compare the #Actual and #Expected tables using tSQLt
    EXEC tSQLt.AssertEqualsTable '#Expected', '#Actual';
END;
GO
