Content-Type: multipart/mixed; boundary="===============6632645848515766581=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/3] xmm7modem: handling of dual mode technology preference
Date: Mon, 13 May 2019 14:20:43 +0530
Message-ID: <1557737443-25498-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6632645848515766581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handled dual mode technology preference "umts,gsm" and
"lte,umts" for xmm7modem.
---
 drivers/xmm7modem/radio-settings.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/xmm7modem/radio-settings.c b/drivers/xmm7modem/radio-s=
ettings.c
index f1eb1aa..c7c2ce0 100644
--- a/drivers/xmm7modem/radio-settings.c
+++ b/drivers/xmm7modem/radio-settings.c
@@ -84,10 +84,10 @@ static void xact_query_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
 		break;
 	case 3:
-		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM;
 		break;
 	case 4:
-		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
+		mode =3D OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS;
 		break;
 	case 5:
 		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
@@ -158,7 +158,16 @@ static void xmm_set_rat_mode(struct ofono_radio_settin=
gs *rs,
 		break;
 	}
 =

-	if (value =3D=3D 6)
+	if (mode =3D=3D
+		(OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM)) {
+		value =3D 3;
+		preferred =3D 1;
+	}
+
+	if (mode =3D=3D (OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS=
))
+		value =3D 4;
+
+	if (value =3D=3D 6 || value =3D=3D 3 || value =3D=3D 4)
 		snprintf(buf, sizeof(buf), "AT+XACT=3D%u,%u", value, preferred);
 	else
 		snprintf(buf, sizeof(buf), "AT+XACT=3D%u", value);
-- =

1.9.1


--===============6632645848515766581==--

