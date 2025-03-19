-- Çàâäàííÿ 4  
-- 1. Ïîøóê âëàñíèê³â êîìïàí³é áåç ïî áàòüêîâ³
SELECT * 
FROM company_owner
WHERE surname IS NULL;
-- 2. Ïîøóê êîìïàí³é, ó íàçâ³ ÿêèõ º ñëîâî "Áóä"
SELECT * 
FROM company
WHERE company_name LIKE '%Áóä%'
-- 3. Âèá³ðêà êîìïàí³é ç ³äåíòèô³êàòîðîì âëàñíèêà á³ëüøå 50
SELECT * 
FROM company_owner_company
WHERE owner_id > 50;
-- 4. Ïîøóê åëåêòðîí³êè ç ö³íîþ ìåíøå àáî ð³âíîþ 10 000
SELECT * 
FROM product
WHERE type = 'Åëåêòðîí³êà' AND price_per_unit <= 10000;
-- 5. Ïîøóê ïðîäóêò³â ç ê³ëüê³ñòþ á³ëüøå 50 îäèíèöü
SELECT * 
FROM company_product
WHERE product_quantity > 50;
-- 6. Ïîøóê ê³ëüêîñò³ êîíòðàêò³â äëÿ êîæíîãî ïîñòà÷àëüíèêà ó âèçíà÷åíèé ïåð³îä
SELECT supplier_company, COUNT(*) AS contract_count
FROM contract
WHERE contract_date BETWEEN '2024-01-01' AND '2025-06-30'
GROUP BY supplier_company;

-- Çàâäàííÿ 5
-- 1. Âèáðàòè âñ³õ âëàñíèê³â êîìïàí³é, ó ÿêèõ º ïî áàòüêîâ³ òà òåëåôîí íå ïî÷èíàºòüñÿ ç '050'
SELECT * 
FROM company_owner
WHERE surname IS NOT NULL AND phone_number NOT LIKE '050%';
-- 2. Âèáðàòè âñ³ êîìïàí³¿, ó ÿêèõ ó íàçâ³ º ñëîâî "Òîðã" àáî "Áóä"
SELECT * 
FROM company
WHERE company_name LIKE '%Òîðã%' OR company_name LIKE '%Áóä%';
-- 3. Âèáðàòè âñ³ çâ’ÿçêè ì³æ âëàñíèêàìè òà êîìïàí³ÿìè, äå âëàñíèê ìàº ID á³ëüøå 40, àëå íå 45 ³ íå 50
SELECT * 
FROM company_owner_company
WHERE owner_id > 40 AND owner_id NOT IN (45, 50);
-- 4. Âèáðàòè âñ³ òîâàðè òèïó "Ïîáóòîâà òåõí³êà", ÿê³ êîøòóþòü â³ä 5000 äî 20000
SELECT * 
FROM product
WHERE type = 'Ïîáóòîâà òåõí³êà' AND price_per_unit BETWEEN 5000 AND 20000;
-- 5. Âèáðàòè âñ³ òîâàðè, äå ê³ëüê³ñòü íà ñêëàä³ àáî á³ëüøå 100, àáî ö³íà íèæ÷à çà 5000
SELECT * 
FROM company_product
WHERE product_quantity >= 100;
-- 6. Âèáðàòè êîìïàí³¿, ÿê³ ìàþòü á³ëüøå í³æ 5 óêëàäåíèõ êîíòðàêò³â, àëå íå º ïîñòà÷àëüíèêàìè 'ÒÎÂ Àëüôà'
SELECT supplier_company, COUNT(*) AS contract_count
FROM contract
WHERE supplier_company != 'ÒÎÂ Àëüôà'
GROUP BY supplier_company
HAVING COUNT(*) > 5;

