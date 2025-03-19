-- Завдання 3 
-- 1. Пошук власників компаній без по батькові
SELECT * 
FROM company_owner
WHERE surname IS NULL;
-- 2. Пошук компаній, у назві яких є слово "Буд"
SELECT * 
FROM company
WHERE company_name LIKE '%Буд%'
-- 3. Вибірка компаній з ідентифікатором власника більше 50
SELECT * 
FROM company_owner_company
WHERE owner_id > 50;
-- 4. Пошук електроніки з ціною менше або рівною 10 000
SELECT * 
FROM product
WHERE type = 'Електроніка' AND price_per_unit <= 10000;
-- 5. Пошук продуктів з кількістю більше 50 одиниць
SELECT * 
FROM company_product
WHERE product_quantity > 50;
-- 6. Пошук кількості контрактів для кожного постачальника у визначений період
SELECT supplier_company, COUNT(*) AS contract_count
FROM contract
WHERE contract_date BETWEEN '2024-01-01' AND '2025-06-30'
GROUP BY supplier_company;

-- Завдання 4
-- 1. Вибрати всіх власників компаній, у яких є по батькові та телефон не починається з '050'
SELECT * 
FROM company_owner
WHERE surname IS NOT NULL AND phone_number NOT LIKE '050%';
-- 2. Вибрати всі компанії, у яких у назві є слово "Торг" або "Буд"
SELECT * 
FROM company
WHERE company_name LIKE '%Торг%' OR company_name LIKE '%Буд%';
-- 3. Вибрати всі зв’язки між власниками та компаніями, де власник має ID більше 40, але не 45 і не 50
SELECT * 
FROM company_owner_company
WHERE owner_id > 40 AND owner_id NOT IN (45, 50);
-- 4. Вибрати всі товари типу "Побутова техніка", які коштують від 5000 до 20000
SELECT * 
FROM product
WHERE type = 'Побутова техніка' AND price_per_unit BETWEEN 5000 AND 20000;
-- 5. Вибрати всі товари, де кількість на складі або більше 100, або ціна нижча за 5000
SELECT * 
FROM company_product
WHERE product_quantity >= 100;
-- 6. Вибрати компанії, які мають більше ніж 5 укладених контрактів, але не є постачальниками 'ТОВ Альфа'
SELECT supplier_company, COUNT(*) AS contract_count
FROM contract
WHERE supplier_company != 'ТОВ Альфа'
GROUP BY supplier_company
HAVING COUNT(*) > 5;

-- Завдання 5
-- 1. Вибрати власників компаній, у яких прізвище починається на "Пет"
SELECT * 
FROM company_owner
WHERE last_name LIKE 'Пет%';
-- 2. Вибрати компанії, назва яких містить слово "Еко"
SELECT * 
FROM company
WHERE company_name LIKE '%Еко%';
-- 3. Вибрати продукти, у назві яких є слово "Про"
SELECT * 
FROM product
WHERE name LIKE '%Про%';
-- 4. Вибрати договори, номер яких починається з "2024-"
SELECT * 
FROM contract
WHERE contract_date LIKE '2024-%';
-- 5. Вибрати компанії, у яких адреса починається з "вул. Центральна"
SELECT * 
FROM company
WHERE address LIKE 'вул. Центральна%';
-- 6. Вибрати контракти, номер яких закінчується на "01"
SELECT * 
FROM contract
WHERE contract_number LIKE '%01';

-- Завдання 6
-- 1. Вибрати компанії та їхніх власників
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
JOIN company_owner_company ON company.company_name = company_owner_company.company_name
JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 2. Вибрати продукти та компанії, які їх виробляють
SELECT product.name, company.company_name
FROM company_product
JOIN product ON company_product.product_id = product.product_id
JOIN company ON company_product.company_name = company.company_name;
-- 3. Вибрати контракти та компанії, які є постачальниками
SELECT contract.contract_number, contract.contract_date, company.company_name AS supplier
FROM contract
JOIN company ON contract.supplier_company = company.company_name;
-- 4. Вибрати контракти та компанії, які є постачальниками та отримувачами
SELECT contract.contract_number, contract.contract_date, contract.termin, 
       supplier.company_name AS supplier, receiver.company_name AS receiver
