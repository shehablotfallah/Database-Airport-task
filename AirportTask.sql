 create database Airport;

 create table TbAirline
 (AirlineId int ,
  AirlineCode int not null,
  AirlineName varchar(20) not null,
  AirLineCountry varchar(50),
  AirlineCreateAt date,
  AirlineUpdateAt date,
  constraint TbAirlinePk primary key (AirlineId));

 
 create table TbAirport
 (AirportId int ,
  AirportName varchar(50) not null,
  AirportCountry varchar(50),
  AirportState varchar(50),
  AirportCity varchar(50) ,
  AirportCreateAt date ,
  AirportUpdateAt date ,
  AirlineId int ,
  constraint TbAirportPk primary key (AirportId) ,
  constraint TbAirlineTbAirportFk foreign key(AirlineId) references TbAirline(AirlineId));


 create table TbEmployers
  (EmployerId int ,
   EmployerName varchar(30) not null,
   EmployerAge int not null,
   phone varchar(20) ,
   email varchar(50) not null,
   EmployerJob varchar(15) not null,
   HireDate datetime,
   Salary numeric(7,2) check (Salary between 4000 and 15000),
   AirportId int ,
   AirlineId int ,
   constraint TbEmployersPk primary key (EmployerId),
   constraint TbAirportTbEmployersFk foreign key(AirportId) references TbAirport(AirportId),
   constraint TbAirlineTbEmployersFk foreign key(AirlineId) references TbAirline(AirlineId));
   
   create table TbAirplane
   (AirplaneId int primary key,
    AirplaneName varchar (20),
	AirplaneCapacity int not null,
	CreateAt date ,
    UpdateAt date ,
    AirportId int,
    AirlineId int ,
	constraint TBAirportTbAirplaneFk foreign key(AirportId) references TbAirport(AirportId),
    constraint TbAirlineTbAirplaneFk foreign key(AirlineId) references TbAirline(AirlineId));


 create table TbFlights
 (FlightNum int ,
  DepartureCity varchar(15) not null,
  DepartureDate date ,
  DepartureTime time ,
  DestinationCity varchar(15) not null,
  ArrivalTime time ,
  ArrivalDate date,
  Capacity int not null,
  AvailableSeats int not null ,
  AirportId int,
  AirlineId int ,
  constraint TBFlightsPk primary key (FlightNum) ,
  constraint TBAirportTbFlightsFk foreign key(AirportId) references TbAirport(AirportId),
  constraint TbAirlineTbFlightsFk foreign key(AirlineId) references TbAirline(AirlineId));
   
   
 create table TbPassengers
 (ConfirmationNum int ,
  PassengerName varchar(30) not null,
  PassengerAddress varchar(50) not null,
  PassengerPhone varchar(20) ,
  PassengerEmail varchar(50) not null,
  FlightNum int ,
  AirportId int,
  constraint TbPassengersConfirmationNumPk primary key (ConfirmationNum),
  constraint TBFlightsTbPassengersFk foreign key(FlightNum) references tBFlights (FlightNum) ,
  constraint TbAirportTbPassengersFk foreign key(AirportId) references TbAirport(AirportId));


 create table TbPayment
 (PaymentCode int primary key,
 PaymentDate datetime,
 paymentTybe varchar(30),
 paymentStutes varchar(30),
 PaymentDetails varchar(50),
 AirportId int,
 constraint TBAirportTbPaymentFk foreign key(AirportId) references TbAirport(AirportId));


 create table TbInvoice
 (InvoiceNum int primary key,
  paymentAmount decimal(7,2) ,
  ConfirmationNum int ,
  PaymentCode int,
  constraint TbPaymentTbInvoiceFk foreign key (PaymentCode) references TbPayment(PaymentCode),
  constraint TbPassengersTbPaymentFk foreign key (ConfirmationNum) references TbPassengers(ConfirmationNum));
  
    
 create table TbBaggage
 (BaggageId int primary key,
  BaggageWeightKg decimal(4,2) not null,
  ConfirmationNum int ,
  constraint TbPassengersTbBaggagesFk foreign key (ConfirmationNum) references TbPassengers(ConfirmationNum));


  create table TbSecurityCheck
  (SecurityCheckId int primary key,
   CheckResult varchar(50)not null,
   CommentCheck varchar(max)not null,
   EmployerId int ,
   ConfirmationNum int ,
   constraint TbEmployersTbSecurityCheckFk foreign key (EmployerId) references TbEmployers (EmployerId),
   constraint TbPassengersTbSecurityCheckFk foreign key (ConfirmationNum) references TbPassengers(ConfirmationNum));



 create table TbTickets
 (TicketID int ,
  SeatClass varchar(10) not null,
  TicketPrice numeric(7,2) not null,
  AirlineId int ,
  AirportId int,
  FlightNum int ,
  ConfirmationNum int ,
  EmployerId int ,
  constraint TbTicketsPk primary key (TicketId),
  constraint TbAirlineTbTbTicketsFk foreign key(AirlineId) references TbAirline(AirlineId),
  constraint TBAirportTbTicketsFk foreign key(AirportId) references TbAirport(AirportId),
  constraint TbFlightsTbTicketsFk foreign key(FlightNum) references TbFlights(FlightNum) ,
  constraint TbPassengersTbTicketsFk foreign key (ConfirmationNum) references TbPassengers(ConfirmationNum),
  constraint TbEmployersTbTicketsFk foreign key(EmployerId) references TbEmployers(EmployerId));


  create table TbStores
(StoreId int ,
 StoreName varchar(20) not null,
 StorePhone varchar(20) ,
 StoreEmail varchar(50) not null,
 AirportId int ,
 EmployerId int ,
 constraint TbStoresPk primary key (StoreId) ,
 constraint TbAirportTbStoresFk foreign key(AirportId) references TbAirport(AirportId) ,
 constraint TbEmployersTbStoresFk foreign key(EmployerId) references TbEmployers(EmployerId));



 create table TbCategories
(CategoryId int ,
 CategoryName varchar (20) not null,
 constraint TbCategoriesPk primary key (CategoryId));



 create table TbOrders
(OrderId int identity,
 OrderStatus varchar(20) not null,
 OrderDateTime datetime,
 StoreId int,
 EmployerId int ,
 CategoryId int ,
 constraint TbOrdersPk primary key(OrderId),
 constraint TbStoresTbOrdersFk foreign key (StoreId) references TbStores(StoreId),
 constraint TbEmployersTbOrdersFk foreign key (EmployerId) references TbEmployers (EmployerId),
 constraint TbCategoriesTbOrdersFk foreign key (CategoryId) references TbCategories (CategoryId));



create table TbProducts
(ProductId int ,
 ProductName varchar(20) not null,
 ProductPrice numeric(7,2),
 CategoryId int,
 AirlineId int ,
 AirportId int,
 constraint TbProductsPk primary key (ProductId),
 constraint TbCategoriesTbProductsFk foreign key (CategoryId) references TbCategories (CategoryId),
 constraint TbAirportTbProductsFk foreign key(AirportId) references TbAirport(AirportId),
 constraint TbAirlineTbProductsFk foreign key(AirlineId) references TbAirline(AirlineId));



