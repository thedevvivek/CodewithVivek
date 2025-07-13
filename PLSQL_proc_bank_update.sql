create table bank_details (
account_no numeric(20),
full_name varchar(45),
mobile_number numeric(15),
adhaar numeric(20),
pan varchar(10),
address varchar(30)
);

insert into bank_details values(203048913,'Vivek Kumar',987654321,487257878285,'ASKJ2495','Hyderabad')
insert into bank_details values(37827245,'Amit Patel',8478357887,84787583758,'AJDH64J','Bihar')
insert into bank_details values(377633758,'Ritika',77358563757,84637537837,'AJHFUHF534','Mumbai')
insert into bank_details values(377633758,'Singh',NULL,NULL,NULL,'Mumbai')

select * from bank_details;

CREATE OR REPLACE PROCEDURE proc_bank(
    p_account_no NUMERIC,
    p_activity VARCHAR,
    p_new_data VARCHAR
)
LANGUAGE plpgsql
AS
$$
DECLARE
    v_length INTEGER;
    v_count NUMERIC;
    p_message VARCHAR(100);
BEGIN
    -- Check if account exists
    SELECT COUNT(1)
    INTO v_count
    FROM bank_details
    WHERE account_no = p_account_no;

    IF v_count <> 0 THEN

        IF p_activity = 'ADDRESS' THEN
            SELECT LENGTH(p_new_data)
            INTO v_length;

            IF v_length <= 30 THEN
                UPDATE bank_details
                SET address = p_new_data
                WHERE account_no = p_account_no;

                p_message := 'Your address updated successfully';
                RAISE NOTICE '%', p_message;
            ELSE
                p_message := 'Address length should be 30 characters or less';
                RAISE NOTICE '%', p_message;
            END IF;

        ELSIF p_activity = 'MOBILE' THEN
            SELECT LENGTH(p_new_data)
            INTO v_length;

            IF v_length <= 10 THEN
                UPDATE bank_details
                SET mobile_number = p_new_data
                WHERE account_no = p_account_no;

                p_message := 'Your mobile number updated successfully';
                RAISE NOTICE '%', p_message;
            ELSE
                p_message := 'Your Mobile is Invalid';
                RAISE NOTICE '%', p_message;
            END IF;

        ELSIF p_activity = 'Adhaar' THEN
            SELECT LENGTH(p_new_data)
            INTO v_length;

            IF v_length = 12 THEN
                UPDATE bank_details
                SET adhaar = p_new_data
                WHERE account_no = p_account_no;

                p_message := 'Your adhaar updated successfully';
                RAISE NOTICE '%', p_message;
            ELSE
                p_message := 'Adhaar number is Invalid';
                RAISE NOTICE '%', p_message;
            END IF;

        ELSIF p_activity = 'PAN' THEN
            SELECT LENGTH(p_new_data)
            INTO v_length;

            IF v_length = 10 THEN
                UPDATE bank_details
                SET pan = p_new_data
                WHERE account_no = p_account_no;

                p_message := 'Your PAN updated successfully';
                RAISE NOTICE '%', p_message;
            ELSE
                p_message := 'PAN number is Invalid';
                RAISE NOTICE '%', p_message;
            END IF;

        ELSE
            p_message := 'Invalid UPDATE Activity Specified';
            RAISE NOTICE '%', p_message;
        END IF;

    ELSE
        p_message := 'Account Number is Invalid';
        RAISE NOTICE '%', p_message;
    END IF;
	
EXCEPTION
    WHEN OTHERS THEN
        p_message := 'Connect with IT team, Sorry for Inconvenience';
        RAISE NOTICE '%', p_message;
END;
$$;



select * from bank_details;
CALL proc_bank(203048913, 'PAN', 'ABCDE12345');

call proc_bank(377633758,'ADDRESS','Delhi')







