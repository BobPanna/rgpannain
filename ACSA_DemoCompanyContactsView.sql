 CREATE VIEW ACSA_DemoCompanyContacts AS


SELECT DISTINCT		dbo.vCompanyPE.Comp_CompanyId AS PrimaryKey, dbo.vCompanyPE.comp_contactname_c AS CompanyContact_Name,
					vCompanyPE.Comp_EmailAddress AS CompanyContact_Email, 
					vCompanyPE.Comp_PhoneAreaCode +' '+ SUBSTRING(vCompanyPE.Comp_PhoneNumber,1,3) + '-' + SUBSTRING(Comp_PhoneNumber, 4, 4)  AS CompanyContact_Phone,
					'Primary'  as CompanyContact_ContactType,	vCompanyPE.Comp_UpdatedDate AS LastSynchronized

FROM		         dbo.Notes RIGHT OUTER JOIN
                     dbo.vCompanyPE ON dbo.Notes.Note_ForeignId = dbo.vCompanyPE.Comp_CompanyId LEFT OUTER JOIN
                     dbo.Communication RIGHT OUTER JOIN
                     dbo.Comm_Link ON dbo.Communication.Comm_CommunicationId = dbo.Comm_Link.CmLi_Comm_CommunicationId ON dbo.vCompanyPE.Comp_CompanyId = dbo.Comm_Link.CmLi_Comm_CompanyId LEFT OUTER JOIN
                     dbo.Address ON dbo.vCompanyPE.Comp_PrimaryAddressId = dbo.Address.Addr_AddressId

WHERE		        (dbo.vCompanyPE.Comp_Deleted IS NULL) AND (dbo.Address.Addr_Deleted IS NULL) AND (dbo.Comm_Link.CmLi_Deleted IS NULL) AND (dbo.Communication.Comm_Deleted IS NULL)


