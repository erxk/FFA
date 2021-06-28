CREATE TABLE IF NOT EXISTS `ffa` (
  `identifier` char(50) DEFAULT NULL,
  `kills` int(11) DEFAULT NULL,
  `deaths` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `ffa_in` (
  `identifier` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

