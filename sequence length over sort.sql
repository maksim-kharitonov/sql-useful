-- вывод длины непрерывной последовательности по заданной сортировке
create global temporary table tmp_tourroomprice
(
  dat                   date,
  price                 number
)
on commit preserve rows
/
insert into tmp_tourroomprice (dat,price) values(to_date('03.05.2016','dd.mm.yyyy'),76.24)
/
insert into tmp_tourroomprice (dat,price) values(to_date('04.05.2016','dd.mm.yyyy'),76.24)
/
insert into tmp_tourroomprice (dat,price) values(to_date('05.05.2016','dd.mm.yyyy'),91.42)
/
insert into tmp_tourroomprice (dat,price) values(to_date('06.05.2016','dd.mm.yyyy'),76.24)
/

insert into tmp_tourroomprice (dat,price) values(to_date('07.05.2016','dd.mm.yyyy'),76.24)
/
insert into tmp_tourroomprice (dat,price) values(to_date('08.05.2016','dd.mm.yyyy'),76.24)
/
insert into tmp_tourroomprice (dat,price) values(to_date('09.05.2016','dd.mm.yyyy'),91.42)
/
-- разность двух комулятивных каунтов дает некомулятивный каунт, если сортировка у них совпадает
-- по этому числу можем группировать для подсчета длины последовательности
SELECT price, dat, count(*) OVER(PARTITION BY price, grp_num) AS v
  FROM (SELECT dat,
              price,
              ROW_NUMBER() OVER(ORDER BY dat),
              ROW_NUMBER() OVER(PARTITION BY price ORDER BY dat),
              ROW_NUMBER() OVER(ORDER BY dat) - ROW_NUMBER() OVER(PARTITION BY price ORDER BY dat) AS grp_num
         FROM tmp_tourroomprice)
        ORDER BY dat