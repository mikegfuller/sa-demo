WITH stg_tpch_orders AS (
  SELECT
    ORDER_KEY,
    CUSTOMER_KEY,
    STATUS_CODE,
    TOTAL_PRICE,
    ORDER_DATE,
    PRIORITY_CODE,
    CLERK_NAME,
    SHIP_PRIORITY,
    COMMENT
  FROM {{ ref('stg_tpch_orders') }}
), order_items AS (
  SELECT
    ORDER_KEY,
    CUSTOMER_KEY,
    PART_KEY,
    SUPPLIER_KEY,
    ORDER_DATE,
    ORDER_STATUS_CODE,
    IS_RETURN,
    LINE_NUMBER,
    ORDER_ITEM_STATUS_CODE,
    SHIP_DATE,
    COMMIT_DATE,
    RECEIPT_DATE,
    SHIP_MODE,
    EXTENDED_PRICE,
    QUANTITY,
    BASE_PRICE,
    DISCOUNT_PERCENTAGE,
    DISCOUNTED_PRICE,
    GROSS_ITEM_SALES_AMOUNT,
    DISCOUNTED_ITEM_SALES_AMOUNT,
    ITEM_DISCOUNT_AMOUNT,
    TAX_RATE,
    ITEM_TAX_AMOUNT,
    NET_ITEM_SALES_AMOUNT
  FROM {{ ref('order_items') }}
), formula_1 AS (
  SELECT
    ORDER_KEY,
    CUSTOMER_KEY,
    PART_KEY,
    SUPPLIER_KEY,
    ORDER_DATE,
    ORDER_STATUS_CODE,
    IS_RETURN,
    LINE_NUMBER,
    ORDER_ITEM_STATUS_CODE,
    SHIP_DATE,
    COMMIT_DATE,
    RECEIPT_DATE,
    SHIP_MODE,
    EXTENDED_PRICE,
    QUANTITY,
    BASE_PRICE,
    DISCOUNT_PERCENTAGE,
    DISCOUNTED_PRICE,
    GROSS_ITEM_SALES_AMOUNT,
    DISCOUNTED_ITEM_SALES_AMOUNT,
    ITEM_DISCOUNT_AMOUNT,
    TAX_RATE,
    ITEM_TAX_AMOUNT,
    NET_ITEM_SALES_AMOUNT,
    is_return = TRUE AS agg__7484e0da_675f_4b44_bde1_4d773136a71f
  FROM order_items
), aggregate_1 AS (
  SELECT
    order_key AS order_key,
    SUM(gross_item_sales_amount) AS gross_item_sales_amount,
    SUM(item_discount_amount) AS item_discount_amount,
    SUM(item_tax_amount) AS item_tax_amount,
    SUM(net_item_sales_amount) AS net_item_sales_amount,
    COUNT_IF(agg__7484e0da_675f_4b44_bde1_4d773136a71f) AS return_count
  FROM formula_1
  GROUP BY
    1
), join_1 AS (
  SELECT
    stg_tpch_orders.ORDER_KEY,
    stg_tpch_orders.CUSTOMER_KEY,
    stg_tpch_orders.STATUS_CODE,
    stg_tpch_orders.TOTAL_PRICE,
    stg_tpch_orders.ORDER_DATE,
    stg_tpch_orders.PRIORITY_CODE,
    stg_tpch_orders.CLERK_NAME,
    stg_tpch_orders.SHIP_PRIORITY,
    stg_tpch_orders.COMMENT,
    aggregate_1.order_key AS order_key_1,
    aggregate_1.gross_item_sales_amount,
    aggregate_1.item_discount_amount,
    aggregate_1.item_tax_amount,
    aggregate_1.net_item_sales_amount,
    aggregate_1.agg__7484e0da_675f_4b44_bde1_4d773136a71f
  FROM stg_tpch_orders
  JOIN aggregate_1
    ON stg_tpch_orders.ORDER_KEY = aggregate_1.order_key
), formula_2 AS (
  SELECT
    total_price,
    net_item_sales_amount,
    gross_item_sales_amount,
    item_discount_amount,
    priority_code,
    order_key,
    order_key_1,
    comment,
    customer_key,
    status_code,
    agg__7484e0da_675f_4b44_bde1_4d773136a71f,
    clerk_name,
    ship_priority,
    order_date,
    item_tax_amount,
    1 AS order_count
  FROM join_1
), order_1 AS (
  SELECT
    *
  FROM formula_2
  ORDER BY
    order_date
)
SELECT
  *
FROM order_1