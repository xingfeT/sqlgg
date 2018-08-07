SELECT strftime('%s','now');
CREATE TABLE test (x INT, `key` VARBINARY(200));
SELECT * FROM test WHERE x IS NOT NULL;
CREATE INDEX `key` ON test(`key`(20));
SELECT avg(x) FROM test;
SELECT count(*) FROM test;
SELECT x FROM test WHERE ? >= `key` ORDER BY `key` DESC LIMIT 1;
SELECT x FROM test WHERE `key` < ?;

CREATE TABLE appointments (alert_at DATETIME);
INSERT INTO `appointments` (
  `alert_at`
) VALUES (
  NOW() + INTERVAL @delay SECOND
);
SELECT SUM(CASE WHEN x > 10 THEN 1 ELSE 0 END) FROM test;
-- delete from txn_ranges
-- where id in (@tr1_id, @tr2_id)
--   and not exists (select 1 from workareas where txn_range_id = txn_ranges.id)

CREATE TABLE issue14 (x integer);
INSERT INTO issue14 (x) VALUES (@x);
INSERT INTO issue14 SET x = @x;
INSERT INTO issue14 (x) SELECT @x;

INSERT INTO test VALUES (20, 'twenty') ON DUPLICATE KEY UPDATE x = x + ?;
INSERT INTO test VALUES (20, 'twenty') ON DUPLICATE KEY UPDATE x = VALUES(x) + ?;
INSERT INTO test VALUES (20, $$twenty$$);
INSERT INTO test VALUES (200,
$$twenty
times
ten$$);

SELECT $function$
BEGIN
    RETURN ($1 ~ $q$[\t\r\n\v\\]$q$);
END;
$function$;

INSERT INTO `test` (`x`, `key`) VALUES
(1, 'one'),
(2, 'two'),
(3, 'three');

INSERT INTO test VALUES
(1, 'one'),
(2, 'two'),
(3, 'three');

-- @issue47
SELECT count(*) > 0 FROM test;
SELECT count(*) * avg(x) FROM test;

-- @issue45
INSERT INTO test VALUES
(1, @one),
(2, @two),
(3, @one);

INSERT INTO `appointments` ( `alert_at`) VALUES (@alert);
INSERT INTO `appointments` ( `alert_at`) VALUES (FROM_UNIXTIME(@alert));

-- @count_x
SELECT COUNT(x) FROM test;

-- @count_distinct
SELECT COUNT(DISTINCT x), SUM(DISTINCT x) FROM test;