FROM contract
JOIN company AS supplier ON contract.supplier_company = supplier.company_name
JOIN company AS receiver ON contract.receiver_company = receiver.company_name;
-- 5. Вибрати власників компаній, у яких відсутнє по батькові
SELECT company.company_name, company_owner.first_name, company_owner.last_name, company_owner.phone_number
FROM company
JOIN company_owner_company ON company.company_name = company_owner_company.company_name
JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id
WHERE company_owner.surname IS NULL;
-- 6. Вибрати всі продукти та їхні контракти, якщо такі є
SELECT product.name, contract.contract_number
FROM product
LEFT JOIN contract ON product.product_id = contract.product_id;

-- Завдання 7
-- 1. Вибір компаній та їхніх власників, де є відповідність у обох таблицях
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
INNER JOIN company_owner_company ON company.company_name = company_owner_company.company_name
INNER JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 2. Вибір всіх компаній і їхніх власників, навіть якщо в таблиці власників немає відповідних даних
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
LEFT JOIN company_owner_company ON company.company_name = company_owner_company.company_name
LEFT JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 3. Вибір всіх власників і компаній, навіть якщо деякі компанії не мають власників
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
RIGHT JOIN company_owner_company ON company.company_name = company_owner_company.company_name
RIGHT JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 4. Вибір всіх компаній і власників, включаючи ті, що не мають відповідності між таблицями
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
FULL JOIN company_owner_company ON company.company_name = company_owner_company.company_name
FULL JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 5. Вибір всіх компаній і продуктів, навіть якщо деякі компанії не мають продуктів
SELECT company.company_name, product.name
FROM company
LEFT JOIN company_product ON company.company_name = company_product.company_name
LEFT JOIN product ON company_product.product_id = product.product_id;

-- Завдання 8
-- 1. Вибір компаній, де сума кількості продуктів більша за середню кількість продуктів по всіх компаніях
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING SUM(company_product.product_quantity) > (SELECT AVG(product_quantity) FROM company_product);
-- 2. Вибір компаній, що мають продукти, що належать такій же компанії, як і компанія з назвою "ТехноКорп"
SELECT company.company_name
FROM company
WHERE company.company_name IN (SELECT company_name FROM company_product
WHERE company_name = (SELECT company_name FROM company WHERE company_name = 'ТехноКорп'));
-- 3. Вибір компаній, що мають більше продуктів, ніж компанія з ID = '1'
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(company_product.product_id) > (SELECT COUNT(product_id) FROM company_product WHERE company_name = 'Company1');
-- 4. Вибір компаній, у яких немає продуктів
SELECT company.company_name
FROM company
LEFT JOIN company_product ON company.company_name = company_product.company_name
WHERE company_product.product_id IS NULL;
-- 5. Вибір компаній, у яких є продукти, кількість яких більше за 50 одиниць
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
WHERE company_product.product_quantity > 50;

-- Завдання 9
-- 1. Вибір компаній та загальної кількості продуктів, де кількість продуктів більша за 50 одиниць
SELECT company.company_name, SUM(company_product.product_quantity) AS total_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING SUM(company_product.product_quantity) > 50;
-- 2. Вибір компаній та кількості продуктів для кожної категорії продуктів, де кількість одиниць продукції більше за 50
SELECT company.company_name, product.type AS product_type, SUM(company_product.product_quantity) AS total_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
GROUP BY company.company_name, product.type
HAVING SUM(company_product.product_quantity) > 50;
-- 3. Вибір компаній, що мають більше одного продукту, і кількості таких продуктів
SELECT company.company_name, COUNT(DISTINCT company_product.product_id) AS num_products
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(DISTINCT company_product.product_id) > 1;
-- 4. Вибір власників компаній, у яких кількість продуктів більше за 50 одиниць
SELECT company_owner.first_name, company_owner.last_name, SUM(company_product.product_quantity) AS total_quantity
FROM company_owner
JOIN company_owner_company ON company_owner.owner_id = company_owner_company.owner_id
JOIN company ON company_owner_company.company_name = company.company_name
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company_owner.first_name, company_owner.last_name
HAVING SUM(company_product.product_quantity) > 50;
-- 5. Вибір типів продуктів, що постачаються більше ніж однією компанією, та кількість таких постачань
SELECT product.type AS product_type, COUNT(DISTINCT company.company_name) AS num_suppliers
FROM product
JOIN company_product ON product.product_id = company_product.product_id
JOIN company ON company_product.company_name = company.company_name
GROUP BY product.type
HAVING COUNT(DISTINCT company.company_name) > 1;

