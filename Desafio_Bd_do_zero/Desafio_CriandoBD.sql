create database oficina;
use oficina;

drop database oficina;

create table client(
    idClient int auto_increment primary key,
    name varchar(100) not null,
    phone varchar(15)
);

create table vehicle(
    idVehicle int auto_increment primary key,
    plate char(7) not null unique,
    model varchar(50),
    brand varchar(50),
    year int,
    idClient int,
    foreign key (idClient) references client(idClient)
);

create table mechanic(
    idMechanic int auto_increment primary key,
    name varchar(100),
    specialty varchar(50)
);

create table service(
    idService int auto_increment primary key,
    description varchar(100),
    baseValue float
);

create table part(
    idPart int auto_increment primary key,
    description varchar(100),
    unitValue float
);

create table orderService(
    idOrder int auto_increment primary key,
    entryDate date,
    exitDate date,
    status enum('Aberta', 'Em andamento', 'Finalizada'),
    idVehicle int,
    foreign key (idVehicle) references vehicle(idVehicle)
);

create table payment(
    idPayment int auto_increment primary key,
    paymentType enum('Dinheiro', 'Cartão', 'Pix'),
    totalValue float,
    idOrder int,
    foreign key (idOrder) references orderService(idOrder)
);

create table orderMechanic(
    idOrder int,
    idMechanic int,
    hoursWorked int,
    primary key (idOrder, idMechanic),
    foreign key (idOrder) references orderService(idOrder),
    foreign key (idMechanic) references mechanic(idMechanic)
);

create table orderServiceItem(
    idOrder int,
    idService int,
    quantity int,
    primary key (idOrder, idService),
    foreign key (idOrder) references orderService(idOrder),
    foreign key (idService) references service(idService)
);

create table orderPart(
    idOrder int,
    idPart int,
    quantity int,
    primary key (idOrder, idPart),
    foreign key (idOrder) references orderService(idOrder),
    foreign key (idPart) references part(idPart)
);