-- Çàâäàííÿ 6
-- 1. Âèáðàòè âëàñíèê³â êîìïàí³é, ó ÿêèõ ïð³çâèùå ïî÷èíàºòüñÿ íà "Ïåò"
SELECT * 
FROM company_owner
WHERE last_name LIKE 'Ïåò%';
-- 2. Âèáðàòè êîìïàí³¿, íàçâà ÿêèõ ì³ñòèòü ñëîâî "Åêî"
SELECT * 
FROM company
WHERE company_name LIKE '%Åêî%';
-- 3. Âèáðàòè ïðîäóêòè, ó íàçâ³ ÿêèõ º ñëîâî "Ïðî"
SELECT * 
FROM product
WHERE name LIKE '%Ïðî%';
-- 4. Âèáðàòè äîãîâîðè, íîìåð ÿêèõ ïî÷èíàºòüñÿ ç "2024-"
SELECT * 
FROM contract
WHERE contract_date LIKE '2024-%';
-- 5. Âèáðàòè êîìïàí³¿, ó ÿêèõ àäðåñà ïî÷èíàºòüñÿ ç "âóë. Öåíòðàëüíà"
SELECT * 
FROM company
WHERE address LIKE 'âóë. Öåíòðàëüíà%';
-- 6. Âèáðàòè êîíòðàêòè, íîìåð ÿêèõ çàê³í÷óºòüñÿ íà "01"
SELECT * 
FROM contract
WHERE contract_number LIKE '%01';

-- Çàâäàííÿ 7
-- 1. Âèáðàòè êîìïàí³¿ òà ¿õí³õ âëàñíèê³â
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
JOIN company_owner_company ON company.company_name = company_owner_company.company_name
JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 2. Âèáðàòè ïðîäóêòè òà êîìïàí³¿, ÿê³ ¿õ âèðîáëÿþòü
SELECT product.name, company.company_name
FROM company_product
JOIN product ON company_product.product_id = product.product_id
JOIN company ON company_product.company_name = company.company_name;
-- 3. Âèáðàòè êîíòðàêòè òà êîìïàí³¿, ÿê³ º ïîñòà÷àëüíèêàìè
SELECT contract.contract_number, contract.contract_date, company.company_name AS supplier
FROM contract
JOIN company ON contract.supplier_company = company.company_name;
-- 4. Âèáðàòè êîíòðàêòè òà êîìïàí³¿, ÿê³ º ïîñòà÷àëüíèêàìè òà îòðèìóâà÷àìè
SELECT contract.contract_number, contract.contract_date, contract.termin, 
       supplier.company_name AS supplier, receiver.company_name AS receiver
FROM contract
JOIN company AS supplier ON contract.supplier_company = supplier.company_name
JOIN company AS receiver ON contract.receiver_company = receiver.company_name;
-- 5. Âèáðàòè âëàñíèê³â êîìïàí³é, ó ÿêèõ â³äñóòíº ïî áàòüêîâ³
SELECT company.company_name, company_owner.first_name, company_owner.last_name, company_owner.phone_number
FROM company
JOIN company_owner_company ON company.company_name = company_owner_company.company_name
JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id
WHERE company_owner.surname IS NULL;
-- 6. Âèáðàòè âñ³ ïðîäóêòè òà ¿õí³ êîíòðàêòè, ÿêùî òàê³ º
SELECT product.name, contract.contract_number
FROM product
LEFT JOIN contract ON product.product_id = contract.product_id;

-- Çàâäàííÿ 8
-- 1. Âèá³ð êîìïàí³é òà ¿õí³õ âëàñíèê³â, äå º â³äïîâ³äí³ñòü ó îáîõ òàáëèöÿõ
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
INNER JOIN company_owner_company ON company.company_name = company_owner_company.company_name
INNER JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 2. Âèá³ð âñ³õ êîìïàí³é ³ ¿õí³õ âëàñíèê³â, íàâ³òü ÿêùî â òàáëèö³ âëàñíèê³â íåìàº â³äïîâ³äíèõ äàíèõ
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
LEFT JOIN company_owner_company ON company.company_name = company_owner_company.company_name
LEFT JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 3. Âèá³ð âñ³õ âëàñíèê³â ³ êîìïàí³é, íàâ³òü ÿêùî äåÿê³ êîìïàí³¿ íå ìàþòü âëàñíèê³â
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
RIGHT JOIN company_owner_company ON company.company_name = company_owner_company.company_name
RIGHT JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 4. Âèá³ð âñ³õ êîìïàí³é ³ âëàñíèê³â, âêëþ÷àþ÷è ò³, ùî íå ìàþòü â³äïîâ³äíîñò³ ì³æ òàáëèöÿìè
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
FULL JOIN company_owner_company ON company.company_name = company_owner_company.company_name
FULL JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 5. Âèá³ð âñ³õ êîìïàí³é ³ ïðîäóêò³â, íàâ³òü ÿêùî äåÿê³ êîìïàí³¿ íå ìàþòü ïðîäóêò³â
SELECT company.company_name, product.name
FROM company
LEFT JOIN company_product ON company.company_name = company_product.company_name
LEFT JOIN product ON company_product.product_id = product.product_id;