-- Завдання 10
-- 1. Вибір компаній, чия посада має надбавку більше 9000.
SELECT company.company_name
FROM company
WHERE company.company_name IN (
    SELECT company_name 
    FROM company_product
    WHERE product_id IN (SELECT product_id FROM product WHERE price_per_unit > 9000)
);
-- 2. Вибір компаній, які постачають хоча б 1 продукт.
SELECT company.company_name, COUNT(DISTINCT company_product.product_id) AS num_products
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(DISTINCT company_product.product_id) > 0;
-- 3. Вибір компаній, що постачають більше одного продукту.
SELECT company.company_name, COUNT(DISTINCT company_product.product_id) AS num_products
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(DISTINCT company_product.product_id) > 1;
-- 4. Вибір компаній, чия загальна кількість продукції менша за середню кількість продукції у всіх компаніях.
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING SUM(company_product.product_quantity) < (
    SELECT AVG(total_quantity) 
    FROM (
        SELECT SUM(company_product.product_quantity) AS total_quantity
        FROM company_product
        GROUP BY company_product.company_name
    ) AS avg_quantity
);
-- 5. Вибір продуктів, кількість яких більше 2 для кожної компанії.
SELECT company_product.product_id, company.company_name, COUNT(*) AS product_count
FROM company_product
JOIN company ON company_product.company_name = company.company_name
GROUP BY company_product.product_id, company.company_name
HAVING COUNT(*) > 2;;

-- Завдання 11
-- 1. Вибір компаній, у яких є продукти, кількість яких більша за 2 одиниць, і які без по батькові
SELECT company.company_name, company.address, company_product.product_id, company_product.product_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN company_owner_company ON company.company_name = company_owner_company.company_name
JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id
WHERE company_product.product_quantity > 2 
AND company_owner.surname IS NULL;
-- 2. Вибір компаній і продуктів, де ціна за одиницю більше 1000, та продукт належить компанії з назвою "ТехноКорп"
SELECT company.company_name, product.name, product.price_per_unit
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
WHERE product.price_per_unit > 1000 
AND company.company_name = 'ТехноКорп';
-- 3. Вибір компаній, у яких є продукти з кількістю більше за 2 одиниць, та мають контракт з компанією "ТехноКорп"
SELECT company.company_name, company_product.product_id, company_product.product_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN contract ON company.company_name = contract.supplier_company
WHERE company_product.product_quantity > 2
AND contract.supplier_company = 'ТехноКорп';
-- 4. Вибір компаній, що мають продукти з ціною менше 5000 і уклали контракт з компанією, яка є їх постачальником
SELECT company.company_name, product.name, product.price_per_unit
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
JOIN contract ON company.company_name = contract.receiver_company
WHERE product.price_per_unit < 5000 
AND contract.supplier_company = company.company_name;
-- 5. Вибір компаній, де є продукти з кількістю більше 2 одиниць і ціна яких менша за 2000, та їх постачальник — "ТехноКорп"
SELECT company.company_name, product.name, company_product.product_quantity, product.price_per_unit
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
JOIN contract ON company.company_name = contract.receiver_company
WHERE company_product.product_quantity > 2
AND product.price_per_unit < 2000
AND contract.supplier_company = 'ТехноКорп';

-- Завдання 12