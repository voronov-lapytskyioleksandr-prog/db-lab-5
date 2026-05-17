-- 1. Створення таблиці категорій для усунення транзитивної залежності (3NF)
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 2. Створення фінальної таблиці страв (3NF)
CREATE TABLE dish (
    dish_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category_id INTEGER REFERENCES category(category_id)
);

-- 3. Модифікація старих даних (імітація ALTER TABLE для зв'язування)
-- Додаємо зовнішній ключ до нашої нормалізованої таблиці страв
ALTER TABLE dish 
ADD CONSTRAINT fk_dish_category 
FOREIGN KEY (category_id) REFERENCES category(category_id);

-- 4. Створення таблиць замовлень (вже в 3NF)
CREATE TABLE restaurant_order (
    order_id SERIAL PRIMARY KEY,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    table_number INTEGER NOT NULL
);

CREATE TABLE order_item (
    order_id INTEGER REFERENCES restaurant_order(order_id),
    dish_id INTEGER REFERENCES dish(dish_id),
    quantity INTEGER NOT NULL,
    PRIMARY KEY (order_id, dish_id)
);

-- 5. Видалення початкової ненормалізованої таблиці
-- DROP TABLE legacy_orders_data;