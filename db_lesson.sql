
-- Q1 テーブル追加
CREATE TABLE departments(
  department_id INT UNSIGNED PRIMARY KEY COMMENT '部署ID',
  name VARCHAR(20) NOT NULL COMMENT '部署名',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
) COMMENT '部署';

DESC departments;

-- Q2 カラム追加
ALTER TABLE people ADD department_id INT UNSIGNED COMMENT '部署ID' AFTER email;

DESC people;

-- Q3 レコード追加
INSERT INTO departments (department_id, name)
VALUES
  (1,'営業'),
  (2,'開発'),
  (3,'経理'),
  (4,'人事'),
  (5,'情報システム');

INSERT INTO people (name,email,department_id,age,gender)
VALUES
  ('営業A', 'eigyoua@gizumo.jp',1,25,1),
  ('営業B', 'eigyoub@gizumo.jp',1,31,1),
  ('営業C', 'eigyouc@gizumo.jp',1,42,2),
  ('開発A','kaihatua@gizumo.jp',2,29,1),
  ('開発B','kaihatub@gizumo.jp',2,35,1),
  ('開発C','kaihatuc@gizumo.jp',2,21,2),
  ('開発D','kaihatud@gizumo.jp',2,23,2),
  ('経理A',  'keiria@gizumo.jp',3,33,1),
  ('人事A',  'zinzia@gizumo.jp',4,26,2),
  ('情報A','zyouhoua@gizumo.jp',5,45,1);

INSERT INTO reports (person_id,content)
VALUES
  ( 7,"営業日報Aが書いた"),
  ( 8,"営業日報Bが書いた"),
  ( 9,"営業日報Cが書いた"),
  (10,"開発日報Aが書いた"),
  (11,"開発日報Bが書いた"),
  (12,"開発日報C 不具合報告"),
  (13,"開発日報D 不具合報告"),
  (14,"経理日報 経費"),
  (15,"エントリー書類確認"),
  (16,"セキュリティ管理報告");

-- Q4 レコード更新
UPDATE people SET department_id = 1 WHERE person_id = 1;
UPDATE people SET department_id = 2 WHERE person_id = 2;
UPDATE people SET department_id = 3 WHERE person_id = 3;
UPDATE people SET department_id = 4 WHERE person_id = 4;
UPDATE people SET department_id = 5 WHERE person_id = 6;

-- Q5 年齢の降順で男性の名前と年齢を取得
SELECT name, age FROM people WHERE gender = 1 ORDER BY age DESC;

-- Q6 下記のSQL文を日本語で説明
SELECT
  `name`, `email`, `age`
FROM
  `people`
WHERE
  `department_id` = 1
ORDER BY
  `created_at`;

/* 
 *`people`テーブルにあるレコードのうち、`department_id`の値が 1 のレコードである、
 *  `name`, `email`, `age`の３つのカラムを取得する。
 */

-- Q7 20代の女性と40代の男性の名前一覧を取得
  SELECT
    name
  FROM people
  WHERE
    (age BETWEEN 20 AND 29)
    AND gender = 2
  OR
    (age BETWEEN 40 AND 49)
    AND gender = 1;

-- Q8 営業部に所属する人だけを年齢の昇順で取得
SELECT * FROM people WHERE department_id = 1 ORDER BY age ASC;

-- Q9 開発部に所属している女性の平均年齢を取得
SELECT AVG(age) AS average_age FROM people WHERE department_id = 2 AND gender = 2;

-- Q10 名前と部署名とその人が提出した日報の内容を同時に取得
SELECT
  p.name,
  d.name,
  r.content
FROM
  people p
  INNER JOIN departments d ON d.department_id = p.department_id
  INNER JOIN reports r ON r.person_id = p.person_id
ORDER BY
  p.person_id ASC;

-- Q10 名前と部署名とその人が提出した日報の内容を同時に取得
SELECT
  p.name,
  d.name,
  r.content
FROM
  people p
  INNER JOIN departments d ON d.department_id = p.department_id
  INNER JOIN reports r ON r.person_id = p.person_id
ORDER BY
  p.person_id ASC;

-- Q11 日報を一つも提出していない人の名前一覧を取得
SELECT
  p.name
FROM
  people p
  LEFT JOIN reports r ON r.person_id = p.person_id
WHERE
  r. person_id IS NULL;