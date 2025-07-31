// datamanager.h
#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QSerialPort>

class DataManager : public QObject {
    Q_OBJECT
public:
    explicit DataManager(QObject *parent = nullptr);
    ~DataManager();

    Q_INVOKABLE QString saveData(const QString &inputData);
    Q_INVOKABLE void openSerialPort(const QString &portName);
    Q_INVOKABLE void closeSerialPort();

signals:
    void dataSaved(const QString &message);
    void serialDataReceived(const QString &data);

private slots:
    void readSerialData();

private:
    QSerialPort *serialPort;
};

#endif // DATAMANAGER_H
