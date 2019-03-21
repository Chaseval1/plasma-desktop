/*
 * Copyright 2015 (C) Martin Klapetek <mklapetek@kde.org>
 * Copyright 2019 (C) Kai Uwe Broulik <kde@privat.broulik.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in  14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */

import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 2.2 as QtControls
import org.kde.kirigami 2.4 as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore

import org.kde.plasma.private.notifications 1.0

Item {
    id: monitorPanel

    property int baseUnit: Kirigami.Units.gridUnit// Math.round(Kirigami.Units.gridUnit / 1.5)

    implicitWidth: baseUnit * 13 + baseUnit * 2
    implicitHeight: (screenRatio * baseUnit * 13) + (baseUnit * 2) + basePart.height

    //flat: true

    property int selectedPosition
    property var disabledPositions: []
    property real screenRatio: Screen.height / Screen.width

    onEnabledChanged: {
        if (!enabled) {
            positionRadios.current = null
        }

        selectedPosition = NotificationsHelper.Default
    }

    PlasmaCore.Svg {
        id: monitorSvg
        imagePath: "widgets/monitor"
    }

    PlasmaCore.SvgItem {
        id: topleftPart
        anchors {
            left: parent.left
            top: parent.top
        }
        svg: monitorSvg
        elementId: "topleft"
        width: baseUnit
        height: baseUnit
    }

    PlasmaCore.SvgItem {
        id: topPart
        anchors {
            top: parent.top
            left: topleftPart.right
            right: toprightPart.left
        }
        svg: monitorSvg
        elementId: "top"
        height: baseUnit
    }

    PlasmaCore.SvgItem {
        id: toprightPart
        anchors {
            right: parent.right
            top: parent.top
        }
        svg: monitorSvg
        elementId: "topright"
        width: baseUnit
        height: baseUnit
    }

    PlasmaCore.SvgItem {
        id: leftPart
        anchors {
            left: parent.left
            top: topleftPart.bottom
            bottom: bottomleftPart.top
        }
        svg: monitorSvg
        elementId: "left"
        width: baseUnit
    }

    PlasmaCore.SvgItem {
        id: rightPart
        anchors {
            right: parent.right
            top: toprightPart.bottom
            bottom: bottomrightPart.top
        }
        svg: monitorSvg
        elementId: "right"
        width: baseUnit
    }

    PlasmaCore.SvgItem {
        id: bottomleftPart
        anchors {
            left: parent.left
            bottom: basePart.top
        }
        svg: monitorSvg
        elementId: "bottomleft"
        width: baseUnit
        height: baseUnit
    }

    PlasmaCore.SvgItem {
        id: bottomPart
        anchors {
            bottom: basePart.top
            left: bottomleftPart.right
            right: bottomrightPart.left
        }
        svg: monitorSvg
        elementId: "bottom"
        height: baseUnit
    }

    PlasmaCore.SvgItem {
        id: bottomrightPart
        anchors {
            right: parent.right
            bottom: basePart.top
        }
        svg: monitorSvg
        elementId: "bottomright"
        width: baseUnit
        height: baseUnit
    }

    PlasmaCore.SvgItem {
        id: basePart
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: 120
        height: 60
        svg: monitorSvg
        elementId: "base"
    }

    QtControls.ButtonGroup {
        id: positionRadios
    }

    /*QtControls.ExclusiveGroup {
        id: positionRadios

        onCurrentChanged: {
            monitorPanel.selectedPosition = current.position;
        }
    }*/

    QtControls.RadioButton {
        anchors {
            top: topPart.bottom
            left: leftPart.right
            margins: Kirigami.Units.smallSpacing
        }
        readonly property int position: NotificationsHelper.TopLeft
        checked: monitorPanel.selectedPosition == position
        visible: monitorPanel.disabledPositions.indexOf(position) == -1
        QtControls.ButtonGroup.group: positionRadios
    }
    QtControls.RadioButton {
        anchors {
            top: topPart.bottom
            horizontalCenter: topPart.horizontalCenter
            margins: Kirigami.Units.smallSpacing
        }
        readonly property int position: NotificationsHelper.TopCenter
        checked: monitorPanel.selectedPosition == position
        visible: monitorPanel.disabledPositions.indexOf(position) == -1
        QtControls.ButtonGroup.group: positionRadios
    }
    QtControls.RadioButton {
        anchors {
            top: topPart.bottom
            right: rightPart.left
            margins: Kirigami.Units.smallSpacing
        }
        readonly property int position: NotificationsHelper.TopRight
        checked: monitorPanel.selectedPosition == position
        visible: monitorPanel.disabledPositions.indexOf(position) == -1
        QtControls.ButtonGroup.group: positionRadios
    }
    QtControls.RadioButton {
        anchors {
            left: leftPart.right
            verticalCenter: leftPart.verticalCenter
            margins: Kirigami.Units.smallSpacing
        }
        readonly property int position: NotificationsHelper.Left
        checked: monitorPanel.selectedPosition == position
        visible: monitorPanel.disabledPositions.indexOf(position) == -1
        QtControls.ButtonGroup.group: positionRadios
    }
    QtControls.RadioButton {
        anchors {
            horizontalCenter: topPart.horizontalCenter
            verticalCenter: leftPart.verticalCenter
            margins: Kirigami.Units.smallSpacing
        }
        readonly property int position: NotificationsHelper.Center
        checked: monitorPanel.selectedPosition == position
        visible: monitorPanel.disabledPositions.indexOf(position) == -1
        QtControls.ButtonGroup.group: positionRadios
    }
    QtControls.RadioButton {
        anchors {
            right: rightPart.left
            verticalCenter: rightPart.verticalCenter
            margins: Kirigami.Units.smallSpacing
        }
        readonly property int position: NotificationsHelper.Right
        checked: monitorPanel.selectedPosition == position
        visible: monitorPanel.disabledPositions.indexOf(position) == -1
        QtControls.ButtonGroup.group: positionRadios
    }
    QtControls.RadioButton {
        anchors {
            bottom: bottomPart.top
            left: leftPart.right
            margins: Kirigami.Units.smallSpacing
        }
        readonly property int position: NotificationsHelper.BottomLeft
        checked: monitorPanel.selectedPosition == position
        visible: monitorPanel.disabledPositions.indexOf(position) == -1
        QtControls.ButtonGroup.group: positionRadios
    }
    QtControls.RadioButton {
        anchors {
            bottom: bottomPart.top
            horizontalCenter: bottomPart.horizontalCenter
            margins: Kirigami.Units.smallSpacing
        }
        readonly property int position: NotificationsHelper.BottomCenter
        checked: monitorPanel.selectedPosition == position
        visible: monitorPanel.disabledPositions.indexOf(position) == -1
        QtControls.ButtonGroup.group: positionRadios
    }
    QtControls.RadioButton {
        anchors {
            bottom: bottomPart.top
            right: rightPart.left
            margins: Kirigami.Units.smallSpacing
        }
        readonly property int position: NotificationsHelper.BottomRight
        checked: monitorPanel.selectedPosition == position
        visible: monitorPanel.disabledPositions.indexOf(position) == -1
        QtControls.ButtonGroup.group: positionRadios
    }
}
