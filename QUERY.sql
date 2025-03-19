-- �������� 3 
-- 1. ����� �������� ������� ��� �� �������
SELECT * 
FROM company_owner
WHERE surname IS NULL;
-- 2. ����� �������, � ���� ���� � ����� "���"
SELECT * 
FROM company
WHERE company_name LIKE '%���%'
-- 3. ������ ������� � ��������������� �������� ����� 50
SELECT * 
FROM company_owner_company
WHERE owner_id > 50;
-- 4. ����� ���������� � ����� ����� ��� ����� 10 000
SELECT * 
FROM product
WHERE type = '����������' AND price_per_unit <= 10000;
-- 5. ����� �������� � ������� ����� 50 �������
SELECT * 
FROM company_product
WHERE product_quantity > 50;
-- 6. ����� ������� ��������� ��� ������� ������������� � ���������� �����
SELECT supplier_company, COUNT(*) AS contract_count
FROM contract
WHERE contract_date BETWEEN '2024-01-01' AND '2025-06-30'
GROUP BY supplier_company;

-- �������� 4
-- 1. ������� ��� �������� �������, � ���� � �� ������� �� ������� �� ���������� � '050'
SELECT * 
FROM company_owner
WHERE surname IS NOT NULL AND phone_number NOT LIKE '050%';
-- 2. ������� �� ������, � ���� � ���� � ����� "����" ��� "���"
SELECT * 
FROM company
WHERE company_name LIKE '%����%' OR company_name LIKE '%���%';
-- 3. ������� �� ������ �� ���������� �� ���������, �� ������� �� ID ����� 40, ��� �� 45 � �� 50
SELECT * 
FROM company_owner_company
WHERE owner_id > 40 AND owner_id NOT IN (45, 50);
-- 4. ������� �� ������ ���� "�������� ������", �� �������� �� 5000 �� 20000
SELECT * 
FROM product
WHERE type = '�������� ������' AND price_per_unit BETWEEN 5000 AND 20000;
-- 5. ������� �� ������, �� ������� �� ����� ��� ����� 100, ��� ���� ����� �� 5000
SELECT * 
FROM company_product
WHERE product_quantity >= 100;
-- 6. ������� ������, �� ����� ����� �� 5 ��������� ���������, ��� �� � ��������������� '��� �����'
SELECT supplier_company, COUNT(*) AS contract_count
FROM contract
WHERE supplier_company != '��� �����'
GROUP BY supplier_company
HAVING COUNT(*) > 5;

-- �������� 5
-- 1. ������� �������� �������, � ���� ������� ���������� �� "���"
SELECT * 
FROM company_owner
WHERE last_name LIKE '���%';
-- 2. ������� ������, ����� ���� ������ ����� "���"
SELECT * 
FROM company
WHERE company_name LIKE '%���%';
-- 3. ������� ��������, � ���� ���� � ����� "���"
SELECT * 
FROM product
WHERE name LIKE '%���%';
-- 4. ������� ��������, ����� ���� ���������� � "2024-"
SELECT * 
FROM contract
WHERE contract_date LIKE '2024-%';
-- 5. ������� ������, � ���� ������ ���������� � "���. ����������"
SELECT * 
FROM company
WHERE address LIKE '���. ����������%';
-- 6. ������� ���������, ����� ���� ���������� �� "01"
SELECT * 
FROM contract
WHERE contract_number LIKE '%01';

-- �������� 6
-- 1. ������� ������ �� ���� ��������
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
JOIN company_owner_company ON company.company_name = company_owner_company.company_name
JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 2. ������� �������� �� ������, �� �� ����������
SELECT product.name, company.company_name
FROM company_product
JOIN product ON company_product.product_id = product.product_id
JOIN company ON company_product.company_name = company.company_name;
-- 3. ������� ��������� �� ������, �� � ���������������
SELECT contract.contract_number, contract.contract_date, company.company_name AS supplier
FROM contract
JOIN company ON contract.supplier_company = company.company_name;
-- 4. ������� ��������� �� ������, �� � ��������������� �� ������������
SELECT contract.contract_number, contract.contract_date, contract.termin, 
       supplier.company_name AS supplier, receiver.company_name AS receiver
