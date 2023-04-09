CREATE TABLE User (
  UserId INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Login VARCHAR(255) NOT NULL,
  CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT unique_user_name UNIQUE (Name),
  CONSTRAINT unique_user_login UNIQUE (Login)
);

CREATE TABLE Todo (
  TodoId INT PRIMARY KEY,
  UserId INT NOT NULL,
  Title VARCHAR(255) NOT NULL,
  Description TEXT,
  DueDate TIMESTAMP,
  OriginalDueDate TIMESTAMP,
  CompletedDate TIMESTAMP,
  DurationMinutes INT,
  CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (UserId) REFERENCES User(UserId)
);

CREATE TABLE UserActivity (
  ActivityId INT PRIMARY KEY,
  UserId INT NOT NULL,
  ActivityType VARCHAR(255) NOT NULL,
  CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (UserId) REFERENCES User(UserId)
);

CREATE TABLE Notification (
  NotificationId INT PRIMARY KEY,
  TodoId INT NOT NULL,
  NotificationType VARCHAR(64),
  NotificationSchedule VARCHAR(64),
  Message TEXT NOT NULL,
  CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (TodoId) REFERENCES Todo(TodoId)
);

CREATE TABLE UserConnection (
  UserId INT NOT NULL,
  ConnectionUserId INT NOT NULL,
  CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (UserId) REFERENCES User(UserId),
  FOREIGN KEY (ConnectionUserId) REFERENCES User(UserId),
  CONSTRAINT unique_connection UNIQUE (UserId, ConnectionUserId)
);
