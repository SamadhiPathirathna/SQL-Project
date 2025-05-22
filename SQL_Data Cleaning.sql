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

