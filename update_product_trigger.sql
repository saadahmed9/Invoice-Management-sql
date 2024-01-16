CREATE FUNCTION update_product_quantity() RETURNS TRIGGER AS $$
BEGIN
  UPDATE product SET quantity = product.quantity - invoice_items.quantity 
  FROM invoice_items
  WHERE invoice_items.product_id = product.product_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_product_quantity_trigger
AFTER INSERT ON invoice_items
FOR EACH ROW
EXECUTE FUNCTION update_product_quantity();








DROP FUNCTION update_product_quantity();
DROP TRIGGER update_product_quantity_trigger on invoice_items;