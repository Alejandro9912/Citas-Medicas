ALTER TABLE Afiliado DROP CONSTRAINT FK_Afiliado_Categoria
;
ALTER TABLE Afiliado DROP CONSTRAINT FK_Afiliado_Usuario
;
ALTER TABLE Agenda DROP CONSTRAINT FK_Agendar_Medico
;
ALTER TABLE Agenda DROP CONSTRAINT FK_Agendar_Tipo_cita
;
ALTER TABLE Cita DROP CONSTRAINT FK_Cita_Agenda
;
ALTER TABLE Cita DROP CONSTRAINT FK_Cita_Afiliado
;
ALTER TABLE Cita DROP CONSTRAINT FK_Cita_Multa
;
ALTER TABLE Consultorio DROP CONSTRAINT FK_Consultorio_Sede
;
ALTER TABLE Medico DROP CONSTRAINT FK_Medico_Consultorio
;
ALTER TABLE Medico DROP CONSTRAINT FK_Medico_Especialidad
;
ALTER TABLE Medico DROP CONSTRAINT FK_Medico_Usuario
;

DROP TABLE Afiliado
;
DROP TABLE Agenda
;
DROP TABLE Categoria
;
DROP TABLE Cita
;
DROP TABLE Consultorio
;
DROP TABLE Especialidad
;
DROP TABLE Medico
;
DROP TABLE Multa
;
DROP TABLE Sede
;
DROP TABLE Tipo_cita
;
DROP TABLE Usuario
;

CREATE TABLE Afiliado ( 
	k_identificacion numeric(9) NOT NULL,
	parentezco varchar(20),
	k_identificacion_afiliado numeric(9),
	i_estado varchar(10) NOT NULL,
	i_estado_multa varchar(10) NOT NULL,
	k_id_categoria numeric(2) NOT NULL
)
;

CREATE TABLE Agenda ( 
	k_id_agenda numeric(9) NOT NULL,
	i_estado varchar(10) NOT NULL,
	fecha date NOT NULL,
	h_inicio time(0) NOT NULL,
	h_fin time(0) NOT NULL,
	k_identificacion numeric(9),
	k_id_tipo numeric(9)
)
;

CREATE TABLE Categoria ( 
	k_id_categoria numeric(2) NOT NULL,
	v_copago numeric(7,2) NOT NULL,
	v_multa numeric(7,2) NOT NULL
)
;

CREATE TABLE Cita ( 
	f_cita date NOT NULL,
	k_id_cita numeric(9) NOT NULL,
	i_estado varchar(20) NOT NULL,
	prescripcion varchar(255),
	diagnostico varchar(255),
	k_id_agenda numeric(9) NOT NULL,
	k_identificacion numeric(9),
	k_id_multa numeric(9) NOT NULL
)
;

CREATE TABLE Consultorio ( 
	k_id_consultirio integer NOT NULL,
	i_tipo varchar(50) NOT NULL,
	descrip_equipo varchar(255) NOT NULL,
	k_id_sede varchar(20) NOT NULL
)
;

CREATE TABLE Especialidad ( 
	k_codigo integer NOT NULL,
	n_nombre varchar(20) NOT NULL
)
;

CREATE TABLE Medico ( 
	i_tiene_agenda boolean NOT NULL,
	k_identificacion numeric(9) NOT NULL,
	franja varchar(30),
	k_codigo_especiali integer,
	k_id_consultirio integer
)
;

CREATE TABLE Multa ( 
	i_estado varchar(10) NOT NULL,
	v_multa numeric(7,3) NOT NULL,
	k_id_multa numeric(9) NOT NULL
)
;

CREATE TABLE Sede ( 
	k_id_sede varchar(20) NOT NULL,
	direccion varchar(30) NOT NULL,
	telefono numeric(7) NOT NULL
)
;

CREATE TABLE Tipo_cita ( 
	k_id_tipo numeric(9) NOT NULL,
	duracion integer NOT NULL
)
;

CREATE TABLE Usuario ( 
	k_identificacion numeric(9) NOT NULL,
	i_tipo_document varchar(20) NOT NULL,
	contrasea varchar(30) NOT NULL,
	eMail varchar(30) NOT NULL,
	q_tel_fijo integer NOT NULL,
	q_tel_cel varchar(50),
	i_sexo varchar(1) NOT NULL,
	n_persona varchar(60) NOT NULL,
	f_nacimiento date NOT NULL
)
;


ALTER TABLE Afiliado ADD CONSTRAINT PK_Afiliado 
	PRIMARY KEY (k_identificacion)
;


ALTER TABLE Agenda ADD CONSTRAINT PK_Agenda 
	PRIMARY KEY (k_id_agenda)
;


ALTER TABLE Categoria ADD CONSTRAINT PK_Categoria 
	PRIMARY KEY (k_id_categoria)
;


ALTER TABLE Cita ADD CONSTRAINT PK_Cita 
	PRIMARY KEY (k_id_cita)
;


ALTER TABLE Consultorio ADD CONSTRAINT PK_Consultorio 
	PRIMARY KEY (k_id_consultirio)
;


ALTER TABLE Especialidad ADD CONSTRAINT PK_Especialidad 
	PRIMARY KEY (k_codigo)
;


