CREATE DATABASE ekseroomzadev;

USE ekseroomzadev;

CREATE TABLE residences (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    campus VARCHAR(100),
	university VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
    student_number VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    residence_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (residence_id) REFERENCES residences(id)
    ON DELETE SET NULL
);


CREATE TABLE listings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    seller_id INT NOT NULL,
    residence_id INT,
    status ENUM('available', 'sold') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (seller_id) REFERENCES users(id)
    ON DELETE CASCADE,
    
    FOREIGN KEY (residence_id) REFERENCES residences(id)
    ON DELETE SET NULL
);


CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT NOT NULL,
    buyer_id INT NOT NULL,
    status ENUM('pending', 'accepted', 'completed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (listing_id) REFERENCES listings(id)
    ON DELETE CASCADE,
    
    FOREIGN KEY (buyer_id) REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    listing_id INT,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (sender_id) REFERENCES users(id)
    ON DELETE CASCADE,
    
    FOREIGN KEY (receiver_id) REFERENCES users(id)
    ON DELETE CASCADE,
    
    FOREIGN KEY (listing_id) REFERENCES listings(id)
    ON DELETE SET NULL
);

-- Auckland Park Kingsway (APK) Campus Residences
INSERT INTO residences (name, campus, university) VALUES
('Cornerstone Male Residence', 'APK', 'University of Johannesburg'),
('Horizon Female Residence', 'APK', 'University of Johannesburg'),
('Jabali Male Day-House', 'APK', 'University of Johannesburg'),
('Falcons Male Day-House', 'APK', 'University of Johannesburg'),
('Akani Female Day-House', 'APK', 'University of Johannesburg'),
('Azania Female Day-House', 'APK', 'University of Johannesburg');

-- Auckland Park Bunting Road (APB) Campus Residences
INSERT INTO residences (name, campus, university) VALUES
('Broadcast Court Mixed Senior Residence', 'APB', 'University of Johannesburg'),
('Goudstad Flats Post-graduates Residence', 'APB', 'University of Johannesburg'),
('Horison Ladies’ Residence', 'APB', 'University of Johannesburg'),
('Majuba Men’s Residence', 'APB', 'University of Johannesburg'),
('Panorama Ladies’ Residence', 'APB', 'University of Johannesburg'),
('Ikhayalethu Day-House', 'APB', 'University of Johannesburg');

-- Doornfontein (DFC) Campus Residences
INSERT INTO residences (name, campus, university) VALUES
('Ndlovukazi Ladies’ Residence', 'DFC', 'University of Johannesburg'),
('Ntwane Men’s Residence', 'DFC', 'University of Johannesburg'),
('Kopano Mixed Residence', 'DFC', 'University of Johannesburg'),
('Mafikeng Day-House', 'DFC', 'University of Johannesburg');

-- Soweto (SWC) Campus Residences
INSERT INTO residences (name, campus, university) VALUES
('Lesedi Ladies’ Residence', 'SWC', 'University of Johannesburg'),
('Ubuntu Men’s Residence', 'SWC', 'University of Johannesburg'),
('Thuthuka Mixed Residence', 'SWC', 'University of Johannesburg');
