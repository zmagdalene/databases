CREATE TABLE IF NOT EXISTS notes (
  id int NOT NULL AUTO_INCREMENT,
  body char(64) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO notes (body) VALUES
('Hello how are you today?'),
('Today is a great day'),
('The weather is nice'),
('I am learning Docker');
