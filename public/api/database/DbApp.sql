create table cliente_categorias
(
	id int unsigned auto_increment
		primary key,
	nome varchar(100) null,
	deletado_em datetime null
);

create table clientes
(
	id int unsigned auto_increment
		primary key,
	nome varchar(128) null,
	categoria int unsigned null,
	digital mediumtext null comment 'string que identifica a impressao digital',
	nota mediumtext null,
	criado_em datetime default current_timestamp() null,
	deletado_em datetime null,
	constraint clientes_cliente_categorias_id_fk
		foreign key (categoria) references cliente_categorias (id)
			on update cascade on delete set null
);

create table cliente_emails
(
	id int unsigned auto_increment
		primary key,
	cliente int unsigned not null,
	email varchar(100) null,
	criado_em datetime default current_timestamp() null,
	deletado_em datetime null,
	constraint cliente_emails_clientes_id_fk
		foreign key (cliente) references clientes (id)
			on update cascade on delete cascade
);

create table cliente_enderecos
(
	id int unsigned auto_increment
		primary key,
	cliente int unsigned not null,
	cep varchar(8) null,
	uf varchar(2) null,
	bairro varchar(100) null,
	cidade varchar(100) null,
	logradouro varchar(100) null,
	criado_em datetime default current_timestamp() null,
	deletado_em datetime null,
	constraint cliente_enderecos_clientes_id_fk
		foreign key (cliente) references clientes (id)
			on update cascade on delete cascade
);

create table cliente_telefones
(
	id int unsigned auto_increment
		primary key,
	cliente int unsigned not null,
	numero varchar(12) null,
	tipo int unsigned default 1 not null comment '1 = fixo, 2 = celular',
	criado_em datetime default current_timestamp() null,
	deletado_em datetime null,
	constraint cliente_telefones_clientes_id_fk
		foreign key (cliente) references clientes (id)
			on update cascade on delete cascade
);

create table configuracoes
(
	id int unsigned auto_increment
		primary key,
	criado_em datetime default current_timestamp() not null,
	biometria_nitgen tinyint(1) default 0 null comment 'utilizar scan de digital da Nitgen'
);

create table produtos
(
	id int unsigned auto_increment
		primary key,
	nome varchar(128) null,
	codigo varchar(128) null,
	valor decimal(6,2) default 0.00 not null,
	criado_em datetime default current_timestamp() null,
	deletado_em datetime null
);

create table vendas
(
	id int unsigned auto_increment
		primary key,
	cliente varchar(128) null,
	cadastro int unsigned null comment 'vincula a venda a um cliente cadastrado',
	credito decimal(8,2) default 0.00 not null,
	nota mediumtext null,
	criado_em datetime default current_timestamp() null,
	constraint vendas_clientes_id_fk
		foreign key (cadastro) references clientes (id)
			on update cascade on delete set null
);

create table venda_itens
(
	id int unsigned auto_increment
		primary key,
	venda int unsigned not null,
	produto int unsigned null,
	quantidade float not null,
	valor_un decimal(8,2) null,
	valor decimal(8,2) null,
	criado_em datetime default current_timestamp() null,
	constraint venda_items_produtos_id_fk
		foreign key (produto) references produtos (id)
			on update cascade on delete set null,
	constraint venda_itens_vendas_id_fk
		foreign key (venda) references vendas (id)
			on update cascade on delete cascade
);
