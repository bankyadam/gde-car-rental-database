CREATE TABLE IF NOT EXISTS invoice_items
(
    id             SERIAL,
    invoice_id     INTEGER NOT NULL,
    description    TEXT    NOT NULL,
    unit_net_price INTEGER NOT NULL,
    quantity       INTEGER NOT NULL,
    CONSTRAINT invoice_items_pk PRIMARY KEY (id),
    CONSTRAINT invoice_items_invoice_id___invoices_id FOREIGN KEY (invoice_id) REFERENCES invoices
);

