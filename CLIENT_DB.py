import psycopg2
from psycopg2.sql import SQL, Identifier

'''
Функция, создающая структуру базы данных
'''
def create_db(conn):
    with conn.cursor() as cur:
        cur.execute('''
            CREATE TABLE IF NOT EXISTS client(
                id SERIAL PRIMARY KEY,
                name VARCHAR(60) NOT NULL,
                surname VARCHAR(60) NOT NULL,
                email VARCHAR(60) UNIQUE NOT NULL,
                CONSTRAINT proper_email CHECK (email ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
            );
        ''')

        cur.execute('''
            CREATE TABLE IF NOT EXISTS phones(
                id SERIAL PRIMARY KEY,
                phone INTEGER UNIQUE NOT NULL,
                client_id INTEGER NOT NULL REFERENCES client(id) ON DELETE CASCADE
            );
        ''')
        conn.commit()

'''
Функция, позволяющая добавить нового клиента
'''
def add_client(name, surname, email):
    with conn.cursor() as cur:
        cur.execute('''
            SELECT email FROM client
            WHERE email = %s;
            ''', (email,))
        if len(cur.fetchall()) > 0:
            print('Клиент с таким email уже существует')
            return

    with conn.cursor() as cur:
        cur.execute('''
            INSERT INTO client(name, surname, email)
            VALUES (%s, %s, %s) RETURNING id;
            ''', (name, surname, email))
        print(f'ID созданного клиента: {cur.fetchone()}')

'''
Функция, позволяющая добавить телефон для существующего клиента
'''
def add_phone(phone, client_id):
    with conn.cursor() as cur:
        cur.execute('''
            SELECT phone FROM phones
            WHERE phone = %s;
            ''', (phone,))
        if len(cur.fetchall()) > 0:
            print('Клиент с таким номером уже существует')
            return

    with conn.cursor() as cur:
        cur.execute('''
            SELECT id FROM client
            WHERE id = %s;
            ''', (client_id,))
        if len(cur.fetchall()) == 0:
            print('Указанный клиент отсутствует в базе')
            return

    with conn.cursor() as cur:
        cur.execute('''
            INSERT INTO phones(phone, client_id)
            VALUES (%s, %s) RETURNING id;
            ''', (phone, client_id))
        print(f'ID созданной записи телефона: {cur.fetchone()}')

'''
Функция, позволяющая изменить данные о клиенте
'''
def update_client(client_id, name=None, surname=None, email=None):
    with conn.cursor() as cur:
        cur.execute('''
            SELECT id FROM client
            WHERE id = %s;
            ''', (client_id,))
        if len(cur.fetchall()) == 0:
            print('Клиента с таким ID не существует')
            return

    atributes_client = {'name': name, 'surname': surname, 'email': email}

    for key, value in atributes_client.items():
        if value:
            with conn.cursor() as cur:
                cur.execute(SQL("UPDATE client SET {} = %s WHERE id = %s").format(Identifier(key)), (value, client_id))
                conn.commit()

    with conn.cursor() as cur:
        cur.execute('''
            SELECT id, name, surname, email FROM client
            WHERE id=%s;
            ''', (client_id,))
        print(f'Обновленная запись клиента: {cur.fetchone()}')

'''
Функция, позволяющая удалить телефон для существующего клиента
'''
def delete_phone(client_id, phone):
    with conn.cursor() as cur:
        cur.execute('''
            SELECT phone FROM phones
            WHERE client_id=%s AND phone=%s;
            ''', (client_id, phone))
        if len(cur.fetchall()) == 0:
            print('Клиента с таким телефоном не существует')
            return

    with conn.cursor() as cur:
        cur.execute('''
            DELETE FROM phones
            WHERE client_id=%s AND phone=%s;
            ''', (client_id, phone))
        conn.commit()
        print(f'Телефон {phone} у клиента {client_id} удален')

'''
Функция, позволяющая удалить существующего клиента
'''
def delete_client(client_id):
    with conn.cursor() as cur:
        cur.execute('''
            SELECT id FROM client
            WHERE id=%s;
            ''', (client_id,))
        if len(cur.fetchall()) == 0:
            print('Клиента с таким ID не существует')

    with conn.cursor() as cur:
        cur.execute('''
            DELETE FROM client
            WHERE id=%s;
            ''', (client_id,))
        print(f'Клиент {client_id} и его телефоны удалены')

'''
Функция, позволяющая найти клиента по его данным: имени, фамилии, email или телефону
'''
def find_client(name = None, surname = None, email = None, phone = None):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT client.*, phones.phone FROM client 
            JOIN phones ON client.id = phones.client_id
            WHERE (name = %(name)s OR %(name)s IS NULL) 
                AND (surname = %(surname)s OR %(surname)s IS NULL)
                AND (email = %(email)s OR %(email)s IS NULL)
                AND (phone = %(phone)s OR %(phone)s IS NULL);
            """, {'name':name, 'surname':surname, 'email':email, 'phone':phone})
        print(f'Найденная запись клиента:', cur.fetchall())

if __name__ == '__main__':
    with psycopg2.connect(database='client_db', user='postgres', password='postgres') as conn:
        create_db(conn)
        add_client('Иван', 'Иванов', 'ivan@mail.ru')
        add_client('Петр', 'Петров', 'petr@mail.ru')
        add_client('Максим', 'Максимов', 'maxim@mail.ru')
        add_phone(1, 1)
        add_phone(2, 2)
        add_phone(3, 3)
        update_client(1, 'Семен', surname=None, email=None)
        delete_phone(3, 3)
        delete_client(1)
        find_client(None, None, None, 3)