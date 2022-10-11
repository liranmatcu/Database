import sys
from mysql_connector import connection

menu_options = {
    1: 'Add a Publisher',
    2: 'Add a Book',
    3: 'Edit a Book',
    # More options to be added
    5: 'Search Books',
    6: 'Exit',
}

def print_menu():
    print()
    print("Please make a selection")
    for key in menu_options.keys():
        print (key, '--', menu_options[key])
    print("The end of options")
    print()

def option1():
    print('Handle option \'Option 1\'')

def option2():
    print('Handle option \'Option 2\'')

def option5():
    # A sub-menu may be needed
    cursor = connection.cursor()
    query = "select * from bookmanager.Book"
    cursor.execute(query)
    results = cursor.fetchall()
    # print(results)
    
    print("The following are the all books.")
    for item in results:
        print(item[1])
    print("The end of all books.")


if __name__=='__main__':
    while(True):
        print_menu()
        option = ''
        try:
            option = int(input('Enter your choice: '))
        except KeyboardInterrupt:
            print('Interrupted')
            sys.exit(0)
        except:
            print('Wrong input. Please enter a number ...')

        # Check what choice was entered and act accordingly
        if option == 1:
           option1()
        elif option == 2:
            option2()
        # More options to be added
        elif option == 5:
            option5()
        elif option == 6:
            print('Thanks your for using our database services! Bye')
            connection.close()
            exit()
        else:
            print('Invalid option. Please enter a number between 1 and 6.')











