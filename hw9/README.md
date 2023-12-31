# Домашнее задание 9. Хранимые процедуры

В базе данных <code>Airlines</code> информация о рейсах самолётов задана в виде таблиц

<pre>    Flights(
        FlightId integer, 
        FlightTime timestamp, 
        PlaneId integer,
        -- Дополнительные столбцы, при необходимости
    )
    Seats(
        PlaneId integer,
        SeatNo varchar(4), -- 123A
        -- Дополнительные столбцы, при необходимости
    )
</pre>

Реализуйте запросы к базе данных <code>Airline</code> с применением представлений, хранимых процедур и функций. При необходимости, вы можете создать дополнительные таблицы, представления и хранимые процедуры.

Возможность бронирования должна автоматически отключаться за трое суток до начала рейса. Продажа мест должна автоматически отключаться за три часа до начала рейса. Также должна быть предусмотрена возможность отключения бронирования и продаж вручную.

1. <code>FreeSeats(FlightId)</code> — список мест, доступных для продажи и для бронирования.
1. <code>Reserve(UserId, Pass, FlightId, SeatNo)</code> — пытается забронировать место на трое суток начиная с момента бронирования. Возвращает <em>истину</em>, если удалось и <em>ложь</em> — в противном случае.
1. <code>ExtendReservation(UserId, Pass, FlightId, SeatNo)</code> — пытается продлить бронь места на трое суток начиная с момента продления. Возвращает <em>истину</em>, если удалось и <em>ложь</em> — в противном случае.
1. <code>BuyFree(FlightId, SeatNo)</code> — пытается купить свободное место. Возвращает <em>истину</em>, если удалось и <em>ложь</em> — в противном случае.
1. <code>BuyReserved(UserId, Pass, FlightId, SeatNo)</code> — пытается выкупить забронированное место (пользователи должны совпадать). Возвращает <em>истину</em>, если удалось и <em>ложь</em> — в противном случае.
1. <code>FlightsStatistics(UserId, Pass)</code> — статистика по рейсам: возможность бронирования и покупки, число свободных, забронированных и проданных мест.
1. <code>FlightStat(UserId, Pass, FlightId)</code> — статистика по рейсу: возможность бронирования и покупки, число свободных, забронированных и проданных мест.
1. <code>CompressSeats(FlightId)</code> — оптимизирует занятость мест в самолете. В результате оптимизации, в начале самолета должны быть купленные места, затем — забронированные, а в конце — свободные. Примечание: клиенты, которые уже выкупили билеты также должны быть пересажены.

В рамках проекта:

1. Определите хранимые процедуры и функции, необходимые для работы проекта.
2. Реализуйте хранимые процедуры (функции) на языке SQL.
