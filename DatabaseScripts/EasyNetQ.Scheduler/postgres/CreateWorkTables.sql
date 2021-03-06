CREATE TABLE workitems
(
  workitemid serial NOT NULL,
  bindingkey character varying(1000) NOT NULL,
  innermessage bytea NOT NULL,
  textdata character varying,
  CONSTRAINT workitems_pkey PRIMARY KEY (workitemid)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE workitemstatus
(
  workitemid integer NOT NULL,
  status smallint,
  waketime timestamp without time zone,
  clientid smallint,
  purgedate timestamp without time zone,
  CONSTRAINT workitemstatus_pkey PRIMARY KEY (workitemid),
  CONSTRAINT fk_workitemstatus_workitems FOREIGN KEY (workitemid)
      REFERENCES workitems (workitemid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);

CREATE INDEX ix_workitemstatus_purgedate
  ON workitemstatus
  USING btree
  (purgedate);

CREATE INDEX ix_workitemstatus_status_waketime
  ON workitemstatus
  USING btree
  (status, waketime);

