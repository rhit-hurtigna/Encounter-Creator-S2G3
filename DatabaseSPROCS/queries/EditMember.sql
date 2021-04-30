/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[Username]
      ,[Salt]
      ,[PasswordHash]
  FROM [EncounterCreatorS2G3].[dbo].[DM]

DELETE FROM DM