CREATE TABLE customer
  (
     customer_id   SERIAL,
     NAME          VARCHAR(128),
     phone_number  PHONE UNIQUE,
     email_id      EMAIL UNIQUE,
     date_of_birth DATE,
     address       VARCHAR(512),
     PRIMARY KEY(customer_id)
  );

CREATE TABLE employee
  (
     employee_id      SERIAL,
     NAME             VARCHAR(128),
     phone_number     PHONE UNIQUE,
     email_id         EMAIL UNIQUE,
     date_of_birth    DATE,
     address          VARCHAR(512),
     user_id          VARCHAR(512),
     password         VARCHAR(512),
     role             VARCHAR(128) CHECK(role IN ('Manager', 'Cashier')),
     joining_date     DATE,
     termination_date DATE,
     PRIMARY KEY(employee_id)
  );

CREATE TABLE product
  (
     product_id         SERIAL,
     NAME               VARCHAR(128),
     type               VARCHAR(128),
     description        VARCHAR(2048),
     manufacturer       VARCHAR(256),
     manufacturing_date DATE,
     expiry_date        DATE,
     quantity           INT,
     PRIMARY KEY(product_id)
  );

CREATE TABLE invoice
  (
     invoice_id     SERIAL,
     invoice_number VARCHAR(64),
     customer_id    BIGINT,
     employee_id    BIGINT,
     total_price    MONEY,
     tax            MONEY,
     discount       MONEY,
     final_price    MONEY,
     status         VARCHAR(16) CHECK(status IN ('open', 'close')),
     PRIMARY KEY(invoice_id),
     FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
     FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
  )

CREATE TABLE invoice_items
  (
     invoice_item_id SERIAL,
     invoice_id      BIGINT,
     product_id      BIGINT,
     quantity        INT,
     unit_price      MONEY,
     discount        MONEY,
     total_price     MONEY,
     PRIMARY KEY(invoice_item_id),
     FOREIGN KEY(invoice_id) REFERENCES invoice(invoice_id),
     FOREIGN KEY(product_id) REFERENCES product(product_id)
  )

CREATE TABLE payments
  (
     id           SERIAL,
     amount       MONEY,
     reference_id VARCHAR(128),
     payment_type VARCHAR(64) CHECK(payment_type IN ('payment', 'refund')),
     paid_with    VARCHAR(64) CHECK(paid_with IN ('cash', 'giftcard', 'credit',
     'debit')
     ),
     invoice_id   BIGINT,
     last4        NUMERIC(4, 0),
     expiry_month NUMERIC(2, 0),
     expirty_year NUMERIC(4, 0),
     PRIMARY KEY(id),
     FOREIGN KEY(invoice_id) REFERENCES invoice(invoice_id)
  ) 