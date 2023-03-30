-- create the databases
CREATE DATABASE IF NOT EXISTS spice_datahub;

--
--
--

SET autocommit=0;
START TRANSACTION;


create table if not exists user
(
    id                            int auto_increment
        primary key,
    email                         varchar(128) charset utf8 not null,
    full_name                     varchar(512) charset utf8 not null,
    password                      varchar(256) charset utf8 not null,
    status                        int                       not null,
    date_created                  datetime                  not null,
    pwd_reset_token               varchar(256) charset utf8 null,
    pwd_reset_token_creation_date datetime                  null,
    is_admin                      tinyint(1) default 0      null,
    constraint email
        unique (email)
);

# ROLES
create table if not exists role
(
    id          int           not null,
    description varchar(1028) null,
    constraint roles_id_uindex
        unique (id)
);

alter table role
    add primary key (id);

#Add three system/default roles
INSERT INTO role (id, description) VALUES (0, 'Dataset owner');
INSERT INTO role (id, description) VALUES (-1, 'Logged in');
INSERT INTO role (id, description) VALUES (-2, 'Anonymous');




#Add a role for each existing user
INSERT INTO role (id)
SELECT id
FROM user
WHERE id>0;
-- ******** 21/01/2020
-- Add 'type' to dataset
CREATE TABLE `dataset_type` (
                                `id` int(11) NOT NULL AUTO_INCREMENT,
                                `name` varchar(50) NOT NULL,
                                `description` varchar(255) DEFAULT NULL,
                                PRIMARY KEY (`id`)
);

create table if not exists dataset
(
    id            int auto_increment
        primary key,
    title         varchar(255) charset utf8          not null,
    description   text                               not null,
    type          int                                null,
    uuid          varchar(64) charset utf8           not null,
    user_id       int                                not null,
    date_created  datetime default CURRENT_TIMESTAMP null,
    date_modified datetime default CURRENT_TIMESTAMP null,
    constraint uuid
        unique (uuid),
    constraint dataset_dataset_type_id_fk
        foreign key (type) references dataset_type (id),
    constraint datasets___user_id
        foreign key (user_id) references user (id)
            on delete cascade
);

create index datasets__user_id
    on dataset (user_id);

