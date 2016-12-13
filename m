Content-Type: multipart/mixed; boundary="===============8005318369582256884=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH 3/5] netmon: handle OFONO_NETMON_INFO_{EARFCN|EBAND|CQI}
Date: Tue, 13 Dec 2016 12:05:26 +0100
Message-ID: <1481627128-20233-4-git-send-email-djalal@endocode.com>
In-Reply-To: <1481627128-20233-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8005318369582256884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netmon.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/netmon.c b/src/netmon.c
index bb39586..6476783 100644
--- a/src/netmon.c
+++ b/src/netmon.c
@@ -211,6 +211,27 @@ void ofono_netmon_serving_cell_notify(struct ofono_net=
mon *netmon,
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

+		case OFONO_NETMON_INFO_EARFCN:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "EARFCN",
+					intval, uint16_t, DBUS_TYPE_UINT16);
+			break;
+
+		case OFONO_NETMON_INFO_EBAND:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "EBand",
+					intval, uint8_t, DBUS_TYPE_BYTE);
+			break;
+
+		case OFONO_NETMON_INFO_CQI:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "ChannelQualityIndicator",
+					intval, uint8_t, DBUS_TYPE_BYTE);
+			break;
+
 		case OFONO_NETMON_INFO_INVALID:
 			break;
 		}
-- =

2.5.5


--===============8005318369582256884==--