-- Çàâäàííÿ 9
-- 1. Âèá³ð êîìïàí³é, äå ñóìà ê³ëüêîñò³ ïðîäóêò³â á³ëüøà çà ñåðåäíþ ê³ëüê³ñòü ïðîäóêò³â ïî âñ³õ êîìïàí³ÿõ
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING SUM(company_product.product_quantity) > (SELECT AVG(product_quantity) FROM company_product);
-- 2. Âèá³ð êîìïàí³é, ùî ìàþòü ïðîäóêòè, ùî íàëåæàòü òàê³é æå êîìïàí³¿, ÿê ³ êîìïàí³ÿ ç íàçâîþ "ÒåõíîÊîðï"
SELECT company.company_name
FROM company
WHERE company.company_name IN (SELECT company_name FROM company_product
WHERE company_name = (SELECT company_name FROM company WHERE company_name = 'ÒåõíîÊîðï'));
-- 3. Âèá³ð êîìïàí³é, ùî ìàþòü á³ëüøå ïðîäóêò³â, í³æ êîìïàí³ÿ ç ID = '1'
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(company_product.product_id) > (SELECT COUNT(product_id) FROM company_product WHERE company_name = 'Company1');
-- 4. Âèá³ð êîìïàí³é, ó ÿêèõ íåìàº ïðîäóêò³â
SELECT company.company_name
FROM company
LEFT JOIN company_product ON company.company_name = company_product.company_name
WHERE company_product.product_id IS NULL;
-- 5. Âèá³ð êîìïàí³é, ó ÿêèõ º ïðîäóêòè, ê³ëüê³ñòü ÿêèõ á³ëüøå çà 50 îäèíèöü
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
WHERE company_product.product_quantity > 50;

-- Çàâäàííÿ 10
-- 1. Âèá³ð êîìïàí³é òà çàãàëüíî¿ ê³ëüêîñò³ ïðîäóêò³â, äå ê³ëüê³ñòü ïðîäóêò³â á³ëüøà çà 50 îäèíèöü
SELECT company.company_name, SUM(company_product.product_quantity) AS total_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING SUM(company_product.product_quantity) > 50;
-- 2. Âèá³ð êîìïàí³é òà ê³ëüêîñò³ ïðîäóêò³â äëÿ êîæíî¿ êàòåãîð³¿ ïðîäóêò³â, äå ê³ëüê³ñòü îäèíèöü ïðîäóêö³¿ á³ëüøå çà 50
SELECT company.company_name, product.type AS product_type, SUM(company_product.product_quantity) AS total_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
GROUP BY company.company_name, product.type
HAVING SUM(company_product.product_quantity) > 50;
-- 3. Âèá³ð êîìïàí³é, ùî ìàþòü á³ëüøå îäíîãî ïðîäóêòó, ³ ê³ëüêîñò³ òàêèõ ïðîäóêò³â
SELECT company.company_name, COUNT(DISTINCT company_product.product_id) AS num_products
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(DISTINCT company_product.product_id) > 1;
-- 4. Âèá³ð âëàñíèê³â êîìïàí³é, ó ÿêèõ ê³ëüê³ñòü ïðîäóêò³â á³ëüøå çà 50 îäèíèöü
SELECT company_owner.first_name, company_owner.last_name, SUM(company_product.product_quantity) AS total_quantity
FROM company_owner
JOIN company_owner_company ON company_owner.owner_id = company_owner_company.owner_id
JOIN company ON company_owner_company.company_name = company.company_name
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company_owner.first_name, company_owner.last_name
HAVING SUM(company_product.product_quantity) > 50;
-- 5. Âèá³ð òèï³â ïðîäóêò³â, ùî ïîñòà÷àþòüñÿ á³ëüøå í³æ îäí³ºþ êîìïàí³ºþ, òà ê³ëüê³ñòü òàêèõ ïîñòà÷àíü
SELECT product.type AS product_type, COUNT(DISTINCT company.company_name) AS num_suppliers
FROM product
JOIN company_product ON product.product_id = company_product.product_id
JOIN company ON company_product.company_name = company.company_name
GROUP BY product.type
HAVING COUNT(DISTINCT company.company_name) > 1;

