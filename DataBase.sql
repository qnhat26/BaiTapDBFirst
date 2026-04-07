-- 1. Tạo Database và sử dụng Database đó
CREATE DATABASE QuanLyBanHang;
GO

USE QuanLyBanHang;
GO

-- 2. Bảng Category (Danh mục sản phẩm)
CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX)
);
GO

-- 3. Bảng Supplier (Nhà cung cấp)
CREATE TABLE Supplier (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName NVARCHAR(255) NOT NULL,
    ContactPhone NVARCHAR(20)
);
GO

-- 4. Bảng Product (Sản phẩm)
CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(255) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    CategoryID INT,
    SupplierID INT,
    -- Khóa ngoại liên kết với Category và Supplier
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE SET NULL,
    CONSTRAINT FK_Product_Supplier FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ON DELETE SET NULL
);
GO

-- 5. Bảng Order (Đơn hàng)
-- Chữ Order là từ khóa của SQL Server nên phải đặt trong ngoặc vuông []
CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATETIME DEFAULT GETDATE(),
    CustomerName NVARCHAR(255)
);
GO

-- 6. Bảng OrderDetail (Chi tiết đơn hàng)
CREATE TABLE OrderDetail (
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL DEFAULT 1,
    UnitPrice DECIMAL(18, 2) NOT NULL,
    -- Khóa chính tổng hợp
    PRIMARY KEY (OrderID, ProductID),
    -- Khóa ngoại liên kết với Order và Product
    CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (OrderID) REFERENCES [Order](OrderID) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetail_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
);
GO