FROM contract
JOIN company AS supplier ON contract.supplier_company = supplier.company_name
JOIN company AS receiver ON contract.receiver_company = receiver.company_name;
-- 5. ������� �������� �������, � ���� ������ �� �������
SELECT company.company_name, company_owner.first_name, company_owner.last_name, company_owner.phone_number
FROM company
JOIN company_owner_company ON company.company_name = company_owner_company.company_name
JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id
WHERE company_owner.surname IS NULL;
-- 6. ������� �� �������� �� ��� ���������, ���� ��� �
SELECT product.name, contract.contract_number
FROM product
LEFT JOIN contract ON product.product_id = contract.product_id;

-- �������� 7
-- 1. ���� ������� �� ���� ��������, �� � ���������� � ���� ��������
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
INNER JOIN company_owner_company ON company.company_name = company_owner_company.company_name
INNER JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 2. ���� ��� ������� � ���� ��������, ����� ���� � ������� �������� ���� ��������� �����
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
LEFT JOIN company_owner_company ON company.company_name = company_owner_company.company_name
LEFT JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 3. ���� ��� �������� � �������, ����� ���� ���� ������ �� ����� ��������
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
RIGHT JOIN company_owner_company ON company.company_name = company_owner_company.company_name
RIGHT JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 4. ���� ��� ������� � ��������, ��������� �, �� �� ����� ���������� �� ���������
SELECT company.company_name, company_owner.first_name, company_owner.last_name
FROM company
FULL JOIN company_owner_company ON company.company_name = company_owner_company.company_name
FULL JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id;
-- 5. ���� ��� ������� � ��������, ����� ���� ���� ������ �� ����� ��������
SELECT company.company_name, product.name
FROM company
LEFT JOIN company_product ON company.company_name = company_product.company_name
LEFT JOIN product ON company_product.product_id = product.product_id;

-- �������� 8
-- 1. ���� �������, �� ���� ������� �������� ����� �� ������� ������� �������� �� ��� ��������
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING SUM(company_product.product_quantity) > (SELECT AVG(product_quantity) FROM company_product);
-- 2. ���� �������, �� ����� ��������, �� �������� ���� �� ������, �� � ������� � ������ "���������"
SELECT company.company_name
FROM company
WHERE company.company_name IN (SELECT company_name FROM company_product
WHERE company_name = (SELECT company_name FROM company WHERE company_name = '���������'));
-- 3. ���� �������, �� ����� ����� ��������, �� ������� � ID = '1'
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(company_product.product_id) > (SELECT COUNT(product_id) FROM company_product WHERE company_name = 'Company1');
-- 4. ���� �������, � ���� ���� ��������
SELECT company.company_name
FROM company
LEFT JOIN company_product ON company.company_name = company_product.company_name
WHERE company_product.product_id IS NULL;
-- 5. ���� �������, � ���� � ��������, ������� ���� ����� �� 50 �������
SELECT company.company_name
FROM company
JOIN company_product ON company.company_name = company_product.company_name
WHERE company_product.product_quantity > 50;

-- �������� 9
-- 1. ���� ������� �� �������� ������� ��������, �� ������� �������� ����� �� 50 �������
SELECT company.company_name, SUM(company_product.product_quantity) AS total_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING SUM(company_product.product_quantity) > 50;
-- 2. ���� ������� �� ������� �������� ��� ����� ������� ��������, �� ������� ������� ��������� ����� �� 50
SELECT company.company_name, product.type AS product_type, SUM(company_product.product_quantity) AS total_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
GROUP BY company.company_name, product.type
HAVING SUM(company_product.product_quantity) > 50;
-- 3. ���� �������, �� ����� ����� ������ ��������, � ������� ����� ��������
SELECT company.company_name, COUNT(DISTINCT company_product.product_id) AS num_products
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(DISTINCT company_product.product_id) > 1;
-- 4. ���� �������� �������, � ���� ������� �������� ����� �� 50 �������
SELECT company_owner.first_name, company_owner.last_name, SUM(company_product.product_quantity) AS total_quantity
FROM company_owner
JOIN company_owner_company ON company_owner.owner_id = company_owner_company.owner_id
JOIN company ON company_owner_company.company_name = company.company_name
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company_owner.first_name, company_owner.last_name
HAVING SUM(company_product.product_quantity) > 50;
-- 5. ���� ���� ��������, �� ������������ ����� �� ���� �������, �� ������� ����� ���������
SELECT product.type AS product_type, COUNT(DISTINCT company.company_name) AS num_suppliers
FROM product
JOIN company_product ON product.product_id = company_product.product_id
JOIN company ON company_product.company_name = company.company_name
GROUP BY product.type
HAVING COUNT(DISTINCT company.company_name) > 1;

