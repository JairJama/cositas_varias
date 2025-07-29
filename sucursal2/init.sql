create extension if not exists "uuid-ossp";
create extension if not exists "pgcrypto";

create user admin1 with password 'admin123';
create user consulta with password 'consulta123';

-- Otorgar permisos al usuario de escritura (admin1)
GRANT CONNECT ON DATABASE tiendapeliculas2 TO admin1;
GRANT USAGE ON SCHEMA public TO admin1;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin1;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin1;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO admin1;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO admin1;

-- Otorgar permisos de lectura al usuario de lectura (consulta)
GRANT CONNECT ON DATABASE tiendapeliculas2 TO consulta;
GRANT USAGE ON SCHEMA public TO consulta;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO consulta;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO consulta;

create table peliculas (
    id uuid primary key default uuid_generate_v4(),
    titulo varchar(255) not null,
    genero varchar(50) not null,
    año integer not null,
    director varchar(255) not null
);

create table clientes (
    id uuid primary key default uuid_generate_v4(),
    nombre varchar(255) not null,
    email varchar(255) not null unique,
    telefono varchar(20) not null
);

create table generos (
    id uuid primary key default uuid_generate_v4(),
    nombre varchar(50) not null unique
);

create table alquileres (
    id uuid primary key default uuid_generate_v4(),
    fechaAlquiler timestamp not null default current_timestamp,
    fechaDevolucion timestamp,
    clientes_id uuid references clientes(id) not null,
    peliculas_id uuid references peliculas(id) not null
);

create table empleado (
    id uuid primary key default uuid_generate_v4(),
    nombre varchar(255) not null,
    cargo varchar(100) not null
);

create table inventario (
    id uuid primary key default uuid_generate_v4(),
    peliculas_id uuid references peliculas(id) not null,
    copiasDisponibles integer not null default 0,
    copiasTotales integer not null default 0
);

create table devoluciones (
    id uuid primary key default uuid_generate_v4(),
    alquiler_id uuid references alquileres(id) not null,
    fechaDevolucion timestamp not null default current_timestamp,
    estado varchar(50) not null
);