-- COnsultas

/* ---------------------------------------------------------
Pergunta:
Liste todos os clientes cadastrados na oficina.
--------------------------------------------------------- */
SELECT idClient, name, phone FROM client;

/* ---------------------------------------------------------
Pergunta:
Liste todas as ordens de serviço que estão finalizadas.
--------------------------------------------------------- */
SELECT idOrder, entryDate, exitDate, status FROM orderService
	WHERE status = 'Finalizada';

/* ---------------------------------------------------------
Pergunta:
Calcule o valor total gasto com peças em cada ordem de serviço.
--------------------------------------------------------- */
SELECT o.idOrder, SUM(p.unitValue * op.quantity) AS totalPartsValue FROM orderService o
	JOIN orderPart op ON o.idOrder = op.idOrder
	JOIN part p ON op.idPart = p.idPart
	GROUP BY o.idOrder;

/* ---------------------------------------------------------
Pergunta:
Liste os serviços oferecidos pela oficina ordenados do
mais caro para o mais barato.
--------------------------------------------------------- */
SELECT description, baseValue FROM service
	ORDER BY baseValue DESC;

/* ---------------------------------------------------------
Pergunta:
Liste os mecânicos que trabalharam mais de 3 horas no total
em ordens de serviço.
--------------------------------------------------------- */
SELECT m.name AS mechanicName, SUM(om.hoursWorked) AS totalHoursWorked FROM mechanic m
	JOIN orderMechanic om ON m.idMechanic = om.idMechanic
	GROUP BY m.idMechanic, m.name
	HAVING SUM(om.hoursWorked) > 3;

/* ---------------------------------------------------------
Pergunta:
Liste o nome do cliente, o modelo do veículo e o status
da ordem de serviço.
--------------------------------------------------------- */
SELECT c.name AS clientName, v.model AS vehicleModel, o.status AS orderStatus FROM orderService o
	JOIN vehicle v ON o.idVehicle = v.idVehicle
	JOIN client c ON v.idClient = c.idClient;

/* ---------------------------------------------------------
Pergunta:
Liste os clientes e seus veículos apenas para ordens de
serviço que estejam em andamento, ordenadas pelo nome do cliente.
--------------------------------------------------------- */
SELECT c.name AS clientName, v.model AS vehicleModel, o.status FROM orderService o
	JOIN vehicle v ON o.idVehicle = v.idVehicle
	JOIN client c ON v.idClient = c.idClient
	WHERE o.status = 'Em andamento'
	ORDER BY c.name;

/* ---------------------------------------------------------
Pergunta:
Calcule o valor total estimado de cada ordem de serviço,
considerando serviços e peças utilizadas.
--------------------------------------------------------- */
SELECT o.idOrder, SUM(s.baseValue * osi.quantity) + SUM(p.unitValue * op.quantity) AS totalOrderValue FROM orderService o
	LEFT JOIN orderServiceItem osi ON o.idOrder = osi.idOrder
	LEFT JOIN service s ON osi.idService = s.idService
	LEFT JOIN orderPart op ON o.idOrder = op.idOrder
	LEFT JOIN part p ON op.idPart = p.idPart
	GROUP BY o.idOrder;

/* ---------------------------------------------------------
Pergunta:
Liste os clientes que possuem mais de uma ordem de serviço
registrada na oficina.
--------------------------------------------------------- */
SELECT c.name AS clientName, COUNT(o.idOrder) AS totalOrders FROM client c
	JOIN vehicle v ON c.idClient = v.idClient
	JOIN orderService o ON v.idVehicle = o.idVehicle
	GROUP BY c.idClient, c.name
	HAVING COUNT(o.idOrder) > 1;