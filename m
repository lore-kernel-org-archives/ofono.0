Content-Type: multipart/mixed; boundary="===============6456166913564038743=="
MIME-Version: 1.0
From: caiwen.zhang <caiwenzhang@163.com>
Subject: [PATCH 1/2] add cdma radio setting
Date: Mon, 23 Aug 2010 18:45:41 +0800
Message-ID: <1282560341-2486-1-git-send-email-caiwenzhang@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6456166913564038743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/radio-settings.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
 mode change 100644 =3D> 100755 include/radio-settings.h

diff --git a/include/radio-settings.h b/include/radio-settings.h
old mode 100644
new mode 100755
index d41ec0b..59b86c1
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -33,6 +33,10 @@ enum ofono_radio_access_mode {
 	OFONO_RADIO_ACCESS_MODE_GSM	=3D 1,
 	OFONO_RADIO_ACCESS_MODE_UMTS	=3D 2,
 	OFONO_RADIO_ACCESS_MODE_LTE	=3D 3,
+
+	OFONO_CDMA_RADIO_ACCESS_MODE_CDMA =3D 4,
+	OFONO_CDMA_RADIO_ACCESS_MODE_HDR =3D 5,
+	OFONO_CDMA_RADIO_ACCESS_MODE_HYBRID =3D 6,  /* CDMA/HDR HYBRID */
 };
 =

 struct ofono_radio_settings;
-- =

1.7.0.4



--===============6456166913564038743==--

