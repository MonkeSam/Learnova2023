-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 10.150.0.123    Database: Learnova5H
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping events for database 'Learnova5H'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `Learnova5H_SessionKeysCheck` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`sa`@`%`*/ /*!50106 EVENT `Learnova5H_SessionKeysCheck` ON SCHEDULE EVERY 1 MINUTE STARTS '2023-05-11 10:48:26' ON COMPLETION NOT PRESERVE ENABLE DO begin
  update Learnova5H.`Utente` set `SessionKey` = null, `LastActivity` = null where timestampdiff(hour, getLastLogin(`User`), current_timestamp()) > 1;
end */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'Learnova5H'
--
/*!50003 DROP FUNCTION IF EXISTS `checkUserSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` FUNCTION `checkUserSession`(
    _sessionKey char(36)
) RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
declare _user varchar(20);
if(_sessionKey is not null) then
	set _user = (select `User` from `Utente` where `SessionKey` = _sessionKey);
    if (_user is not null) then
		update `Utente` set `LastActivity` = current_timestamp() where `User` = _user;
    end if;
    return (_user);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CreateUtente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` FUNCTION `CreateUtente`(
	username VARCHAR(16),
    pswd VARCHAR(45)
) RETURNS bit(1)
    DETERMINISTIC
BEGIN
IF(Select User FROM Utente WHERE User=username) IS NULL then
	INSERT INTO Utente (User, Passwd) VALUES (username, pswd);
	RETURN 1;
else
	signal sqlstate'45000' set message_text="Utente già esistente nel database";
    RETURN 0;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getLastLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` FUNCTION `getLastLogin`(
	_username varchar(20)
) RETURNS timestamp
    DETERMINISTIC
BEGIN
RETURN (
	select `LastActivity` 
    from (
		select `User`, `LastActivity`
        from `Utente`
	) as `LastActivitys` 
    where `LastActivitys`.`User` = _username
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `IsProfessorORStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` FUNCTION `IsProfessorORStudent`(Users VARCHAR(16)) RETURNS bit(1)
    DETERMINISTIC
BEGIN
if (Users IN (SELECT Utente FROM Professore) IS NULL) then
	RETURN 0;
else
	RETURN 1;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `PiallaUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` FUNCTION `PiallaUser`(
	utente VARCHAR(16)
) RETURNS bit(1)
    DETERMINISTIC
BEGIN
if(SELECT User FROM Utente WHERE User=utente IS NULL) then
	signal sqlstate'45000' set message_text="Utente non presente nel database";
    RETURN 0;
else
	DELETE FROM Utente WHERE user=utente;
    RETURN 1;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `UpdateUtente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` FUNCTION `UpdateUtente`(
	username VARCHAR(16),
    usernameNuovo VARCHAR(16),
    pswd VARCHAR(45)
) RETURNS bit(1)
    DETERMINISTIC
BEGIN
if(username=usernameNuovo) then
	UPDATE Utente SET Passwd=pswd WHERE Utente.User = username;
	RETURN 1;
else
	IF((Select COUNT(*) FROM Utente WHERE User=usernameNuovo) = 0) then
		UPDATE Utente SET User=usernameNuovo , Passwd=pswd WHERE Utente.User = username;
		RETURN 1;
	else
		signal sqlstate '45000' set message_text = 'Nome utente già presente nel database';
        RETURN 0;
	end if;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateAssegnazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateAssegnazione`(
	IN idProfessore int,
    IN idClasse int,
	IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	IF(SELECT * FROM Assegnazione WHERE Assegnazione.Professore = idProfessore AND Assegnazione.Classe = idClasse)  IS NULL then
		INSERT INTO Assegnazione (Professore,Classe) VALUES (idProfessore, idClasse);
	else
		signal sqlstate'45000' set message_text="Assegnazione già presente nel database";
	end if;
else
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateAssenza` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateAssenza`(
	IN idStudente INT,
    IN dataAssenza DATETIME,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	IF((SELECT COUNT(*) FROM Assenza WHERE Assenza.Studente = idStudente AND Assenza.Data = dataAssenza) = 0) then
		INSERT INTO Assenza VALUES(idStudente,dataAssenza);
	else
		signal sqlstate'45000' set message_text="Assenza già presente nel database";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateClasse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateClasse`(
	IN annoClasse INT,
    IN idSezione INT,
    IN idIndirizzo INT,
	IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if (SELECT Anno, Sezione, Indirizzo FROM Classe WHERE Classe.Anno = annoClasse AND Classe.Sezione = idSezione AND Classe.Indirizzo = idIndirizzo) IS NULL then
		INSERT INTO Classe (Anno, Sezione, Indirizzo) VALUES(annoClasse,idSezione,idIndirizzo);
	else
		signal sqlstate'45000' set message_text="Classe già presente nel database"; 
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateCompetenza` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateCompetenza`(
	IN idProfessore INT,
    IN idMateria INT,
	IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	IF(SELECT * FROM Competenza WHERE Competenza.Professore = idProfessore AND Competenza.Materia = idMateria) IS NULL then
		INSERT INTO Competenza (Professore, Materia) VALUES(idProfessore,idMateria);
	else
		signal sqlstate'45000' set message_text="Competenza già presente nel database";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateCompito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateCompito`(
	IN idClasse INT,
    IN dataOttenimento DATETIME,
    IN tipoCompito VARCHAR(45),
    IN idProfessore INT,
    IN idMateria INT,
    IN descrizione VARCHAR(100),
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if((SELECT COUNT(*) FROM Compito WHERE Compito.Classe = idClasse AND Compito.Data = dataOttenimento AND Compito.Tipo = tipoCompito AND Compito.Professore = idProfessore AND Compito.Materia = idMateria) = 0) then
		INSERT INTO Compito (Classe, Data, Tipo, Professore, Materia, Descrizione) VALUES(idClasse,dataOttenimento,tipoCompito,idProfessore,idMateria,descrizione);
	else
		signal sqlstate '45000' set message_text = 'Il compito esiste già nel database';
    end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateIndirizzo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateIndirizzo`(
	IN nomeIndirizzo VARCHAR(75),
	IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	IF(SELECT Nome FROM Indirizzo WHERE Indirizzo.Nome = LOWER(TRIM(nomeIndirizzo))) IS NULL then 
		INSERT INTO Indirizzo (Nome) VALUES (LOWER(TRIM(nomeIndirizzo)));
	else
		signal sqlstate'45000' set message_text="Indirizzo già presente nel database";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateIndirizzo_Materia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateIndirizzo_Materia`(
	IN idIndirizzo INT,
    IN idMateria INT,
	IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	IF(SELECT * FROM Indirizzo_Materia WHERE Indirizzo_Materia.Indirizzo = idIndirizzo AND Indirizzo_Materia.Materia = idMateria) IS NULL then
		INSERT INTO Indirizzo_Materia (Indirizzo, Materia) VALUES (idIndirizzo,idMateria);
	else
		signal sqlstate'45000' set message_text="Indirizzo_Materia già presente nel database";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateMateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateMateria`(
	IN nomeMateria VARCHAR(75),
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	IF(SELECT Nome FROM Materia WHERE Materia.Nome = LOWER(TRIM(nomeMateria)) IS NULL) then 
		INSERT INTO Materia (Nome) VALUES (LOWER(TRIM(nomeMateria)));
	else	
		signal sqlstate'45000' set message_text="Materia già presente nel database";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateNota` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateNota`(
	IN idStudente INT,
    IN idProfessore INT,
    IN dataProvvedimento DATETIME,
    IN descrizione VARCHAR(100),
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if(SELECT * FROM Nota WHERE Nota.Studente = idStudente AND Nota.Professore = idProfessore AND Nota.Data = dataProvvedimento) IS NULL then
		INSERT INTO Nota (Studente, Professore, Data, Descrizione) VALUES(idStudente,idProfessore,dataProvvedimento,descrizione);
	else
		signal sqlstate'45000' set message_text="Assenza già presente nel database";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateProfessore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateProfessore`(
	IN username VARCHAR(16),
    IN pswd VARCHAR(45),
    IN nome VARCHAR(45),
    IN cognome VARCHAR(45),
    IN stipendio INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if (CreateUtente(username,pswd) = 1) then
		INSERT INTO Professore (Nome, Cognome, Stipendio, Utente) VALUES (nome, cognome, stipendio, username);
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateSezione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateSezione`(
	IN letteraSezione CHAR(1),
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	IF(SELECT Lettera FROM Sezione WHERE Sezione.Lettera = UPPER(letteraSezione)) IS NULL then
	INSERT INTO Sezione (Lettera) VALUES (UPPER(letteraSezione));
	else
		signal sqlstate'45000' set message_text="Sezione già presente nel database";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateStudente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateStudente`(
	IN username VARCHAR(16),
    IN pswd VARCHAR(45),
    IN nome VARCHAR(45),
    IN cognome VARCHAR(45),
    IN dataDiNascita DATETIME,
    IN idClasse INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if (CreateUtente(username,pswd) = 1) then
		INSERT INTO Studente (Nome, Cognome, DataDiNascita, Utente, Classe) VALUES (nome, cognome, dataDiNascita, username, idClasse );
	end if;	
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateVoto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `CreateVoto`(
	IN idStudente INT,
    IN idMateria INT,
    IN votoOttenuto DECIMAL(1,0),
    IN dataOttenimento DATETIME,
    IN idProfessore INT,
    IN descrizione VARCHAR(100),
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	IF((SELECT COUNT(*) FROM Voto WHERE Voto.Studente = idStudente AND Voto.Materia = idMateria AND Voto.Voto = votoOttenuto AND Voto.Data = dataOttenimento) = 0) then
		INSERT INTO Voto (Studente,Materia,Voto,Data,Professore,Descrizione) VALUES(idStudente,idMateria,votoOttenuto,dataOttenimento,idProfessore,descrizione);
	else
		signal sqlstate'45000' set message_text="lo studente ha già questo voto";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteAssegnazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteAssegnazione`(
	IN idProfessore INT,
    IN idClasse INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Assegnazione WHERE Assegnazione.Professore = idProfessore AND Assegnazione.Classe = idClasse;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteAssenza` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteAssenza`(
	IN idStudente INT,
    IN dataScelta DATETIME,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Assenza WHERE Assenza.Studente = idStudente AND Assenza.Data = dataScelta;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteClasse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteClasse`(
	IN idClasse INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Classe WHERE Classe.Id=idClasse;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCompetenza` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteCompetenza`(
	IN idProfessore INT,
    IN idMateria INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Competenza WHERE Competenza.Professore = idProfessore AND Competenza.Materia = idMateria;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCompito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteCompito`(
	IN idClasse INT,
    IN dataOttenimento DATETIME,
    IN tipoCompito VARCHAR(45),
    IN idProfessore INT,
    IN idMateria INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Compito WHERE Compito.Classe = idClasse AND Compito.Data = dataOttenimento AND Compito.Tipo = tipoCompito AND Compito.Professore = idProfessore AND Compito.Materia = idMateria;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteIndirizzo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteIndirizzo`(
	IN idIndirizzo INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Indirizzo WHERE Indirizzo.Id = idIndirizzo;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteIndirizzo_Materia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteIndirizzo_Materia`(
	IN idIndirizzo INT,
    IN idMateria INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Indirizzo_Materia WHERE Indirizzo_Materia.Indirizzo = idIndirizzo AND Indirizzo_Materia.Materia = idMateria;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteMateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteMateria`(
	IN idMateria INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Materia WHERE Materia.Id = idMateria;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteNota` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteNota`(
	IN idStudente INT,
    IN idProfessore INT,
    IN dataScelta DATETIME,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Nota WHERE Nota.Studente = idStudente AND Nota.Professore = idProfessore AND Nota.Data = dataScelta;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteProfessore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteProfessore`(
	IN idProf INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT PiallaUser((SELECT Utente FROM Professore WHERE Professore.Id = idProf)) INTO @ignora;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteSezione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteSezione`(
	IN idSezione INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Sezione WHERE Sezione.Id = idSezione;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteStudente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteStudente`(
	IN idStud INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT PiallaUser((SELECT Utente FROM Studente WHERE Studente.Id = idStud)) INTO @ignora ;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteUser`(
	in utente VARCHAR(16),
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT PiallaUser(utente) INTO @ignora;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteVoto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `DeleteVoto`(
	IN idStudente INT,
    IN idMateria INT,
    IN voto INT,
    IN dataScelta DATETIME,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	DELETE FROM Voto WHERE Voto.Studente = idStudente AND Voto.Materia = idMateria AND Voto.Voto = voto AND Voto.Data = dataScelta;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAssegnazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetAssegnazione`(
	IN idProfessore int,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT Classe.Anno, Sezione.Lettera, Indirizzo.Nome AS Specializzazione FROM Assegnazione Join Classe ON Classe.Id = Assegnazione.Classe JOIN Sezione ON Classe.Sezione = Sezione.Id JOIN Indirizzo ON Classe.Indirizzo = Indirizzo.Id
	WHERE Professore = idProfessore;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAssenze` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetAssenze`(
	IN idstudente int,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT data FROM Assenza
	WHERE  idstudente=Studente
	order by data desc;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetClassi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetClassi`(
	  IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT Classe.Id ,Anno, Sezione.Lettera, Indirizzo.Nome FROM Classe JOIN Sezione ON Classe.Sezione = Sezione.Id JOIN Indirizzo ON Classe.Indirizzo = Indirizzo.Id;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCompetenza` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetCompetenza`(
	IN idProfessore INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT Materia.Nome AS Materia FROM Competenza JOIN Materia ON Competenza.Materia = Materia.ID
	WHERE Competenza.Professore = idProfessore;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCompiti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetCompiti`(
	IN idClasse int,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT data,Tipo,Professore.Nome as NomeProfessore,Cognome as CognomeProfessore,Materia.Nome AS Materia,Descrizione 
	FROM Compito JOIN Professore ON Compito.Professore=Professore.Id JOIN Materia ON Compito.Materia = Materia.ID
	WHERE idClasse=Classe
	order by data desc;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetIndirizzi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetIndirizzi`(
	IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT Id,Nome FROM Indirizzo;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMaterie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetMaterie`(
	IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	Select Id,Nome From Materia;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMaterieDiIndirizzo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetMaterieDiIndirizzo`(
	IN indirizzo VARCHAR(75),
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT Materia.Nome FROM Indirizzo_Materia JOIN Indirizzo ON Indirizzo_Materia.Indirizzo = Indirizzo.Id JOIN Materia ON Indirizzo_Materia.Materia = Materia.ID
	WHERE Indirizzo.Nome = indirizzo;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetNote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetNote`(
	IN idStudente int,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT data,Nome as NomeProfessore,Cognome as CognomeProfessore,Descrizione FROM Nota
	JOIN Professore ON  Nota.Professore=Professore.Id
	WHERE idStudente=Studente
	ORDER BY data desc;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProfessore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetProfessore`(
IN _sessionKey char(36),
IN _username varchar(16)
)
BEGIN
IF ((checkUserSession(_sessionKey) is not null)AND (SELECT COUNT(*) FROM Professore Where Utente=_username)!=0 ) then
	SELECT Id, Nome, Cognome,Utente, Stipendio FROM Professore Where Utente=_username;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProfessori` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetProfessori`(
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT Id, Nome, Cognome,Utente, Stipendio FROM Professore;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSezioni` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetSezioni`(
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT Id,Lettera FROM Sezione;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetStudente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetStudente`(
	IN _sessionKey char(36),
	IN _username varchar(16)
)
BEGIN
IF ((checkUserSession(_sessionKey) is not null)AND (SELECT COUNT(*) FROM Studente Where Utente=_username)!=0 ) then
	SELECT Id, Nome, Cognome,Utente, DataDiNascita,Classe FROM Studente Where Utente=_username;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetStudenti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetStudenti`(
	IN idClasse int,
	IN _sessionKey char(36)   
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT Id,Nome,Cognome,Utente,DataDiNascita,Classe FROM Studente WHERE Classe = idClasse;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetVoti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `GetVoti`(
	IN idStud INT,
    IN idMat INT,
 	IN _sessionKey char(36)    
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	SELECT Voto.Data,Voto.Voto,Professore.Nome,Professore.Cognome,Voto.Descrizione FROM Voto JOIN Materia ON Voto.Materia = Materia.ID JOIN Professore ON Voto.Professore=Professore.Id WHERE Voto.Studente=idStud AND Voto.Materia=idMat order by Voto.Data desc;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `Login`(
IN _username VARCHAR(16),
IN _pswd VARCHAR(45),
OUT _isCheck1 bit(1),
OUT _isCheck2 bit(1),
OUT _sessionkey varchar(36)
)
BEGIN

if ((SELECT User FROM Utente WHERE  user=_username) IS NULL) then 
    SET _isCheck1=0;
	SET _isCheck2=0;
    
else
    if((SELECT Utente FROM Professore JOIN Utente ON Professore.Utente=Utente.User WHERE Utente.Passwd = _pswd AND Professore.Utente=_username)IS NULL) then
		if((SELECT Utente FROM Studente JOIN Utente ON Studente.Utente=Utente.User WHERE Utente.Passwd = _pswd AND Studente.Utente=_username)IS NULL) then
			SET _isCheck1=1;
            SET _isCheck2=1;
		else
			SET _isCheck1=0;
            SET _isCheck2=1;
		end if;
	else
		SET _isCheck1=1;
        SET _isCheck2=0;
        
	end if;
    UPDATE Utente SET SessionKey = UUID() Where User=_username;
    UPDATE Utente SET LastActivity = current_timestamp() Where User=_username;
    SET _sessionkey=(SELECT SessionKey From Utente where User=_username);
    
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateCompito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `UpdateCompito`(
	IN idClasse INT,
    IN dataOttenimento DATETIME,
    IN tipoCompito VARCHAR(45),
    IN idProfessore INT,
    IN idMateria INT,
    IN descrizione VARCHAR(100),
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if(descrizione is not null) then
		UPDATE Compito SET Compito.Descrizione = descrizione WHERE Compito.Classe = idClasse AND Compito.Data = dataOttenimento AND Compito.Tipo = tipoCompito AND Compito.Professore = idProfessore AND Compito.Materia = idMateria;
	else
		signal sqlstate '45000' set message_text = 'La descrizione passatà è null';
    end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateIndirizzo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `UpdateIndirizzo`(
	IN idIndirizzo int,
    IN nomeIndirizzo varchar(75),
    IN _sessionKey char(36) 
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if(nomeIndirizzo is not null) then
		UPDATE Indirizzo SET Nome = LOWER(TRIM(nomeIndirizzo)) WHERE Indirizzo.Id = idIndirizzo;
	else
		signal sqlstate'45000' set message_text="Nome indirizzo passato è null";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateMateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `UpdateMateria`(
	IN idMateria int,
    IN nomeMateria varchar(75),
    IN _sessionKey char(36) 
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if(nomeMateria is not null) then
		UPDATE Materia SET Nome = LOWER(TRIM(nomeMateria)) WHERE Materia.Id = idMateria;
	else
		signal sqlstate'45000' set message_text="Nome materia passato è null";
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateNota` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `UpdateNota`(
	IN idStudente INT,
    IN idProfessore INT,
    IN dataProvvedimento DATETIME,
    IN descrizione VARCHAR(100),
	IN _sessionKey char(36)    
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if(dataProvvedimento is not null) then
		UPDATE Nota SET Data = dataProvvedimento WHERE Nota.Studente = idStudente AND Nota.Professore = idProfessore AND Nota.Data = Old.Nota.Data;
	else
		signal sqlstate'45000' set message_text="Data passata è null"; 
	end if;
	if(descrizione is not null) then
		UPDATE Nota SET Descrizione = descrizione WHERE Nota.Studente = idStudente AND Nota.Professore = idProfessore AND Nota.Data = dataProvvedimento;
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateProfessore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `UpdateProfessore`(
	IN username VARCHAR(16),
    IN nuovoUsername VARCHAR(16),
    IN pswd VARCHAR(45),
    IN nomeProf VARCHAR(45),
    IN cognomeProf VARCHAR(45),
    IN stipendioProf INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if((SELECT UpdateUtente(username,nuovoUsername,pswd)) = 1) then
		IF(nomeProf is not null) then 
		UPDATE Professore SET Nome = nomeProf WHERE Professore.Utente = nuovoUsername;
		end if;
		if(cognomeProf is not null) then
		UPDATE Professore SET Cognome = cognomeProf WHERE Professore.Utente = nuovoUsername;
		end if;
		if(stipendioProf is not null) then
		UPDATE Professore SET Stipendio = stipendioProf WHERE Professore.Utente = nuovoUsername;
		end if;
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateStudente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `UpdateStudente`(
	IN username VARCHAR(16),
    IN nuovoUsername VARCHAR(16),
    IN pswd VARCHAR(45),
    IN nomeStud VARCHAR(45),
    IN cognomeStud VARCHAR(45),
    IN dataDiNascitaStud DATETIME,
    IN idClasse INT,
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if((SELECT UpdateUtente(username,nuovoUsername,pswd)) = 1) then
		IF(nomeStud is not null) then 
			UPDATE Studente SET Nome = nomeStud WHERE Studente.Utente = nuovoUsername;
		end if;
		if(cognomeStud is not null) then
			UPDATE Studente SET Cognome = cognomeStud WHERE Studente.Utente = nuovoUsername;
		end if;
		if(dataDiNascitaStud is not null) then
			UPDATE Studente SET DataDiNascita = dataDiNascitaStud WHERE Studente.Utente = nuovoUsername;
		end if;
		if(idClasse is not null) then
			UPDATE Studente SET Classe = idClasse WHERE Studente.Utente = nuovoUsername;
		end if;
	end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateVoto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sa`@`%` PROCEDURE `UpdateVoto`(
	IN idStudente INT,
    IN idMateria INT,
    IN votoOttenuto DECIMAL(1,0),
    IN dataOldOttenimento DATETIME,
    IN dataNewOttenimento DATETIME,
    IN descrizione VARCHAR(100),
    IN _sessionKey char(36)
)
BEGIN
IF (checkUserSession(_sessionKey) is not null) then
	if(dataNewOttenimento is not null AND dataOldOttenimento is not null) then
		IF(dataNewOttenimento!=dataOldOttenimento) then
			UPDATE Voto SET Voto.Data = dataNewOttenimento WHERE Voto.Studente = idStudente AND Voto.Materia = idMateria AND Voto.Data = dataOldOttenimento;
		end if;
		if(votoOttenuto is not null) then
			UPDATE Voto SET Voto.Voto = votoOttenuto WHERE Voto.Studente = idStudente AND Voto.Materia = idMateria AND Voto.Data = dataNewOttenimento;
		else
			signal sqlstate'45000' set message_text="Voto passato è null";
		end if;
		if(descrizione is not null) then
			UPDATE Voto SET Voto.Descrizione = descrizione WHERE Voto.Studente = idStudente AND Voto.Materia = idMateria AND Voto.Data = dataNewOttenimento;
		end if;
	else
		signal sqlstate'45000' set message_text="Data passata è null";
    end if;
ELSE
	signal sqlstate '45000' set message_text = 'Invalid SessionKey';
end if; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-25 10:07:56
