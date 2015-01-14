SELECT 
	A.`ID`,
	A.`ParcelID`,
	A.`TagLine`,
	A.`HouseNumber`,
	A.`Street`,
	A.`State`,
	A.`City`,
	A.`County`,
	A.`Zip`,
	A.`Zip4`,
	GROUP_CONCAT(DISTINCT CONCAT(P.`First`, ' ', P.`Last`) ORDER BY AP.`StartTime` ASC SEPARATOR ', ') AS `Owners`,
	GROUP_CONCAT(DISTINCT AI.`FileName` ORDER BY AI.`Weight` ASC SEPARATOR ', ') AS ImageFiles,
	S.`StartedOn`,
	S.`AssignedTo`,
	S.`Name`,
	S.`Description`,
	S.`ID`
FROM 
	Address A
	LEFT JOIN AddressToPerson AP ON (A.`ID` = AP.`AddressID` AND AP.`EndTime` IS NULL)
	LEFT JOIN Person P ON (AP.`PersonID` = P.`ID`)
	-- LEFT JOIN Relationships R ON (AP.`RelationShipID` = R.`ID`)
	LEFT JOIN AddressImage AI ON (A.`ID` = AI.`AddressID`)
	LEFT JOIN Step S ON (A.`ID` = S.`AddressID` AND S.`StartedOn` IS NOT NULL AND S.`CompletedOn` IS NULL)
WHERE
	1=1
GROUP BY 
	A.`ID`