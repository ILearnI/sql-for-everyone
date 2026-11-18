# Datasets

The course uses two practice databases. The SQL that creates and fills them is inside the setup folders
([`00_setup/brewhouse-setup/init`](../00_setup/brewhouse-setup/init) and [`00_setup/streamly-setup/init`](../00_setup/streamly-setup/init));
this folder describes them and holds the CSV files used by the import lessons.

| Dataset | Chapters | What it is |
|---|---|---|
| **Brewhouse** | 1 to 13 | An online coffee shop: customers, products, orders, order items and employees, plus a few practice tables. About 500 customers and 5,000 orders over two years. |
| **Streamly** | 14 to 20 | A video-streaming service: about 10,000 users, subscriptions, payments and 250,000 viewing events, plus a deliberately messy contacts table. |

The data is generated and fictional.

CSV files: [`new_customers.csv`](new_customers.csv) (Brewhouse), [`contacts_raw.csv`](contacts_raw.csv) (Streamly).

## Brewhouse tables

Used from chapter 1.

### `customers`

| Column | Type | Notes |
|---|---|---|
| `customer_id` | int | primary key |
| `first_name` | text | required |
| `last_name` | text | required |
| `email` | text |  |
| `city` | text |  |
| `country` | text |  |
| `signup_date` | date | required |

### `products`

| Column | Type | Notes |
|---|---|---|
| `product_id` | int | primary key |
| `name` | text | required |
| `category` | text | required |
| `price` | numeric(7,2) | required |
| `cost` | numeric(7,2) | required |
| `is_active` | boolean | required |
| `attributes` | jsonb |  |

### `orders`

| Column | Type | Notes |
|---|---|---|
| `order_id` | int | primary key |
| `customer_id` | int | foreign key to customers, required |
| `order_date` | timestamp | required |
| `status` | text | required |
| `channel` | text | required |

### `order_items`

| Column | Type | Notes |
|---|---|---|
| `order_item_id` | int | primary key |
| `order_id` | int | foreign key to orders, required |
| `product_id` | int | foreign key to products, required |
| `quantity` | int | required |
| `unit_price` | numeric(7,2) | required |

### `employees`

| Column | Type | Notes |
|---|---|---|
| `employee_id` | int | primary key |
| `first_name` | text | required |
| `last_name` | text | required |
| `role` | text | required |
| `department` | text | required |
| `salary` | int | required |
| `hire_date` | date | required |
| `manager_id` | int | foreign key to employees |

### `price_bands`

| Column | Type | Notes |
|---|---|---|
| `band_id` | int | primary key |
| `band_name` | text | required |
| `min_price` | numeric | required |
| `max_price` | numeric | required |

### `product_stock`

| Column | Type | Notes |
|---|---|---|
| `product_id` | int | primary key, foreign key to products |
| `quantity` | int | required |

### `staging_stock`

| Column | Type | Notes |
|---|---|---|
| `product_id` | int |  |
| `quantity` | int |  |

### `loyalty_accounts`

| Column | Type | Notes |
|---|---|---|
| `customer_id` | int | primary key, foreign key to customers |
| `points` | int | required |

### `customer_imports`

| Column | Type | Notes |
|---|---|---|
| `import_id` | int | primary key |
| `email` | text |  |
| `first_name` | text |  |
| `last_name` | text |  |
| `city` | text |  |

### `orders_flat`

| Column | Type | Notes |
|---|---|---|
| `order_id` | int |  |
| `order_date` | date |  |
| `customer_name` | text |  |
| `customer_email` | text |  |
| `product_name` | text |  |
| `category` | text |  |
| `price` | numeric(7,2) |  |
| `quantity` | int |  |

### `events_log`

| Column | Type | Notes |
|---|---|---|
| `event_id` | int | primary key |
| `logged_at` | timestamp | required |
| `customer_id` | int |  |
| `page` | text | required |
| `session_token` | text | required |


## Streamly tables

Used from chapter 14.

### `plans`

| Column | Type | Notes |
|---|---|---|
| `plan_id` | int | primary key |
| `name` | text | required |
| `monthly_price` | numeric(6,2) | required |

### `users`

| Column | Type | Notes |
|---|---|---|
| `user_id` | int | primary key |
| `email` | text |  |
| `country` | text | required |
| `signup_date` | date | required |
| `channel` | text | required |

### `visits`

| Column | Type | Notes |
|---|---|---|
| `visit_id` | int | primary key |
| `visited_at` | timestamp | required |
| `channel` | text | required |
| `user_id` | int | foreign key to users |

### `subscriptions`

| Column | Type | Notes |
|---|---|---|
| `subscription_id` | int | primary key |
| `user_id` | int | foreign key to users, required |
| `plan_id` | int | foreign key to plans, required |
| `start_date` | date | required |
| `end_date` | date |  |

### `payments`

| Column | Type | Notes |
|---|---|---|
| `payment_id` | int | primary key |
| `subscription_id` | int | foreign key to subscriptions, required |
| `paid_at` | timestamp | required |
| `amount` | numeric(8,2) |  |
| `status` | text | required |

### `titles`

| Column | Type | Notes |
|---|---|---|
| `title_id` | int | primary key |
| `title` | text | required |
| `genre` | text | required |
| `release_year` | int | required |

### `events`

| Column | Type | Notes |
|---|---|---|
| `event_id` | int | primary key |
| `user_id` | int | foreign key to users, required |
| `event_type` | text | required |
| `title_id` | int | foreign key to titles |
| `occurred_at` | timestamp | required |

### `support_tickets`

| Column | Type | Notes |
|---|---|---|
| `ticket_id` | int | primary key |
| `user_id` | int | foreign key to users, required |
| `opened_at` | timestamp | required |
| `closed_at` | timestamp |  |
| `category` | text | required |

### `contacts_raw`

| Column | Type | Notes |
|---|---|---|
| `contact_id` | int | primary key |
| `full_name` | text |  |
| `email` | text |  |
| `phone` | text |  |
| `country` | text |  |
| `signup_date` | text |  |
| `plan` | text |  |
| `notes` | text |  |

