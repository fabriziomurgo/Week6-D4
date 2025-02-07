SHOW DATABASES;
USE AdventureWorksDW;
SELECT *FROM dimproduct;
SELECT * FROM dimproductsubcategory;
DESCRIBE dimproduct;

-- Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria DimProduct, DimProductSubcategory).

SELECT P.ProductKey, P.ProductAlternateKey, P.EnglishProductName, S.ProductSubcategoryKey, S.EnglishProductSubcategoryName as Subcategory
FROM dimproduct as P
INNER JOIN dimproductsubcategory AS S ON P.ProductSubCategoryKey = S.ProductSubcategoryKey;

SELECT * FROM dimproductcategory;

-- Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria DimProduct, DimProductSubcategory, DimProductCategory).

SELECT P.ProductKey,P.ProductAlternateKey, P.EnglishProductName as Product, S.ProductSubcategoryKey, S.EnglishProductSubcategoryName as Subcategory, C.ProductCategoryKey, C.EnglishProductCategoryName as Category
FROM dimproduct as P
INNER JOIN dimproductsubcategory AS S ON P.ProductSubCategoryKey = S.ProductSubcategoryKey
INNER JOIN dimproductcategory as C ON S.ProductCategoryKey = C.ProductCategoryKey;

SELECT * FROM factresellersales;


-- Esponi lʼelenco dei soli prodotti venduti DimProduct, FactResellerSales). 

SELECT P.EnglishProductName as Product
FROM dimproduct as P
INNER JOIN factresellersales as R ON P.ProductKey = R.ProductKey
WHERE R.OrderQuantity >=1;

-- Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1.

SELECT P.EnglishProductName as Product
FROM dimproduct as P
LEFT JOIN factresellersales as R ON P.ProductKey = R.ProductKey
WHERE R.ProductKey IS NULL AND P.FinishedGoodsFlag = 1;

SELECT P.EnglishProductName as Product
FROM dimproduct as P
WHERE P.FinishedGoodsFlag = 1
AND P.ProductKey NOT IN (
    SELECT R.ProductKey
    FROM factresellersales as R
    WHERE R.OrderQuantity > 0
);

-- Esponi lʼelenco delle transazioni di vendita FactResellerSales) indicando anche il nome del prodotto venduto DimProduct)

SELECT R.SalesOrderNumber, R.OrderDate, R.SalesAmount, P.EnglishProductName as Prodotto
FROM factresellersales as R
INNER JOIN dimproduct as P ON R.ProductKey = P.ProductKey;

-- Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.
SELECT R.SalesOrderNumber, R.OrderDate, R.SalesAmount, P.EnglishProductName as Prodotto, C.EnglishProductCategoryName as Category
FROM factresellersales as R
INNER JOIN dimproduct as P ON R.ProductKey = P.ProductKey
INNER JOIN dimproductsubcategory AS S ON P.ProductSubCategoryKey = S.ProductSubcategoryKey
INNER JOIN dimproductcategory as C ON S.ProductCategoryKey = C.ProductCategoryKey;

-- Esplora la tabella DimReseller.

SELECT * FROM dimreseller;


-- Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 
SELECT R.ResellerName as Reseller_Name, G.City as City, G.StateProvinceName as Province, G.EnglishCountryRegionName as Country
FROM dimreseller as R
INNER JOIN dimgeography as G ON R.GeographyKey = G.GeographyKey;

SELECT * FROM dimgeography;

SELECT F.SalesOrderNumber as Order_Number,F.SalesOrderLineNumber, F.OrderDate, P.EnglishProductName as ProductName,C.EnglishProductCategoryName as Category, R.ResellerName, G.City
FROM factresellersales as F
INNER JOIN dimproduct as P ON F.ProductKey = P.ProductKey
INNER JOIN dimproductsubcategory AS S ON P.ProductSubCategoryKey = S.ProductSubcategoryKey
INNER JOIN dimproductcategory as C ON S.ProductCategoryKey = C.ProductCategoryKey
INNER JOIN dimgeography as G ON F. SalesTerritoryKey = G.SalesTerritoryKey
INNER JOIN dimreseller as R ON G.GeographyKey = R.GeographyKey;






 









