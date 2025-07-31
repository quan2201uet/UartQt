// datamanager.cpp
#include "datamanager.h"
#include <QDebug>

DataManager::DataManager(QObject *parent) : QObject(parent) {
    serialPort = new QSerialPort(this);
    connect(serialPort, &QSerialPort::readyRead, this, &DataManager::readSerialData);
}

DataManager::~DataManager() {
    if (serialPort->isOpen()) {
        serialPort->close();
    }
    delete serialPort;
}

QString DataManager::saveData(const QString &inputData) {
    if (inputData.isEmpty()) {
        emit dataSaved("Vui lòng nhập dữ liệu");
        return "Error: Empty input";
    }
    QString result = "Văn 10, Toán 9";
    emit dataSaved(result);
    return result;
}

void DataManager::openSerialPort(const QString &portName) {
    serialPort->setPortName(portName);
    serialPort->setBaudRate(QSerialPort::Baud9600);
    serialPort->setDataBits(QSerialPort::Data8);
    serialPort->setParity(QSerialPort::NoParity);
    serialPort->setStopBits(QSerialPort::OneStop);
    serialPort->setFlowControl(QSerialPort::NoFlowControl);

    if (serialPort->open(QIODevice::ReadWrite)) {
        qDebug() << "Serial port" << portName << "opened successfully";
        emit dataSaved("Kết nối serial thành công: " + portName);
    } else {
        qDebug() << "Failed to open serial port:" << serialPort->errorString();
        emit dataSaved("Lỗi khi mở cổng serial: " + serialPort->errorString());
    }
}

void DataManager::closeSerialPort() {
    if (serialPort->isOpen()) {
        serialPort->close();
        qDebug() << "Serial port closed";
        emit dataSaved("Đã đóng cổng serial");
    }
}

void DataManager::readSerialData() {
    QByteArray data = serialPort->readAll();
    QString dataString = QString(data).trimmed();
    qDebug() << "Received serial data:" << dataString;
    emit serialDataReceived(dataString);
}