-- JC 16/12/2019
-- Dataset permissions table
create table if not exists dataset_permission
(
    role_id    int           not null,
    dataset_id int           not null,
    v          int default 0 not null,
    r          int default 0 not null,
    w          int default 0 not null,
    d          int default 0 not null,
    g          int default 0 not null,
    primary key (role_id, dataset_id),
    constraint dataset_permission___dataset_id
        foreign key (dataset_id) references dataset (id)
            on delete cascade,
    constraint dataset_permission___role_id
        foreign key (role_id) references role (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create index dataset_permission_role_id_dataset_id_index
    on dataset_permission (role_id, dataset_id);

create index dataset_permission_role_id_index
    on dataset_permission (role_id);

-- also use the following to populate for existing datasets:
-- v & r permission for logged in users
INSERT INTO dataset_permission (role_id, dataset_id, v, r)
SELECT -1, id, 1, 1
FROM dataset;

-- v permission for anonymous users
INSERT INTO dataset_permission (role_id, dataset_id, v)
SELECT -2, id, 1
FROM dataset;

-- all permissions for dataset owners
INSERT INTO dataset_permission (role_id, dataset_id, v, r, w, d, g)
SELECT 0, id, 1, 1, 1, 1, 1
FROM dataset;



INSERT INTO dataset_type (id, name, description) VALUES (1, 'stream', 'Datasets that support live streaming of JSON data from sensors or other Internet conencted devices');
INSERT INTO dataset_type (id, name, description) VALUES (2, 'file', 'Datasets consisting of static files');


create table if not exists metadata
(
    id          int auto_increment
        primary key,
    name        varchar(50) charset utf8 not null,
    description text charset utf8        null
)
    collate = utf8mb4_unicode_ci;


INSERT INTO metadata (id, name, description) VALUES (1, 'latitude', 'X latitiude coordinate (WGS84)');
INSERT INTO metadata (id, name, description) VALUES (2, 'longitude', 'Y longitude coordiante (WGS84)');
INSERT INTO metadata (id, name, description) VALUES (3, 'attribution', 'Dataset attribution');
INSERT INTO metadata (id, name, description) VALUES (4, 'tags', 'Dataset tags');


-- ******** 21/01/2020
-- Add dataset metadata
create table if not exists dataset__metadata
(
    id         int auto_increment
        primary key,
    dataset_id int                       not null,
    meta_id    int                       not null,
    value      varchar(255) charset utf8 not null,
    constraint dataset__metadata__dataset_id
        foreign key (dataset_id) references dataset (id)
            on delete cascade,
    constraint dataset__metadata__metadata_id
        foreign key (meta_id) references metadata (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create index dataset_id
    on dataset__metadata (dataset_id);

create index meta_id
    on dataset__metadata (meta_id);

create index value
    on dataset__metadata (value);



-- JC 23/03/2020
-- Dataset Owners
create table if not exists owner
(
    id   int auto_increment
        primary key,
    name varchar(250) not null,
    constraint owner_name_uindex
        unique (name)
);

create table if not exists dataset__owner
(
    id         int auto_increment
        primary key,
    dataset_id int not null,
    owner_id   int not null,
    constraint dataset__owner_dataset_id_fk
        foreign key (dataset_id) references dataset (id)
            on delete cascade,
    constraint dataset__owner_owner_id_fk
        foreign key (owner_id) references owner (id)
            on delete cascade
);

-- JC 23/03/2020
-- Dataset licences
create table if not exists licence
(
    id          int auto_increment
        primary key,
    name        varchar(250)  null,
    description text null,
    uri         varchar(250)  null,
    constraint licence_name_uindex
        unique (name)
);

create table if not exists dataset__licence
(
    id         int auto_increment
        primary key,
    dataset_id int not null,
    licence_id int not null,
    constraint dataset__licence_dataset_id_fk
        foreign key (dataset_id) references dataset (id)
            on delete cascade,
    constraint dataset__licence_licence_id_fk
        foreign key (licence_id) references licence (id)
            on delete cascade
);

-- Some sample licences
INSERT INTO licence (id, name, description, uri) VALUES (1, 'Apache License', 'This is the description of the Apache licence', 'https://www.apache.org/licenses/LICENSE-2.0');
INSERT INTO licence (id, name, description, uri) VALUES (2, 'Creative Commons', 'Description of Creative Commons licence', 'https://creativecommons.org/licenses/by/4.0/');
INSERT INTO licence (id, name, description, uri) VALUES (3, 'Open Government Licence', null, 'http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/');
INSERT INTO licence (id, name, description, uri) VALUES (4, 'Koubachi Platform Terms of Service', null, 'https://datahub.mksmart.org/policy/koubachi-platform-terms-of-service/');
INSERT INTO licence (id, name, description, uri) VALUES (5, 'Flickr APIs Terms of Use', null, 'https://www.flickr.com/help/terms/api');






create table if not exists collection
(
    id            int auto_increment
        primary key,
    title         varchar(255)                       not null,
    description   text                       not null,
    user_id       int                                not null,
    date_created  datetime default CURRENT_TIMESTAMP null,
    date_modified datetime default CURRENT_TIMESTAMP null,
    constraint collection__user_id
        foreign key (user_id) references user (id)
            on delete cascade
);

create table if not exists collection__dataset
(
    collection_id int not null,
    dataset_id    int not null,
    constraint collection_id
        unique (collection_id, dataset_id),
    constraint collection__dataset_to_collection
        foreign key (collection_id) references collection (id)
            on delete cascade,
    constraint collection__dataset_to_dataset
        foreign key (dataset_id) references dataset (id)
            on delete cascade
);

create table if not exists tag
(
    id   int auto_increment
        primary key,
    name varchar(50) null,
    constraint tag_pk
        unique (name)
);

create table if not exists dataset__tag
(
    id         int auto_increment
        primary key,
    dataset_id int not null,
    tag_id     int not null,
    constraint dataset__tag_dataset_id_fk
        foreign key (dataset_id) references dataset (id)
            on delete cascade,
    constraint dataset__tag_tag_id_fk
        foreign key (tag_id) references tag (id)
            on delete cascade
);create table if not exists accesskey
(
    id          int auto_increment
        primary key,
    name        varchar(255) not null,
    description text null,
    uuid        varchar(64)  not null,
    user_id     int          null,
    constraint key_uuid_uindex
        unique (uuid),
    constraint key_user_id_fk
        foreign key (user_id) references user (id)
            on delete cascade
);

create table if not exists accesskey_permissions
(
    id            int auto_increment
        primary key,
    key_id        int      not null,
    dataset_id    int      null,
    permission    char     not null,
    date_created  datetime null,
    date_modified datetime null,
    constraint accesskey_permissions_accesskey_id_fk
        foreign key (key_id) references accesskey (id)
            on delete cascade,
    constraint key_permissions_dataset_id_fk
        foreign key (dataset_id) references dataset (id)
            on delete cascade
);create table if not exists file
(
    id                int auto_increment
        primary key,
    dataset_id        int           not null,
    title             varchar(64)   not null,
    description       text null,
    filename          varchar(64)   not null,
    filename_original varchar(64)   not null,
    file_type         varchar(1024)   null,
    file_size         int           null,
    date_created      datetime      null,
    date_modified     datetime      null,
    constraint file_dataset_id_fk
        foreign key (dataset_id) references dataset (id)
);

create index file_dataset_id_index
    on file (dataset_id);




INSERT INTO user (id, email, full_name, password, status, date_created, pwd_reset_token, pwd_reset_token_creation_date, is_admin) VALUES (1, 'admin@example.org', 'Admin', '$2y$10$x7I97.WhM.X5n/NCqOHibu6AO/iyShMYXEFyBNh2hsfDxsXY9kGa2', 1, '2019-10-04 13:00:41', null, null, 1);

COMMIT;