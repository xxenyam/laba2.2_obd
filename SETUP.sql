-- Таблиця: company_owner

CREATE TABLE company_owner (
    owner_id INT PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    surname NVARCHAR(50) NULL,
    address NVARCHAR(100) NULL,
    phone_number NVARCHAR(20) NOT NULL
);

-- Таблиця: company

CREATE TABLE company (
    company_name NVARCHAR(100) PRIMARY KEY,
    address NVARCHAR(100) NULL
);

-- Таблиця: company_owner_company

CREATE TABLE company_owner_company (
    owner_id INT NOT NULL,
    company_name NVARCHAR(100) NOT NULL,
    PRIMARY KEY (owner_id, company_name),
    FOREIGN KEY (owner_id) REFERENCES company_owner(owner_id),
    FOREIGN KEY (company_name) REFERENCES company(company_name)
);

-- Таблиця: product

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    type NVARCHAR(50) NOT NULL,
    price_per_unit MONEY NOT NULL
);

-- Таблиця: company_product

CREATE TABLE company_product (
    company_name NVARCHAR(100) NOT NULL,
    product_id INT NOT NULL,
    product_quantity INT NOT NULL,
    PRIMARY KEY (company_name, product_id),
    FOREIGN KEY (company_name) REFERENCES company(company_name),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Таблиця: contract

CREATE TABLE contract (
    contract_number INT PRIMARY KEY,
    contract_date DATE NOT NULL,
    product_id INT NOT NULL,
    termin DATE NOT NULL,
    supplier_company NVARCHAR(100) NOT NULL,
    receiver_company NVARCHAR(100) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (supplier_company) REFERENCES company(company_name),
FOREIGN KEY (receiver_company) REFERENCES company(company_name)
);