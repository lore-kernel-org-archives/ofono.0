Content-Type: multipart/mixed; boundary="===============9127074811665477209=="
MIME-Version: 1.0
From: caiwen.zhang <caiwenzhang@163.com>
Subject: [PATCH 2/2] add CDMA radio setting support
Date: Tue, 17 Aug 2010 03:40:03 +0000
Message-ID: <1282016390-12516-1-git-send-email-caiwenzhang@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9127074811665477209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/radio-settings.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index f70d870..4952eac 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -58,6 +58,12 @@ static const char *radio_access_mode_to_string(enum ofon=
o_radio_access_mode mode
 		return "umts";
 	case OFONO_RADIO_ACCESS_MODE_LTE:
 		return "lte";
+	case OFONO_CDMA_RADIO_ACCESS_MODE_CDMA:
+		return "cdma";
+	case OFONO_CDMA_RADIO_ACCESS_MODE_HDR:
+		return "hdr";
+	case OFONO_CDMA_RADIO_ACCESS_MODE_HYBRID:
+		return "hybird";
 	default:
 		return "";
 	}
@@ -74,6 +80,12 @@ static int string_to_radio_access_mode(const char *mode)
 		return OFONO_RADIO_ACCESS_MODE_UMTS;
 	if (g_strcmp0(mode, "lte") =3D=3D 0)
 		return OFONO_RADIO_ACCESS_MODE_LTE;
+	if (g_strcmp0(mode, "cdma") =3D=3D 0)
+		return OFONO_CDMA_RADIO_ACCESS_MODE_CDMA;
+	if (g_strcmp0(mode, "hdr") =3D=3D 0)
+		return OFONO_CDMA_RADIO_ACCESS_MODE_HDR;
+	if (g_strcmp0(mode, "hybird") =3D=3D 0)
+		return OFONO_CDMA_RADIO_ACCESS_MODE_HYBRID;
 	return -1;
 }
 =

-- =

1.7.0.4



--===============9127074811665477209==--

