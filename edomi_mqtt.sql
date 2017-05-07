DELIMITER ;
USE edomiLive;
DROP PROCEDURE IF EXISTS mqtt_publish;
DROP TRIGGER IF EXISTS mqtt_insert_trigger;
DROP TRIGGER IF EXISTS mqtt_update_trigger;
DELIMITER $$
CREATE PROCEDURE mqtt_publish(typ CHAR(255), ga CHAR(255), name CHAR(255), value CHAR(255))
BEGIN
 DECLARE cmd CHAR(255);
 DECLARE result CHAR(255);
 SET cmd = CONCAT('/usr/bin/php /usr/local/edomi/www/admin/lbs/mqtt.php ',typ,' ',ga,' "',name,'" "',value,'"');
 SET result = sys_exec(cmd);
END;
$$
DELIMITER ;
CREATE TRIGGER mqtt_insert_trigger AFTER INSERT ON RAMko FOR EACH ROW CALL mqtt_publish(NEW.gatyp, NEW.ga, NEW.name, NEW.value);
CREATE TRIGGER mqtt_update_trigger AFTER UPDATE ON RAMko FOR EACH ROW CALL mqtt_publish(NEW.gatyp, NEW.ga, NEW.name, NEW.value);
