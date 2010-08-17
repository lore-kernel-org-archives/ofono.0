Content-Type: multipart/mixed; boundary="===============0521858328116371249=="
MIME-Version: 1.0
From: caiwen.zhang <caiwenzhang@163.com>
Subject: [PATCH 1/2] add CDMA radio setting support
Date: Tue, 17 Aug 2010 03:39:00 +0000
Message-ID: <1282016329-12485-1-git-send-email-caiwenzhang@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0521858328116371249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/radio-settings.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/radio-settings.h b/include/radio-settings.h
index d41ec0b..1391271 100644
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -33,6 +33,10 @@ enum ofono_radio_access_mode {
 	OFONO_RADIO_ACCESS_MODE_GSM	=3D 1,
 	OFONO_RADIO_ACCESS_MODE_UMTS	=3D 2,
 	OFONO_RADIO_ACCESS_MODE_LTE	=3D 3,
+
+	OFONO_CDMA_RADIO_ACCESS_MODE_CDMA =3D 4,
+	OFONO_CDMA_RADIO_ACCESS_MODE_HDR =3D 5,
+	OFONO_CDMA_RADIO_ACCESS_MODE_HYBRID =3D 6,  //CDMA/HDR HYBRID
 };
 =

 struct ofono_radio_settings;
-- =

1.7.0.4



--===============0521858328116371249==--

