import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import com.example.backend 1.0

ApplicationWindow {
    visible: true
    width: 600
    height: 300
    title: "Qt Quick Navigation App"

    property int selectedOption: 0

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            height: 50
            spacing: 0

            Button {
                text: "Option 1"
                Layout.fillWidth: true
                onClicked: selectedOption = 0
                background: Rectangle { color: selectedOption === 0 ? "#4CAF50" : "#DDDDDD" }
            }
            Button {
                text: "Option 2"
                Layout.fillWidth: true
                onClicked: selectedOption = 1
                background: Rectangle { color: selectedOption === 1 ? "#4CAF50" : "#DDDDDD" }
            }
            Button {
                text: "Option 3"
                Layout.fillWidth: true
                onClicked: selectedOption = 2
                background: Rectangle { color: selectedOption === 2 ? "#4CAF50" : "#DDDDDD" }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#F5F5F5"

            Loader {
                id: contentLoader
                anchors.fill: parent
                sourceComponent: {
                    if (selectedOption === 0) return content1
                    if (selectedOption === 1) return content2
                    if (selectedOption === 2) return content3
                }
            }
        }
    }

    Component {
        id: content1
        Rectangle {
            color: "#FFCDD2"
            Text {
                anchors.centerIn: parent
                text: "Nội dung của Option 1"
                font.pixelSize: 24
            }
        }
    }

    Component {
        id: content2
        Item {
            anchors.fill: parent
            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                Text {
                    text: "Nhập cổng serial và dữ liệu"
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter
                }

                Label {
                    text: "Tên cổng serial (VD: COM3 hoặc /dev/ttyUSB0)"
                    Layout.alignment: Qt.AlignHCenter
                }

                TextField {
                    id: portInput
                    placeholderText: "Nhập tên cổng serial"
                    Layout.fillWidth: true
                    Layout.preferredWidth: 200
                    text: "COM3" // Thay đổi tùy hệ thống
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Button {
                        text: "Mở cổng"
                        onClicked: dataManager.openSerialPort(portInput.text)
                    }
                    Button {
                        text: "Đóng cổng"
                        onClicked: dataManager.closeSerialPort()
                    }
                }

                Label {
                    text: "Nhập dữ liệu để lưu"
                    Layout.alignment: Qt.AlignHCenter
                }

                TextField {
                    id: dataInput
                    placeholderText: "Nhập dữ liệu tại đây"
                    Layout.fillWidth: true
                    Layout.preferredWidth: 200
                }

                Button {
                    id: saveData
                    text: "Lưu"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        var result = dataManager.saveData(dataInput.text)
                        dataInput.text = ""
                    }
                }

                Label {
                    id: message
                    text: ""
                    Layout.alignment: Qt.AlignHCenter
                }

                Label {
                    id: serialMessage
                    text: "Dữ liệu serial: "
                    Layout.alignment: Qt.AlignHCenter
                }

                Connections {
                    target: dataManager
                    function onDataSaved(msg) {
                        message.text = msg
                    }
                    function onSerialDataReceived(data) {
                        serialMessage.text = "Dữ liệu serial: " + data
                    }
                }
            }
        }
    }

    Component {
        id: content3
        Rectangle {
            color: "#BBDEFB"
            Text {
                anchors.centerIn: parent
                text: "Nội dung của Option 3"
                font.pixelSize: 24
            }
        }
    }
}
