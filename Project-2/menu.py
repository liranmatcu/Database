import sys
import book_dao

menu_options = {
    1: 'Add a Publisher',
    2: 'Add a Book',
    3: 'Edit a Book',
    # More options to be added
    5: 'Search Books',
    6: 'Exit',
}

search_menu_options = {
    # To be added
}

def search_all_books():
    # Use a data access object (DAO) to 
    # abstract the retrieval of data from 
    # a data resource such as a database.
    results = book_dao.findAll()

    # Display results
    print("The following are the ISBNs and titles of all books.")
    for item in results:
        print(item['ISBN'], item['title'])
    print("The end of books.")
    

def search_by_title():
    title = input("What is the exact book title that you are looking for?\n")
    results = list(book_dao.findByTitle(title))
    # Display results
    if len(results) != 0:
        print("We found the following matching titles for you.")
        for item in results:
            print(item['ISBN'], item['title'])
    else:
        print("The title you wanted does not exist in our database.")
    print("The end.")


def print_menu():
    print()
    print("Please make a selection")
    for key in menu_options.keys():
        print (str(key)+'.', menu_options[key], end = "  ")
    print()
    print("The end of top-level options")
    print()


def option1():
    print('Handle option \'Option 1\'')


def option2():
    print('Handle option \'Option 2\'')


def option5():
    # A sub-menu shall be printed
    # and prompt user selection

    # print_search_menu

    # user selection of options and actions

    # Assume the option: search all books was chosen
    print("Search Option 1: all books were chosen.")
    search_all_books()
    search_by_title()



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
            exit()
        else:
            print('Invalid option. Please enter a number between 1 and 6.')











