import UIKit

// 1. შევქმნათ Class Book.
//Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
//Designated Init.

class Book {
    let bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String, isBorrowed: Bool) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    //Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
    func bookIsBorrowed() {
        if !isBorrowed {
            isBorrowed = true
        }
    }
    //Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს.
    func bookIsReturned() {
        if isBorrowed {
            !isBorrowed
        }
    }
}

//შევქმნათ Class Owner
//Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
//Designated Init.

class Owner {
    let ownerId: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(ownerId: Int, name: String, borrowedBooks: [Book]) {
        self.ownerId = ownerId
        self.name = name
        self.borrowedBooks = borrowedBooks
    }
    
    //Method რომეიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
    func borrowBook(from library: [Book], bookId: Int) {
        if let bookIndex = library.firstIndex(where: { $0.bookID == bookId && !$0.isBorrowed }) {
            let bookToBorrow = library[bookIndex]
            bookToBorrow.isBorrowed = true
            borrowedBooks.append(bookToBorrow)
            print("წიგნი სახელად \(bookToBorrow.title) გადაიცა წარმატებით")
        } else {
            print("წიგნი არ არის თავისუფალი")
        }
    }
    
    //Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი.
    func returnBook(bookId: Int) {
        if let bookIndex = borrowedBooks.firstIndex(where: { $0.bookID == bookId }) {
            borrowedBooks[bookIndex].isBorrowed = false
            borrowedBooks.remove(at: bookIndex)
            print("წიგნი ბიბლიოთეკაში დაბრუნდა წარმატებით")
        } else {
            print("თქვენ არ წაგიღიათ ეს წიგნი :O")
        }
    }
}


//შევქმნათ Class Library
//
//Properties: Books Array, Owners Array.
//Designated Init.
class Library {
    var books: [Book]
    var owners: [Owner]
    
    init(books: [Book] = [], owners: [Owner] = []) {
        self.books = books
        self.owners = owners
    }
    
    //Method წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნეsბით. +
    func addBookToBiblioteca(book: Book) {
        books.append(book)
    }
    
    //Method რომელიც ბიბლიოთეკაში ამატებს Owner-ს. +
    func addOwner(owner: Owner) {
        owners.append(owner)
    }
    
    //Method რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს. +
    func availableBooks(bookList: [Book]) {
        let availableBooks = books.filter { !$0.isBorrowed }
        
        if availableBooks.isEmpty {
            print("ბიბლიოთეკაში არ არსებობს ხელმისაწვდომი წიგნები")
        } else {
            print("ბიბლიოთეკაში თავისუფალი/ხელმისაწვდომი წიგნებია")
            for book in availableBooks {
                print("სათაური: \(book.title)")
                print("ავტორი: \(book.author)")
                print("წიგნის იდენთიფიკატორი: \(book.bookID)")
                print("📖📖📖📖📖📖📖📖📖📖")
            }
        }
    }
    
    //Method რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს. +
    func unavailableBooks(bookList: [Book]) {
        let unavailableBooks = books.filter { $0.isBorrowed }
        
        if unavailableBooks.isEmpty {
            print("ბიბლიოთეკაში ყველა წიგნი ხელმისაწვდომია, გაეცანით სიას")
        } else {
            print("ბიბლიოთეკიდან გატანილია შემდეგი წიგნები")
            for book in unavailableBooks {
                print("სათაური: \(book.title)")
                print("ავტორი: \(book.author)")
                print("წიგნის იდენთიფიკატორი: \(book.bookID)")
                print("📖📖📖📖📖📖📖📖📖📖")
            }
        }
        
    }
    //Method რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს. +
    func findOwner(with ownerId: Int) -> Owner? {
        for owner in owners {
            if owner.ownerId == ownerId {
                return owner
            }
        }
        return nil
    }
    //Method რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ. +
    func findBook(with id: Int) {
        if let owner = findOwner(with: id) {
            if owner.borrowedBooks.isEmpty {
                print("პიროვნებას იდენთიფიკატორით:\(id)-ს არ აქვს წიგნები გატანილი ბიბლიოთეკიდან")
            } else {
                print("პიროვნებას იდენთიფიკატორით \"\(id)\" გატანილი აქვს შემდეგი წიგნენი/წიგნები 📚:")
                for (index, book) in owner.borrowedBooks.enumerated() {
                    let bookNumber = index + 1
                    print("\(bookNumber)) სათაური: \(book.title) - ავტორი: \(book.author)")
                    print("\n")
                }
            }
        } else {
            print("მფლობელი ამ ინდენთიფიკატორით (\(id)) არ მოიძებნა")
        }
    }
    
