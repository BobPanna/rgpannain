/****** Script for SelectTopNRows command from SSMS  ******/

CREATE VIEW imis_Address AS

SELECT DISTINCT		vCompanyPE.Comp_CompanyId AS PrimaryKey, dbo.Address.Addr_Address1 AS AddressAddress1, dbo.Address.Addr_Address2 AS AddressAddress2, 
					dbo.Address.Addr_Address3 as AddressAddress3, dbo.Address.Addr_City AS AddressCity, dbo.Address.addr_state AS AddressProvince, dbo.Address.Addr_PostCode AS AddressPostal,
					dbo.Address.Addr_UpdatedDate AS AddressLastUpdated
    
FROM				dbo.Notes RIGHT OUTER JOIN
					dbo.vCompanyPE ON dbo.Notes.Note_ForeignId = dbo.vCompanyPE.Comp_CompanyId LEFT OUTER JOIN
					dbo.Communication RIGHT OUTER JOIN
					dbo.Comm_Link ON dbo.Communication.Comm_CommunicationId = dbo.Comm_Link.CmLi_Comm_CommunicationId ON dbo.vCompanyPE.Comp_CompanyId = dbo.Comm_Link.CmLi_Comm_CompanyId LEFT OUTER JOIN
					dbo.Address ON dbo.vCompanyPE.Comp_PrimaryAddressId = dbo.Address.Addr_AddressId
						 
WHERE				(dbo.vCompanyPE.Comp_Deleted IS NULL) AND (dbo.Address.Addr_Deleted IS NULL) AND (dbo.Comm_Link.CmLi_Deleted IS NULL) AND (dbo.Communication.Comm_Deleted IS NULL)

