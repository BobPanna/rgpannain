/****** Script for SelectTopNRows command from SSMS  ******/

CREATE VIEW ACSA_Demo_Company AS

SELECT DISTINCT		 vCompanyPE.Comp_CompanyId AS PrimaryKey, dbo.vCompanyPE.comp_wbccode_c AS WCBAccount, dbo.vCompanyPE.comp_allindust_c AS IndustryClassification, 
				  
					CASE dbo.vCompanyPE.comp_corstatus_c
						WHEN 'stand' THEN 'cor'
						WHEN 'secor'THEN 'secor'
					END AS CompanyAuditType, 
				  
					dbo.vCompanyPE.comp_legname_c AS TradeName, vCompanyPE.Comp_UpdatedDate AS LastSynchronized
    
FROM				dbo.Notes RIGHT OUTER JOIN
                    dbo.vCompanyPE ON dbo.Notes.Note_ForeignId = dbo.vCompanyPE.Comp_CompanyId LEFT OUTER JOIN
                    dbo.Communication RIGHT OUTER JOIN
                    dbo.Comm_Link ON dbo.Communication.Comm_CommunicationId = dbo.Comm_Link.CmLi_Comm_CommunicationId ON dbo.vCompanyPE.Comp_CompanyId = dbo.Comm_Link.CmLi_Comm_CompanyId LEFT OUTER JOIN
                    dbo.Address ON dbo.vCompanyPE.Comp_PrimaryAddressId = dbo.Address.Addr_AddressId
						 
WHERE				(dbo.vCompanyPE.Comp_Deleted IS NULL) AND (dbo.Address.Addr_Deleted IS NULL) AND (dbo.Comm_Link.CmLi_Deleted IS NULL) AND (dbo.Communication.Comm_Deleted IS NULL)
 

 


