CREATE TYPE role AS ENUM ('ADMIN', 'SELLER', 'CUSTOMER');

CREATE TABLE users(
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL DEFAULT('Guest'),
    username VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role role NOT NULL
);

CREATE TABLE categories(
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL
);

CREATE TABLE products(
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    current_value DECIMAL(10,2) NOT NULL,
    category_id BIGINT,

    FOREIGN KEY (category_id)
            REFERENCES categories(id)
);

CREATE TABLE orders(
    id BIGSERIAL PRIMARY KEY,
    seller_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    total_price DECIMAL(10,2),

    FOREIGN KEY (seller_id)
            REFERENCES users(id),
    FOREIGN KEY (customer_id)
            REFERENCES users(id),

    CONSTRAINT seller_not_customer CHECK(seller_id <> customer_id)
);

CREATE TABLE order_items(
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2),

    FOREIGN KEY (order_id)
            REFERENCES orders(id),
    FOREIGN KEY (product_id)
            REFERENCES products(id),

    CONSTRAINT quantity_greater_than_zero CHECK (quantity > 0)
);

