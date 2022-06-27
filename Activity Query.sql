/****** Script for SelectTopNRows command from SSMS  ******/

CREATE VIEW  imis_Activity AS

SELECT DISTINCT		TOP (50) 
						vCompanyPE.Comp_CompanyId AS PrimaryKey, C.Comm_CreatedDate AS ActivityCreatedDate, C.Comm_Note AS ActivityDescription, 
						C.Comm_Action AS ProductCode, C.Comm_Status AS ActivityActionCodes , C.Comm_ToDateTime AS ActivityTicklerDate, 
						dbo.Users.User_FirstName + ' ' + dbo.Users.User_LastName AS ActivityUF_1, C.Comm_DocDir AS ActivityUF_2, C.Comm_DocName AS ActivityUF_2cont, 
						C.Comm_UpdatedDate AS ActivityUF_6, 'acsa_comms' AS ActivityType
										

    
FROM					dbo.Notes 
						RIGHT OUTER JOIN
                        dbo.vCompanyPE ON dbo.Notes.Note_ForeignId = dbo.vCompanyPE.Comp_CompanyId LEFT OUTER JOIN
                        dbo.Communication C 
						
						RIGHT OUTER JOIN
                        dbo.Comm_Link ON C.Comm_CommunicationId = dbo.Comm_Link.CmLi_Comm_CommunicationId ON dbo.vCompanyPE.Comp_CompanyId = dbo.Comm_Link.CmLi_Comm_CompanyId LEFT OUTER JOIN
						dbo.Address ON dbo.vCompanyPE.Comp_PrimaryAddressId = dbo.Address.Addr_AddressId
						
						JOIN 
						dbo.Users ON C.Comm_CreatedBy = dbo.Users.User_UserId
					
						
						 
WHERE					(dbo.vCompanyPE.Comp_Deleted IS NULL) AND (dbo.Address.Addr_Deleted IS NULL) AND (dbo.Comm_Link.CmLi_Deleted IS NULL) AND (C.Comm_Deleted IS NULL)
						AND (C.Comm_CreatedDate IS NOT NULL)

--ORDER BY PrimaryKey DESC
 

 


