CREATE TABLE IF NOT EXISTS violence_district (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    entered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    exited_at TIMESTAMP NULL,
    FOREIGN KEY (player_id) REFERENCES users(identifier)
);