ALTER TABLE Medico ADD CONSTRAINT PK_Medico 
	PRIMARY KEY (k_identificacion)
;


ALTER TABLE Multa ADD CONSTRAINT PK_Multa 
	PRIMARY KEY (k_id_multa)
;


ALTER TABLE Sede ADD CONSTRAINT PK_Sede 
	PRIMARY KEY (k_id_sede)
;


ALTER TABLE Tipo_cita ADD CONSTRAINT PK_Tipo_cita 
	PRIMARY KEY (k_id_tipo)
;


ALTER TABLE Usuario ADD CONSTRAINT PK_Usuario 
	PRIMARY KEY (k_identificacion)
;



CREATE INDEX IXFK_Afiliado_Categoria
ON Afiliado (k_id_categoria)
;
ALTER TABLE Afiliado
ADD CONSTRAINT i_estado CHECK (i_estado IN( 'Inactivo', 'Activo',  'Retirado'))
;
ALTER TABLE Afiliado
ADD CONSTRAINT i_estado_multa CHECK (i_estado_multa IN('Multado','Sin multa'))
;
CREATE INDEX IXFK_Agenda_Medico
ON Agenda (k_identificacion)
;
CREATE INDEX IXFK_Agenda_Tipo_cita
ON Agenda (k_id_tipo)
;
ALTER TABLE Categoria
ADD CONSTRAINT v_multa CHECK ((v_multa >0))
;
ALTER TABLE Categoria
ADD CONSTRAINT v_copago CHECK (v_copago>0)
;
CREATE INDEX IXFK_Cita_Afiliado
ON Cita (k_identificacion)
;
CREATE INDEX IXFK_Cita_Agendar
ON Cita (k_id_agenda)
;
CREATE INDEX IXFK_Cita_Multa
ON Cita (k_id_multa)
;
ALTER TABLE Cita
ADD CONSTRAINT i_estado CHECK (i_estado IN('Cancelada','Cumplida','Incumplida'))
;
CREATE INDEX IXFK_Consultorio_Sede
ON Consultorio (k_id_sede)
;
ALTER TABLE Consultorio
ADD CONSTRAINT i_tipo CHECK (i_tipo IN('Medicina general','Pediatría','Ofrtalmologia','Odontología'))
;
CREATE INDEX IXFK_Medico_Consultorio
ON Medico (k_id_consultirio)
;
CREATE INDEX IXFK_Medico_Especialidad
ON Medico (k_codigo_especiali)
;
CREATE INDEX IXFK_Medico_Usuario
ON Medico (k_identificacion)
;
ALTER TABLE Medico
ADD CONSTRAINT franja CHECK (franja IN('Mañana','Tarde'))
;
ALTER TABLE Multa
ADD CONSTRAINT i_estado CHECK (i_estado IN('multado','sin multa'))
;
ALTER TABLE Tipo_cita
ADD CONSTRAINT duracion CHECK (duracion>0)
;
ALTER TABLE Usuario
ADD CONSTRAINT i_tipo_document CHECK (i_tipo_document
IN('Cedula de
Ciudadania',
'Tarjeta de
Identidad', 'NIT')
)
;
ALTER TABLE Usuario
ADD CONSTRAINT i_sexo CHECK (i_sexo
IN('M','F'))
;


ALTER TABLE Afiliado ADD CONSTRAINT FK_Afiliado_Categoria 
	FOREIGN KEY (k_id_categoria) REFERENCES Categoria (k_id_categoria)
ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Afiliado ADD CONSTRAINT FK_Afiliado_Usuario 
	FOREIGN KEY (k_identificacion) REFERENCES Usuario (k_identificacion)
ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Agenda ADD CONSTRAINT FK_Agendar_Medico 
	FOREIGN KEY (k_identificacion) REFERENCES Medico (k_identificacion)
ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Agenda ADD CONSTRAINT FK_Agendar_Tipo_cita 
	FOREIGN KEY (k_id_tipo) REFERENCES Tipo_cita (k_id_tipo)
ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Cita ADD CONSTRAINT FK_Cita_Agenda 
	FOREIGN KEY (k_id_agenda) REFERENCES Agenda (k_id_agenda)
;

ALTER TABLE Cita ADD CONSTRAINT FK_Cita_Afiliado 
	FOREIGN KEY (k_identificacion) REFERENCES Afiliado (k_identificacion)
ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Cita ADD CONSTRAINT FK_Cita_Multa 
	FOREIGN KEY (k_id_multa) REFERENCES Multa (k_id_multa)
ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Consultorio ADD CONSTRAINT FK_Consultorio_Sede 
	FOREIGN KEY (k_id_sede) REFERENCES Sede (k_id_sede)
ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Medico ADD CONSTRAINT FK_Medico_Consultorio 
	FOREIGN KEY (k_id_consultirio) REFERENCES Consultorio (k_id_consultirio)
ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Medico ADD CONSTRAINT FK_Medico_Especialidad 
	FOREIGN KEY (k_codigo_especiali) REFERENCES Especialidad (k_codigo)
ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Medico ADD CONSTRAINT FK_Medico_Usuario 
	FOREIGN KEY (k_identificacion) REFERENCES Usuario (k_identificacion)
ON DELETE NO ACTION ON UPDATE NO ACTION
;
