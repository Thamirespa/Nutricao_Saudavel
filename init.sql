CREATE TABLE users (
  id CHAR(36) NOT NULL DEFAULT (UUID()),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE nutritional_information (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  specification VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  kcal VARCHAR(255) NOT NULL,
  image VARCHAR(255),
  category VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE diary (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  is_in_diet BOOLEAN NOT NULL,
  user_id CHAR(36) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE meal_plan (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  quantity VARCHAR(255) NOT NULL,
  meal VARCHAR(255) NOT NULL,
  user_id CHAR(36) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE chat (
  id INT NOT NULL AUTO_INCREMENT,
  subject VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  user_id CHAR(36) NOT NULL,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE appointment (
  id INT NOT NULL AUTO_INCREMENT,
  professional_name VARCHAR(255) NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  user_id CHAR(36) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

## users
INSERT INTO users (id, name, email, password) VALUES ("4306ddf2-1f52-11ef-b42a-0242ac1b0002",	"Maria Silva", "teste@teste.com", "123456")

## meal_plan
INSERT INTO meal_plan (title, quantity, meal, user_id) VALUES ("Alface", "1 xícara", "café da manhã", "d0b77b9b-19dc-45a1-883c-d8aa0713f5bd");
INSERT INTO meal_plan (title, quantity, meal, user_id) VALUES ("Ovo Mexido", "2 unidades", "café da manhã", "d0b77b9b-19dc-45a1-883c-d8aa0713f5bd");
INSERT INTO meal_plan (title, quantity, meal, user_id) VALUES ("Arroz Integral", "1/2 xícara", "almoço", "d0b77b9b-19dc-45a1-883c-d8aa0713f5bd");
INSERT INTO meal_plan (title, quantity, meal, user_id) VALUES ("Feijão", "1/2 xícara", "almoço", "d0b77b9b-19dc-45a1-883c-d8aa0713f5bd");
INSERT INTO meal_plan (title, quantity, meal, user_id) VALUES ("Maçã", "1 unidade", "lanche", "d0b77b9b-19dc-45a1-883c-d8aa0713f5bd");
INSERT INTO meal_plan (title, quantity, meal, user_id) VALUES ("Iogurte Natural", "200ml", "lanche", "d0b77b9b-19dc-45a1-883c-d8aa0713f5bd");
INSERT INTO meal_plan (title, quantity, meal, user_id) VALUES ("Frango Grelhado", "100g", "janta", "d0b77b9b-19dc-45a1-883c-d8aa0713f5bd");
INSERT INTO meal_plan (title, quantity, meal, user_id) VALUES ("Salada de Folhas", "1 prato", "janta", "d0b77b9b-19dc-45a1-883c-d8aa0713f5bd");

## meal_plan
INSERT INTO diary (id, user_id, date, time, title, description, is_in_diet) VALUES
(1, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-15', '07:30:00', 'Café da Manhã', 'Pão com manteiga', true),
(2, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-15', '12:00:00', 'Almoço', 'Feijão com arroz', true),
(3, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-15', '15:30:00', 'Lanche', 'Maçã e banana', true),
(4, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-15', '19:00:00', 'Janta', 'Frango grelhado com salada', true),
(5, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-16', '07:30:00', 'Café da Manhã', 'Iogurte com granola', true),
(6, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-16', '12:00:00', 'Almoço', 'Macarrão com legumes', true),
(7, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-16', '15:30:00', 'Lanche', 'Biscoito integral', true),
(8, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-16', '19:00:00', 'Janta', 'Sopa de legumes', true),
(9, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-17', '07:30:00', 'Café da Manhã', 'Torrada com abacate', true),
(10, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-17', '12:00:00', 'Almoço', 'Arroz com frango', true),
(11, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-17', '15:30:00', 'Lanche', 'Suco de laranja', true),
(12, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-17', '19:00:00', 'Janta', 'Peixe grelhado com salada', true),
(13, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-18', '07:30:00', 'Café da Manhã', 'Cereal com leite', true),
(14, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-18', '12:00:00', 'Almoço', 'Quinoa com vegetais', true),
(15, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-18', '15:30:00', 'Lanche', 'Barra de cereal', true),
(16, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-18', '19:00:00', 'Janta', 'Omelete com espinafre', true),
(17, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-19', '07:30:00', 'Café da Manhã', 'Pão integral com queijo', true),
(18, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-19', '12:00:00', 'Almoço', 'Arroz integral com legumes', true),
(19, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-19', '15:30:00', 'Lanche', 'Fruta mista', true),
(20, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-19', '19:00:00', 'Janta', 'Carne grelhada com salada', true),
(21, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-20', '07:30:00', 'Café da Manhã', 'Panqueca de aveia', true),
(22, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-20', '12:00:00', 'Almoço', 'Feijão tropeiro', true),
(23, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-20', '15:30:00', 'Lanche', 'Biscoito de arroz', true),
(24, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-20', '19:00:00', 'Janta', 'Salmão grelhado com batata', true),
(25, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-21', '07:30:00', 'Café da Manhã', 'Mingau de aveia', true),
(26, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-21', '12:00:00', 'Almoço', 'Strogonoff de frango', true),
(27, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-21', '15:30:00', 'Lanche', 'Iogurte com mel', true),
(28, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-21', '19:00:00', 'Janta', 'Lasanha de berinjela', true),
(29, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-22', '07:30:00', 'Café da Manhã', 'Omelete de claras', true),
(30, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-22', '12:00:00', 'Almoço', 'Carne de panela com legumes', true),
(31, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-22', '15:30:00', 'Lanche', 'Sanduíche natural', true),
(32, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-22', '19:00:00', 'Janta', 'Macarrão integral com molho pesto', true),
(33, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-23', '07:30:00', 'Café da Manhã', 'Suco verde com torrada', true),
(34, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-23', '12:00:00', 'Almoço', 'Bife com arroz', true),
(35, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-23', '15:30:00', 'Lanche', 'Salada de frutas', true),
(36, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-23', '19:00:00', 'Janta', 'Frango ao curry', true),
(37, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-24', '07:30:00', 'Café da Manhã', 'Smoothie de banana', true),
(38, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-24', '12:00:00', 'Almoço', 'Arroz à grega', true),
(39, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-24', '15:30:00', 'Lanche', 'Bolacha integral com queijo', true),
(40, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-24', '19:00:00', 'Janta', 'Hambúrguer de grão-de-bico', true),
(41, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-25', '07:30:00', 'Café da Manhã', 'Iogurte com frutas', true),
(42, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-25', '12:00:00', 'Almoço', 'Risoto de frango', true),
(43, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-25', '15:30:00', 'Lanche', 'Pipoca sem óleo', true),
(44, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-25', '19:00:00', 'Janta', 'Wrap de vegetais', true),
(45, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-26', '07:30:00', 'Café da Manhã', 'Granola com leite', true),
(46, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-26', '12:00:00', 'Almoço', 'Salada de atum', true),
(47, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-26', '15:30:00', 'Lanche', 'Barra de proteína', true),
(48, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-26', '19:00:00', 'Janta', 'Caldo verde', true),
(49, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-27', '07:30:00', 'Café da Manhã', 'Frutas variadas', true),
(50, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-27', '12:00:00', 'Almoço', 'Torta de frango', true),
(51, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-27', '15:30:00', 'Lanche', 'Iogurte natural', true),
(52, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-27', '19:00:00', 'Janta', 'Salada grega', true),
(53, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-28', '07:30:00', 'Café da Manhã', 'Ovos cozidos', true),
(54, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-28', '12:00:00', 'Almoço', 'Lasanha de frango', true),
(55, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-28', '15:30:00', 'Lanche', 'Sanduíche integral', true),
(56, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-28', '19:00:00', 'Janta', 'Salada de quinoa', true),
(57, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-29', '07:30:00', 'Café da Manhã', 'Smoothie de frutas', true),
(58, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-29', '12:00:00', 'Almoço', 'Arroz integral com vegetais', true),
(59, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-29', '15:30:00', 'Lanche', 'Palitinhos de cenoura', true),
(60, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-29', '19:00:00', 'Janta', 'Frango ao molho mostarda', true),
(61, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-30', '07:30:00', 'Café da Manhã', 'Panqueca de aveia com mel', true),
(62, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-30', '12:00:00', 'Almoço', 'Feijão preto com arroz', true),
(63, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-30', '15:30:00', 'Lanche', 'Salada de frutas com iogurte', true),
(64, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-30', '19:00:00', 'Janta', 'Peixe grelhado com legumes', true),
(65, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-31', '07:30:00', 'Café da Manhã', 'Torrada com abacate e ovo', true),
(66, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-31', '12:00:00', 'Almoço', 'Salada de grão-de-bico', true),
(67, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-31', '15:30:00', 'Lanche', 'Biscoito integral com queijo cottage', true),
(68, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-31', '19:00:00', 'Janta', 'Quinoa com vegetais', true),
(69, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-06-01', '07:30:00', 'Café da Manhã', 'Ovos mexidos com torradas', true),
(70, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-06-01', '12:00:00', 'Almoço', 'Feijão com arroz', true),
(71, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-06-01', '15:30:00', 'Lanche', 'Maçã e banana', true),
(72, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-06-01', '19:00:00', 'Janta', 'Arroz e feijão', true),
(73, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-06-02', '07:30:00', 'Café da Manhã', 'Iogurte com granola e frutas', true),
(74, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-06-02', '12:00:00', 'Almoço', 'Risoto de legumes', true),
(75, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-06-02', '15:30:00', 'Lanche', 'Suco detox com biscoito integral', true),
(76, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-06-02', '19:00:00', 'Janta', 'Salmão ao forno com batata doce', true),
(77, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-15', '07:30:00', 'Café da Manhã', 'Ovos mexidos com espinafre', true),
(78, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-15', '12:00:00', 'Almoço', 'Peito de frango grelhado', true),
(79, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-15', '15:30:00', 'Lanche', 'Suco de laranja', true),
(80, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-15', '19:00:00', 'Janta', 'Sopa de lentilha', true),
(81, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-16', '07:30:00', 'Café da Manhã', 'Smoothie de frutas vermelhas', true),
(82, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-16', '12:00:00', 'Almoço', 'Arroz de couve-flor com frango', true),
(83, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-16', '15:30:00', 'Lanche', 'Iogurte com sementes de chia', true),
(84, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-16', '19:00:00', 'Janta', 'Sushi de vegetais', true),
(85, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-17', '07:30:00', 'Café da Manhã', 'Omelete de queijo e presunto', true),
(86, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-17', '12:00:00', 'Almoço', 'Feijoada light', true),
(87, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-17', '15:30:00', 'Lanche', 'Bolacha de aveia', true),
(88, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-17', '19:00:00', 'Janta', 'Creme de abóbora', true),
(89, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-18', '07:30:00', 'Café da Manhã', 'Cereal integral com leite', true),
(90, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-18', '12:00:00', 'Almoço', 'Peixe assado com batata', true),
(91, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-18', '15:30:00', 'Lanche', 'Suco de abacaxi', true),
(92, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-18', '19:00:00', 'Janta', 'Quibe de forno', true),
(93, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-19', '07:30:00', 'Café da Manhã', 'Pão integral com peito de peru', true),
(94, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-19', '12:00:00', 'Almoço', 'Arroz integral com feijão', true),
(95, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-19', '15:30:00', 'Lanche', 'Iogurte com frutas', true),
(96, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-19', '19:00:00', 'Janta', 'Cuscuz marroquino', true),
(97, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-20', '07:30:00', 'Café da Manhã', 'Ovos cozidos com abacate', true),
(98, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-20', '12:00:00', 'Almoço', 'Strogonoff de carne', true),
(99, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-20', '15:30:00', 'Lanche', 'Palitinhos de pepino', true),
(100, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-20', '19:00:00', 'Janta', 'Frango grelhado com legumes', true),
(101, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-21', '07:30:00', 'Café da Manhã', 'Smoothie de abacate', true),
(102, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-21', '12:00:00', 'Almoço', 'Lasanha de abobrinha', true),
(103, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-21', '15:30:00', 'Lanche', 'Bolacha de arroz com pasta de amendoim', true),
(104, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-21', '19:00:00', 'Janta', 'Salada de frango com quinoa', true),
(105, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-22', '07:30:00', 'Café da Manhã', 'Ovos mexidos com tomate', true),
(106, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-22', '15:30:00', 'Lanche', 'Frutas secas', true),
(107, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-22', '19:00:00', 'Janta', 'Torta de legumes', true),
(108, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-23', '07:30:00', 'Café da Manhã', 'Mingau de aveia com banana', true),
(109, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-23', '12:00:00', 'Almoço', 'Sopa de legumes', true),
(110, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-23', '15:30:00', 'Lanche', 'Iogurte com granola', true),
(111, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-23', '19:00:00', 'Janta', 'Peixe ao molho de maracujá', true),
(112, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-24', '07:30:00', 'Café da Manhã', 'Tapioca com queijo branco', true),
(113, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-24', '12:00:00', 'Almoço', 'Frango xadrez', true),
(114, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-24', '15:30:00', 'Lanche', 'Pão integral com patê de atum', true),
(115, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-24', '19:00:00', 'Janta', 'Strogonoff de cogumelos', true),
(116, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-25', '07:30:00', 'Café da Manhã', 'Ovos mexidos com cogumelos', true),
(117, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-25', '12:00:00', 'Almoço', 'Feijão carioca com couve', true),
(118, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-25', '15:30:00', 'Lanche', 'Barra de cereal com frutas secas', true),
(119, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-25', '19:00:00', 'Janta', 'Salada de macarrão integral', true),
(120, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-26', '07:30:00', 'Café da Manhã', 'Torrada integral com abacate', true),
(121, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-26', '12:00:00', 'Almoço', 'Feijoada vegetariana', true),
(122, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-26', '15:30:00', 'Lanche', 'Iogurte com granola e mel', true),
(123, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-26', '19:00:00', 'Janta', 'Salada tailandesa', true),
(124, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-27', '07:30:00', 'Café da Manhã', 'Muffin de banana e aveia', true),
(125, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-27', '12:00:00', 'Almoço', 'Tilápia grelhada com legumes', true),
(126, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-27', '15:30:00', 'Lanche', 'Sanduíche de frango desfiado', true),
(127, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-27', '19:00:00', 'Janta', 'Espaguete integral com almôndegas', true),
(128, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-28', '07:30:00', 'Café da Manhã', 'Omelete com queijo e tomate', true),
(129, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-28', '12:00:00', 'Almoço', 'Ratatouille', true),
(130, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-28', '15:30:00', 'Lanche', 'Frutas frescas', true),
(131, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-28', '19:00:00', 'Janta', 'Salada de lentilha', true),
(132, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-29', '07:30:00', 'Café da Manhã', 'Pão de queijo de frigideira', true),
(133, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-29', '12:00:00', 'Almoço', 'Peixe ensopado', true),
(134, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-29', '15:30:00', 'Lanche', 'Batata doce assada', true),
(135, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-29', '19:00:00', 'Janta', 'Risoto de cogumelos', true),
(136, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-30', '07:30:00', 'Café da Manhã', 'Panqueca de banana com aveia', true),
(137, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-30', '12:00:00', 'Almoço', 'Frango grelhado com salada', true),
(138, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-30', '15:30:00', 'Lanche', 'Smoothie de morango com banana', true),
(139, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-30', '19:00:00', 'Janta', 'Legumes assados', true),
(140, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-31', '07:30:00', 'Café da Manhã', 'Tapioca com queijo e peito de peru', true),
(141, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-31', '12:00:00', 'Almoço', 'Sopa de abóbora com frango desfiado', true),
(142, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-31', '15:30:00', 'Lanche', 'Iogurte com granola e mel', true),
(143, '4306ddf2-1f52-11ef-b42a-0242ac1b0002', '2024-05-31', '19:00:00', 'Janta', 'Wrap de frango', true);

## nutritional_information
INSERT INTO nutritional_information (id, title, specification, description, kcal, image, category, recommendation_category) VALUES
(1, 'Alface', 'Verde', 'Rica em fibras e vitaminas.', 15, 'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'vegetais', 'alto_fibras'),
(2, 'Cenoura', 'Laranja', 'Fonte de vitamina A e antioxidantes.', 30, 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?q=80&w=2187&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'vegetais', 'sem_gluten'),
(3, 'Brócolis', 'Verde', 'Rico em cálcio e vitamina C.', 45, 'https://images.unsplash.com/photo-1628773822503-930a7eaecf80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'vegetais', 'alto_fibras'),
(4, 'Maçã', 'Fuji', 'Doce e crocante, rica em fibras e antioxidantes.', 60, 'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'frutas', 'alto_fibras'),
(5, 'Banana', 'Prata', 'Fonte de potássio e energia.', 90, 'https://images.unsplash.com/photo-1587132137056-bfbf0166836e?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'frutas', 'alto_fibras'),
(6, 'Morango', 'Fresco', 'Rico em vitamina C e antioxidantes.', 30, 'https://images.unsplash.com/photo-1588165171080-c89acfa5ee83?q=80&w=2187&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'frutas', 'sem_lactose'),
(7, 'Pão Integral', 'Grãos Integrais', 'Fonte de fibras e nutrientes.', 80, 'https://images.unsplash.com/photo-1626423642268-24cc183cbacb?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'paes', 'alto_fibras'),
(8, 'Croissant', 'Folhado', 'Macio e crocante.', 120, 'https://images.unsplash.com/photo-1623334044303-241021148842?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'paes', 'sem_gluten'),
(9, 'Pão de Queijo', 'Mineiro', 'Queijo derretido em um pãozinho macio.', 150, 'https://images.unsplash.com/photo-1559141680-d0bd7bc5af84?q=80&w=2128&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'paes', 'sem_gluten'),
(10, 'Brigadeiro', 'Tradicional', 'Doce de chocolate e leite condensado.', 100, 'https://images.unsplash.com/photo-1630953900113-ab915924aab2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'doces', 'sem_gluten'),
(11, 'Bolo de Cenoura', 'Com Cobertura de Chocolate', 'Bolo fofinho com cenoura e cobertura de chocolate.', 200, 'https://images.unsplash.com/photo-1622926421334-6829deee4b4b?q=80&w=2192&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'doces', 'sem_gluten'),
(12, 'Pudim', 'Caseiro', 'Sobremesa cremosa e suculenta.', 180, 'https://images.unsplash.com/photo-1637264596042-fcf205a81e1e?q=80&w=2128&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'doces', 'sem_gluten'),
(13, 'Espaguete', 'Al Dente', 'Massa italiana clássica.', 220, 'https://images.unsplash.com/photo-1556761223-4c4282c73f77?q=80&w=2130&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'massas', 'sem_gluten'),
(14, 'Lasanha', 'Bolonhesa', 'Camadas de massa, carne e queijo gratinado.', 300, 'https://plus.unsplash.com/premium_photo-1671547330493-b07d377085ca?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'massas', 'sem_lactose'),
(15, 'Tortellini', 'Recheado com Queijo', 'Massa recheada com queijo, cozida em molho de tomate.', 250, 'https://images.unsplash.com/photo-1628885405379-5d58de03edb0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'massas', 'sem_gluten'),
(16, 'Chá Verde', 'Japonês', 'Rico em antioxidantes e estimulante.', 5, 'https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'chas', 'baixo_sodio'),
(17, 'Chá de Camomila', 'Natural', 'Relaxante e calmante.', 0, 'https://images.unsplash.com/photo-1559666548-3885a4a5e5ee?q=80&w=2202&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'chas', 'baixo_sodio'),
(18, 'Chá de Hibisco', 'Com Gengibre', 'Refrescante e diurético.', 10, 'https://images.unsplash.com/photo-1594136604897-29f7e564db27?q=80&w=2148&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'chas', 'baixo_sodio');