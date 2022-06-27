/****** Script for SelectTopNRows command from SSMS  ******/


CREATE VIEW ACSA_Notes AS 

SELECT DISTINCT		top(50)
						vCompanyPE.Comp_CompanyId AS PrimaryKey, dbo.Notes.Note_Note AS NotesNote , dbo.Users.User_FirstName + ' ' + dbo.Users.User_LastName AS CreatedBy,  dbo.Notes.Note_UpdatedDate AS NotesLastUpdated, 
						dbo.Notes.Note_CreatedDate AS NotesCreatedOn, dbo.Notes.note_subject_c AS NotesSubject
    
FROM		            dbo.Notes 
						RIGHT OUTER JOIN
					    dbo.vCompanyPE ON dbo.Notes.Note_ForeignId = dbo.vCompanyPE.Comp_CompanyId LEFT OUTER JOIN
                        dbo.Communication C
						RIGHT OUTER JOIN
                        dbo.Comm_Link ON C.Comm_CommunicationId = dbo.Comm_Link.CmLi_Comm_CommunicationId ON dbo.vCompanyPE.Comp_CompanyId = dbo.Comm_Link.CmLi_Comm_CompanyId LEFT OUTER JOIN
                        dbo.Address ON dbo.vCompanyPE.Comp_PrimaryAddressId = dbo.Address.Addr_AddressId
						JOIN 
						dbo.Users ON C.Comm_CreatedBy = dbo.Users.User_UserId
						 
WHERE					(dbo.vCompanyPE.Comp_Deleted IS NULL) AND (dbo.Address.Addr_Deleted IS NULL) AND (dbo.Comm_Link.CmLi_Deleted IS NULL) AND (C.Comm_Deleted IS NULL) 
						AND (dbo.Notes.Note_CreatedDate IS NOT NULL)


 
-- ORDER BY PrimaryKey DESC
 



