CREATE TABLE Accounts (
    ID int NOT NULL AUTO_INCREMENT,
    AccountName varchar(255) NOT NULL,
    EmailAddress varchar(255) NOT NULL,
    CreatedDate DATETIME,
    ApiKey varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE Users (
    ID int NOT NULL AUTO_INCREMENT,
    FirstName varchar(255) NOT NULL,
    LastName varchar(255) NOT NULL,
    EmailAddress varchar(255) NOT NULL,
    CreatedDate DATETIME,
    AccountId int NOT NULL,
    UserPassword varchar(255) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (AccountId) REFERENCES Accounts(ID)
);

CREATE TABLE FallBackUrls (
    ID int NOT NULL AUTO_INCREMENT,
    FallBackUrl varchar(255) NOT NULL,
    AccountId int NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (AccountId) REFERENCES Accounts(ID)
);

CREATE TABLE UrlExclusions (
    ID int NOT NULL AUTO_INCREMENT,
    ExcludedUrl varchar(255) NOT NULL,
    AccountId int NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (AccountId) REFERENCES Accounts(ID)
);

CREATE TABLE CustomDomains (
    ID int NOT NULL AUTO_INCREMENT,
    Domain varchar(255) NOT NULL,
    VerificationCode varchar(255),
    DomainCertificate varchar(65535) NOT NULL,
    CertificateDate DATETIME,
    Validated BOOLEAN,
    AccountId int NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (AccountId) REFERENCES Accounts(ID)
);
