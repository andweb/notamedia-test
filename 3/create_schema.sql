-- SCHEMA

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users_relations` (
  `relation_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_from` INT(11),
  `user_to` INT(11),
  `status` ENUM('new', 'confirmed', 'rejected'),
  PRIMARY KEY (`relation_id`),
  FOREIGN KEY (user_from) REFERENCES users(user_id),
  FOREIGN KEY (user_to) REFERENCES users(user_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE INDEX idx_user_from ON users_relations(user_from);
CREATE INDEX idx_user_to ON users_relations(user_to);
CREATE INDEX idx_user_from_status ON users_relations(user_from,status);
CREATE INDEX idx_user_to_status ON users_relations(user_to,status);

-- END SCHEMA