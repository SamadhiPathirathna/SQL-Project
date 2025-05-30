/*Cleaning Data in SQL Queries*/


Select *
From PortfolioProject.dbo.[NashvilleHousing ]


-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


Select SaleDate, convert(Date,SaleDate) 
From PortfolioProject.dbo.[NashvilleHousing ]

Update PortfolioProject.dbo.[NashvilleHousing ]
SET SaleDate = CONVERT(Date,SaleDate)


-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data


Select *
From PortfolioProject.dbo.[NashvilleHousing ]
--Where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.[NashvilleHousing ]a
JOIN PortfolioProject.dbo.[NashvilleHousing ]b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID 
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.[NashvilleHousing ]a
JOIN PortfolioProject.dbo.[NashvilleHousing ]b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID  <> b.UniqueID 
Where a.PropertyAddress is null


-----------------------------------------------------------------------------------------------------------------------------------------------------------


-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From PortfolioProject.dbo.[NashvilleHousing]
--Where PropertyAddress is null
--order by ParcelID


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)  +1, LEN(PropertyAddress)) as Address
From PortfolioProject.dbo.[NashvilleHousing ]



ALTER TABLE PortfolioProject.dbo.[NashvilleHousing ]
Add PropertySplitAddress Nvarchar(255);

Update  PortfolioProject.dbo.[NashvilleHousing ]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )



ALTER TABLE  PortfolioProject.dbo.[NashvilleHousing ]
Add PropertySplitCity Nvarchar(255);

Update  PortfolioProject.dbo.[NashvilleHousing ]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))


Select OwnerAddress
From PortfolioProject.dbo.NashvilleHousing




Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE  PortfolioProject.dbo.NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE PortfolioProject.dbo.NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update PortfolioProject.dbo.[NashvilleHousing ]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From PortfolioProject.dbo.[NashvilleHousing ]

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From  PortfolioProject.dbo.[NashvilleHousing ]
Group by SoldAsVacant
order by 2




ALTER TABLE PortfolioProject.dbo.[NashvilleHousing ]
ALTER COLUMN SoldAsVacant varchar(50);

Select SoldAsVacant
, CASE When SoldAsVacant = 1 THEN 'Yes'
	   When SoldAsVacant = 0 THEN 'No'
	   ELSE SoldAsVacant
	   END
From PortfolioProject.dbo.[NashvilleHousing ]


Update  PortfolioProject.dbo.[NashvilleHousing ]
SET SoldAsVacant = CASE When SoldAsVacant = 1 THEN 'Yes'
	   When SoldAsVacant = 0 THEN 'No'
	   ELSE SoldAsVacant
	   END





-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
select *,
ROW_NUMBER() over(
	partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 order by 
				 UniqueID
					) row_num

From PortfolioProject.dbo.[NashvilleHousing ]
--order by ParcelID
)
--delete
--From RowNumCTE
--Where row_num > 1
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress






---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
From PortfolioProject.dbo.[NashvilleHousing ]


ALTER TABLE PortfolioProject.dbo.[NashvilleHousing ]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate



-------------------------------------------------------------------------------------------------------------

-- Count how many properties were sold by Property types
SELECT LandUse, COUNT(*) AS TotalPropertiesSold
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY LandUse
ORDER BY LandUse;


--Property types fetch the highest average price.

SELECT LandUse, AVG(SalePrice) AS AvgPrice
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY LandUse
ORDER BY AvgPrice DESC;


--Identify the cities with the highest number of property sales

SELECT TOP 10 PropertySplitCity AS City,  COUNT(*) AS TotalSales
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY PropertySplitCity
ORDER BY TotalSales DESC;

--Show how many properties were sold each city and their average prices

SELECT PropertySplitCity,COUNT(*) AS TotalSales,ROUND(AVG(SalePrice), 2) AS AvgSalePrice
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY PropertySplitCity
ORDER BY PropertySplitCity;


--Compare how many vacant and non-vacant properties were sold and their average prices

SELECT  SoldAsVacant,COUNT(*) AS NumberOfProperties,ROUND(AVG(SalePrice), 2) AS AvgSalePrice
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY SoldAsVacant;


--Find properties that were sold more than once (resales or flips)

SELECT PropertySplitAddress, COUNT(*) AS TimesSold
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY PropertySplitAddress
HAVING COUNT(*) > 1
ORDER BY TimesSold DESC;


-- Display sales over 10 million to spot luxury property sales
SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
WHERE SalePrice > 10000000
ORDER BY SalePrice DESC;


-- Find the top 10 owners based on the number of properties listed under their name

SELECT TOP 10 OwnerName,COUNT(*) AS PropertiesOwned
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY OwnerName
ORDER BY PropertiesOwned DESC;



