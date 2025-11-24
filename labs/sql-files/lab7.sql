CREATE TABLE authors (
  author_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birth_date DATE
);

CREATE TABLE books (
  book_id SERIAL PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  isbn VARCHAR(13) UNIQUE,
  publication_year INTEGER,
  available_copies INTEGER DEFAULT 1
);

CREATE TABLE book_authors (
  book_id INTEGER,
  author_id INTEGER,
  PRIMARY KEY (book_id, author_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE TABLE members (
  member_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(15),
  membership_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE loans (
  loan_id SERIAL PRIMARY KEY,
  member_id INTEGER NOT NULL,
  book_id INTEGER NOT NULL,
  loan_date DATE DEFAULT CURRENT_DATE,
  due_date DATE NOT NULL,
  return_date DATE,
  late_fee DECIMAL(10,2) DEFAULT 0.00,
  FOREIGN KEY (member_id) REFERENCES members(member_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id)
);