-- �������� 10
-- 1. ���� �������, ��� ������ �� �������� ����� 9000.
SELECT company.company_name
FROM company
WHERE company.company_name IN (
    SELECT company_name 
    FROM company_product
    WHERE product_id IN (SELECT product_id FROM product WHERE price_per_unit > 9000)
);
-- 2. ���� �������, �� ���������� ���� � 1 �������.
SELECT company.company_name, COUNT(DISTINCT company_product.product_id) AS num_products
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(DISTINCT company_product.product_id) > 0;
-- 3. ���� �������, �� ���������� ����� ������ ��������.
SELECT company.company_name, COUNT(DISTINCT company_product.product_id) AS num_products
FROM company
JOIN company_product ON company.company_name = company_product.company_name
GROUP BY company.company_name
HAVING COUNT(DISTINCT company_product.product_id) > 1;
-- 4. ���� �������, ��� �������� ������� ��������� ����� �� ������� ������� ��������� � ��� ��������.
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
-- 5. ���� ��������, ������� ���� ����� 2 ��� ����� ������.
SELECT company_product.product_id, company.company_name, COUNT(*) AS product_count
FROM company_product
JOIN company ON company_product.company_name = company.company_name
GROUP BY company_product.product_id, company.company_name
HAVING COUNT(*) > 2;;

-- �������� 11
-- 1. ���� �������, � ���� � ��������, ������� ���� ����� �� 2 �������, � �� ��� �� �������
SELECT company.company_name, company.address, company_product.product_id, company_product.product_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN company_owner_company ON company.company_name = company_owner_company.company_name
JOIN company_owner ON company_owner_company.owner_id = company_owner.owner_id
WHERE company_product.product_quantity > 2 
AND company_owner.surname IS NULL;
-- 2. ���� ������� � ��������, �� ���� �� ������� ����� 1000, �� ������� �������� ������ � ������ "���������"
SELECT company.company_name, product.name, product.price_per_unit
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
WHERE product.price_per_unit > 1000 
AND company.company_name = '���������';
-- 3. ���� �������, � ���� � �������� � ������� ����� �� 2 �������, �� ����� �������� � ������� "���������"
SELECT company.company_name, company_product.product_id, company_product.product_quantity
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN contract ON company.company_name = contract.supplier_company
WHERE company_product.product_quantity > 2
AND contract.supplier_company = '���������';
-- 4. ���� �������, �� ����� �������� � ����� ����� 5000 � ������ �������� � �������, ��� � �� ��������������
SELECT company.company_name, product.name, product.price_per_unit
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
JOIN contract ON company.company_name = contract.receiver_company
WHERE product.price_per_unit < 5000 
AND contract.supplier_company = company.company_name;
-- 5. ���� �������, �� � �������� � ������� ����� 2 ������� � ���� ���� ����� �� 2000, �� �� ������������ � "���������"
SELECT company.company_name, product.name, company_product.product_quantity, product.price_per_unit
FROM company
JOIN company_product ON company.company_name = company_product.company_name
JOIN product ON company_product.product_id = product.product_id
JOIN contract ON company.company_name = contract.receiver_company
WHERE company_product.product_quantity > 2
AND product.price_per_unit < 2000
AND contract.supplier_company = '���������';

-- �������� 12