-- Çàâäàííÿ 11
-- 1. Âèá³ð êîìïàí³é, ÷èÿ ïîñàäà ìàº íàäáàâêó á³ëüøå 9000.
SELECT company.company_name
FROM company
WHERE company.company_name IN (
    SELECT company_name 
    FROM company_product
    WHERE product_id IN (SELECT product_id FROM product WHERE price_per_unit > 9000)
);
-- 2. Âèá³ð êîìïàí³é, ÿê³ ïîñòà÷àþòü õî÷à á 1 ïðîäóêò.
SELECT company.company_name, COUNT(DISTINCT company_product.product_id) AS num_products
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(DISTINCT company_product.product_id) > 0;
-- 3. Âèá³ð êîìïàí³é, ùî ïîñòà÷àþòü á³ëüøå îäíîãî ïðîäóêòó.
SELECT company.company_name, COUNT(DISTINCT company_product.product_id) AS num_products
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(DISTINCT company_product.product_id) > 1;
-- 4. Âèá³ð êîìïàí³é, ÷èÿ çàãàëüíà ê³ëüê³ñòü ïðîäóêö³¿ ìåíøà çà ñåðåäíþ ê³ëüê³ñòü ïðîäóêö³¿ ó âñ³õ êîìïàí³ÿõ.
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
-- 5. Âèá³ð ïðîäóêò³â, ê³ëüê³ñòü ÿêèõ á³ëüøå 2 äëÿ êîæíî¿ êîìïàí³¿.
SELECT company_product.product_id, company.company_name, COUNT(*) AS product_count
FROM company_product
JOIN company ON company_product.company_name = company.company_name
GROUP BY company_product.product_id, company.company_name
HAVING COUNT(*) > 2;;

-- Çàâäàííÿ 12
-- 1. Âèá³ð êîìïàí³é, ó ÿêèõ º ïðîäóêòè, ê³ëüê³ñòü ÿêèõ á³ëüøà çà 2 îäèíèöü, ³ ÿê³ áåç ïî áàòüêîâ³
SELECT company.company_name, company.address, company_product.product_id, company_product.product_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN company_owner_company ON company.company_name = company_owner_company.company_name
JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id
WHERE company_product.product_quantity > 2 
AND company_owner.surname IS NULL;
-- 2. Âèá³ð êîìïàí³é ³ ïðîäóêò³â, äå ö³íà çà îäèíèöþ á³ëüøå 1000, òà ïðîäóêò íàëåæèòü êîìïàí³¿ ç íàçâîþ "ÒåõíîÊîðï"
SELECT company.company_name, product.name, product.price_per_unit
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
WHERE product.price_per_unit > 1000 
AND company.company_name = 'ÒåõíîÊîðï';
-- 3. Âèá³ð êîìïàí³é, ó ÿêèõ º ïðîäóêòè ç ê³ëüê³ñòþ á³ëüøå çà 2 îäèíèöü, òà ìàþòü êîíòðàêò ç êîìïàí³ºþ "ÒåõíîÊîðï"
SELECT company.company_name, company_product.product_id, company_product.product_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN contract ON company.company_name = contract.supplier_company
WHERE company_product.product_quantity > 2
AND contract.supplier_company = 'ÒåõíîÊîðï';
-- 4. Âèá³ð êîìïàí³é, ùî ìàþòü ïðîäóêòè ç ö³íîþ ìåíøå 5000 ³ óêëàëè êîíòðàêò ç êîìïàí³ºþ, ÿêà º ¿õ ïîñòà÷àëüíèêîì
SELECT company.company_name, product.name, product.price_per_unit
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
JOIN contract ON company.company_name = contract.receiver_company
WHERE product.price_per_unit < 5000 
AND contract.supplier_company = company.company_name;
-- 5. Âèá³ð êîìïàí³é, äå º ïðîäóêòè ç ê³ëüê³ñòþ á³ëüøå 2 îäèíèöü ³ ö³íà ÿêèõ ìåíøà çà 2000, òà ¿õ ïîñòà÷àëüíèê — "ÒåõíîÊîðï"
SELECT company.company_name, product.name, company_product.product_quantity, product.price_per_unit
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
JOIN contract ON company.company_name = contract.receiver_company
WHERE company_product.product_quantity > 2
AND product.price_per_unit < 2000
AND contract.supplier_company = 'ÒåõíîÊîðï';
