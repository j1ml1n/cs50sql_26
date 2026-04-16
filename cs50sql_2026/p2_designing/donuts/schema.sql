CREATE TABLE "ingredients" (
    "id" INTEGER PRIMARY KEY,
    "ingredient" TEXT NOT NULL,
    "unit" TEXT NOT NULL,
    "price_per_unit" REAL NOT NULL -- price per unit
);


CREATE TABLE "donuts" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "gluten_free" TEXT CHECK ("gluten_free" in ('yes', 'no')),
    "price_per_donut" REAL NOT NULL,
    "recipes_id" INTEGER NOT NULL,
    FOREIGN KEY ("recipes_id") REFERENCES "recipes"("id")
);


CREATE TABLE "orders" (
    "id" INTEGER PRIMARY KEY, -- could be used as order number
    "customer_id" INTEGER NOT NULL,
    "donut_id" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "price_total" REAL NOT NULL,
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id"),
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id")
);


CREATE TABLE "customers" (
    "id" INTEGER PRIMARY KEY,
    "order_id" INTEGER NOT NULL,
    "first_name" TEXT,
    "second_name" TEXT,
    FOREIGN KEY ("order_id") REFERENCES "orders"("id")
);


CREATE TABLE "recipes" (
    -- used to look up the ingredients of each donutvia query
    "id" INTEGER PRIMARY KEY,
    "ingredient_id" INTEGER NOT NULL,
    "donut_id" INTEGER NOT NULL,
    "unit" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY ("ingredient_id") REFERENCES "ingredient"("id")
);
