CREATE OR REPLACE FUNCTION increment(i INT) RETURNS INT AS $$
BEGIN
    RETURN i + 1;
END;
$$ LANGUAGE plpgsql;

SELECT increment(2);