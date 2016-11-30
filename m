Content-Type: multipart/mixed; boundary="===============8440846274971720865=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH 2/7] netmon: handle OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP} in
 D-Bus
Date: Wed, 30 Nov 2016 13:13:17 +0100
Message-ID: <1480508002-15830-3-git-send-email-djalal@endocode.com>
In-Reply-To: <1480508002-15830-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8440846274971720865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle the previously added types in D-Bus.

Documentation for these values is in next patch.
---
 src/netmon.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/netmon.c b/src/netmon.c
index eb18b9c..2a8c524 100644
--- a/src/netmon.c
+++ b/src/netmon.c
@@ -180,6 +180,34 @@ void ofono_netmon_serving_cell_notify(struct ofono_net=
mon *netmon,
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

+		case OFONO_NETMON_INFO_RSCP:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "ReceivedSignalCodePower",
+					intval, uint8_t, DBUS_TYPE_BYTE);
+			break;
+
+		case OFONO_NETMON_INFO_ECN0:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "ReceivedEnergyRatio",
+					intval, uint8_t, DBUS_TYPE_BYTE);
+			break;
+
+		case OFONO_NETMON_INFO_RSRQ:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "ReferenceSignalReceivedQuality",
+					intval, uint8_t, DBUS_TYPE_BYTE);
+			break;
+
+		case OFONO_NETMON_INFO_RSRP:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "ReferenceSignalReceivedPower",
+					intval, uint8_t, DBUS_TYPE_BYTE);
+			break;
+
 		case OFONO_NETMON_INFO_INVALID:
 			break;
 		}
-- =

2.5.5


--===============8440846274971720865==--

