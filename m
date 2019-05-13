Content-Type: multipart/mixed; boundary="===============2738284855066460893=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/3] radio-settings: handling of dual mode technology
 preference
Date: Mon, 13 May 2019 14:20:12 +0530
Message-ID: <1557737412-25456-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2738284855066460893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handled two new dual mode technology preferences
"umts,gsm" and "lte,umts".
---
 src/radio-settings.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index 7fd92df..7283aa9 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -71,9 +71,15 @@ static const char *radio_access_mode_to_string(enum ofon=
o_radio_access_mode m)
 		return "umts";
 	case OFONO_RADIO_ACCESS_MODE_LTE:
 		return "lte";
-	default:
-		return NULL;
 	}
+
+	if (m =3D=3D (OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM))
+		return "umts,gsm";
+
+	if (m =3D=3D (OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS))
+		return "lte,umts";
+
+	return NULL;
 }
 =

 static gboolean radio_access_mode_from_string(const char *str,
@@ -92,6 +98,12 @@ static gboolean radio_access_mode_from_string(const char=
 *str,
 	} else if (g_str_equal(str, "lte")) {
 		*mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
 		return TRUE;
+	} else if (g_str_equal(str, "umts,gsm")) {
+		*mode =3D OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM;
+		return TRUE;
+	} else if (g_str_equal(str, "lte,umts")) {
+		*mode =3D OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS;
+		return TRUE;
 	}
 =

 	return FALSE;
-- =

1.9.1


--===============2738284855066460893==--

