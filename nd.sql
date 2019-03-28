-- Sukuriamos lenteles
CREATE TABLE IF NOT EXISTS `author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128),
  `surname` VARCHAR(128),
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8mb4 ENGINE=InnoDB;

-- Iš šios lentelės pašalintas prieš tai buvęs foreign_key su autoriaus id
CREATE TABLE IF NOT EXISTS `book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128),
  `price` DECIMAL(12,2),
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8mb4 ENGINE=InnoDB;

-- Sukuriama nauja lentelė, kurioje bus saugomi įrašai, koks autorius parašė kokią knygą
CREATE TABLE `author_book` (
  `author_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY(`author_id`, `book_id`)
) DEFAULT CHARSET=utf8mb4 ENGINE=InnoDB;

  -- INSERT sakiniai
  INSERT INTO `author` (`name`, `surname`) VALUES ("William", "Shakespeare");
  INSERT INTO `author` (`name`, `surname`) VALUES ("Agatha", "Christie");
  INSERT INTO `author` (`name`, `surname`) VALUES ("J. K", "Rowling");
  INSERT INTO `author` (`name`, `surname`) VALUES ("George", "Orwell");
  INSERT INTO `book` (`title`, `price`) VALUES ("Hamlet", 12.99);
  INSERT INTO `book` (`title`, `price`) VALUES ("Macbeth", 9.89);
  INSERT INTO `book` (`title`, `price`) VALUES ("Murder on the Orient Express", 7.79);
  INSERT INTO `book` (`title`, `price`) VALUES ("The Secret of Chimneys", 18.99);
  INSERT INTO `book` (`title`, `price`) VALUES ("1984", 20.79);
  INSERT INTO `book` (`title`, `price`) VALUES ("Animal Farm", 20.79);

  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (1,1);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (2,1);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (3,2);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (1,2);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (2,3);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (3,3);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (1,4);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (2,4);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (3,5);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (1,5);
  INSERT INTO `author_book` (`author_id`, `book_id`) VALUES (2,5);

  -- Ištraukiama lentelė, kurioje prie kiekvienos knygos rodomi visi ją parašę autoriai
  -- Autoeiai atskiriami kableliais
  SELECT
  	a.id,
    a.title AS Title,
    GROUP_CONCAT(a.author) AS Authors
  FROM
    (SELECT
    	book.id AS id,
    	title,
      CONCAT(name, ' ', surname) AS author
    FROM book
    JOIN author_book
    	ON book.id = author_book.book_id
    JOIN author
    	ON author.id = author_book.author_id) a
  GROUP BY a.id
