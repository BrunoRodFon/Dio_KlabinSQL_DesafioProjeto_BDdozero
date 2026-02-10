-- Inserindo dados

insert into client (name, phone) values
('João Silva', '11999999999'),
('Maria Souza', '21988888888');

insert into vehicle (plate, model, brand, year, idClient) values
('ABC1234', 'Gol', 'VW', 2015, 1),
('XYZ5678', 'Civic', 'Honda', 2020, 2);

insert into mechanic (name, specialty) values
('Carlos', 'Motor'),
('Paulo', 'Suspensão');

insert into service (description, baseValue) values
('Troca de óleo', 150),
('Alinhamento', 120);

insert into part (description, unitValue) values
('Filtro de óleo', 50),
('Amortecedor', 300);

insert into orderService (entryDate, status, idVehicle) values
('2026-02-01', 'Em andamento', 1),
('2026-02-02', 'Finalizada', 2);

insert into orderServiceItem values
(1, 1, 1),
(2, 2, 1);

insert into orderPart values
(1, 1, 1),
(2, 2, 2);

insert into orderMechanic values
(1, 1, 3),
(2, 2, 4);

insert into payment (paymentType, totalValue, idOrder) values
('Pix', 200, 1),
('Cartão', 720, 2);
