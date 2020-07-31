Content-Type: multipart/mixed; boundary="===============0657793163549019564=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: [PATCHv2 1/3] netmon: added PCI, TAC, SNR value
Date: Fri, 31 Jul 2020 11:20:38 +0900
Message-ID: <20200731022038.18876-1-wjs890204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0657793163549019564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To support cell type LTE, the value of PCI, TAC, SNR is added
---
 include/netmon.h |  3 +++
 src/netmon.c     | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/netmon.h b/include/netmon.h
index a99d6ca9..53f9d393 100644
--- a/include/netmon.h
+++ b/include/netmon.h
@@ -72,6 +72,9 @@ enum ofono_netmon_info {
 	OFONO_NETMON_INFO_EARFCN, /* int */
 	OFONO_NETMON_INFO_EBAND, /* int */
 	OFONO_NETMON_INFO_CQI, /* int */
+	OFONO_NETMON_INFO_PCI, /* int */
+	OFONO_NETMON_INFO_TAC, /* int */
+	OFONO_NETMON_INFO_SNR, /* int */
 	OFONO_NETMON_INFO_INVALID,
 };
 =

diff --git a/src/netmon.c b/src/netmon.c
index 9eacb3ca..10e3ee2b 100644
--- a/src/netmon.c
+++ b/src/netmon.c
@@ -213,6 +213,27 @@ static void netmon_cell_info_dict_append(DBusMessageIt=
er *dict,
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

+		case OFONO_NETMON_INFO_PCI:
+			intval =3D va_arg(*arglist, int);
+
+			CELL_INFO_DICT_APPEND(dict, "PhysicalCellId",
+					intval, uint16_t, DBUS_TYPE_UINT16);
+			break;
+
+		case OFONO_NETMON_INFO_TAC:
+			intval =3D va_arg(*arglist, int);
+
+			CELL_INFO_DICT_APPEND(dict, "TrackingAreaCode",
+					intval, uint16_t, DBUS_TYPE_UINT16);
+			break;
+
+		case OFONO_NETMON_INFO_SNR:
+			intval =3D va_arg(*arglist, int);
+
+			ofono_dbus_dict_append(dict, "SingalToNoiseRatio",
+					DBUS_TYPE_INT32, &intval);
+			break;
+
 		case OFONO_NETMON_INFO_INVALID:
 			break;
 		}
-- =

2.17.1

--===============0657793163549019564==--