    //Method რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია. +
    func takeBookOut(of bookInLibrary: [Book], by owner: Owner, book: Book, id: Int) {
        if !book.isBorrowed {
            // The book is available, so borrow it
            owner.borrowBook(from: bookInLibrary, bookId: id)
            print("წიგნი \(book.title) გადაეცა \(owner.name)ს")
            print("\n")
        } else {
            print("წიგნი სახელად \(book.title) უკვე აღებულია")
        }
    }
    
    //Method რომელიც მე შევქმენი რომ დამებრუნებინა წიგნების რაღაც ნაწილი
    func takeBookIn(to bookInLibrary: [Book], by owner: Owner, book: Book, bookId: Int) {
        if book.isBorrowed {
            owner.returnBook(bookId: bookId)
            print("წიგნი \(book.title) ბიბლიოთეკაში წარმატებით დაბრუნდა \(owner.name)ს მიერ")
            print("\n")
        } else {
            print("წიგნი სახელად \(book.title) არ აგიღიათ")
        }
    }
}

//შევქმნათ რამოდენიმე წიგნი და რამოდენიმე Owner-ი, შევქმნათ ბიბლიოთეკა.
//დავამატოთ წიგნები და Owner-ები ბიბლიოთეკაში
//წავაღებინოთ Owner-ებს წიგნები და დავაბრუნებინოთ რაღაც ნაწილი.
//დავბეჭდოთ ინფორმაცია ბიბლიოთეკიდან წაღებულ წიგნებზე, ხელმისაწვდომ წიგნებზე და გამოვიტანოთ წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ.

var books: [Book] = [
    Book(bookID: 1, title: "ძმები კარამაზოვები", author: "ფიოდორ დოსტოევსკი", isBorrowed: true),
    Book(bookID: 2, title: "ანა კარენინა", author: "ლევ ტოლსტოი", isBorrowed: false),
    Book(bookID: 3, title: "დიდოსტატის მარჯვენა", author: "კონსტანტინე გამსახურდია", isBorrowed: true),
    Book(bookID: 4, title: "ტრიუმფალური თაღი", author: "ერიხ მარია რემარკი", isBorrowed: false),
    Book(bookID: 5, title: "დორიან გრეის პორტრეტი", author: "ოსკარ უაილდი", isBorrowed: true)
]

var owners: [Owner] = [
    Owner(ownerId: 001, name: "ლუკა მწიგნობართუხუცესი", borrowedBooks: [books[0]]),
    Owner(ownerId: 002, name: "მარიამ ბევრიწიგნიშვილი", borrowedBooks: [books[2], books[4]]),
    Owner(ownerId: 003, name: "გიორგი წიგნიწაღებიძე", borrowedBooks: [])
]

var biblioteca = Library(books: books, owners: owners)

// წავაღებინოთ Owner-ებს წიგნები
biblioteca.takeBookOut(of: books, by: owners[2], book: books[1], id: 2)
biblioteca.takeBookOut(of: books, by: owners[0], book: books[3], id: 4)
//biblioteca.findBook(with: 001)
//biblioteca.findBook(with: 003)

// დავაბრუნებინოთ რაღაც ნაწილი.
biblioteca.takeBookIn(to: books, by: owners[1], book: books[2], bookId: 3)
biblioteca.takeBookIn(to: books, by: owners[0], book: books[0], bookId: 1)

//ინფორმაცია ბიბლიოთეკიდან წაღებული წიგენის შესახებ
biblioteca.availableBooks(bookList: books)
print("\n")

// ინფორმაცია ბიბლიოთეკიდან ხელმისაწვდომ წიგნებზე
biblioteca.unavailableBooks(bookList: books)
print("\n")

// გამოვიტანოთ წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ
biblioteca.findBook(with: 002)



