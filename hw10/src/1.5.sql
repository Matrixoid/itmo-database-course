-- Аномалия "Косая запись" - не проблема, т.к. пишем в одну таблицу
-- Аномалия "Фантомная запись" - не проблема, т.к. новые записи, не
-- мешают нам, работаем с одной записью
-- Аномалия "Неповторяемое чтение" - проблема, можем посчитать, что
-- место забронированно, а при update'e окажется что оно куплено.
-- Аномалия "Грязное чтение" read uncommitted не подходит для записи
START TRANSACTION READ ONLY ISOLATION LEVEL REPEATABLE READ;