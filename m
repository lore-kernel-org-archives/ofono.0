Content-Type: multipart/mixed; boundary="===============3522832206827287857=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 6/7] hfp: Move HFP versions definitions to hfp.h
Date: Mon, 15 Apr 2013 18:41:49 -0300
Message-ID: <1366062110-28031-7-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366062110-28031-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3522832206827287857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hfp.h should store all HFP related definitions.
---
 drivers/hfpmodem/slc.h |    6 ------
 src/hfp.h              |    6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hfpmodem/slc.h b/drivers/hfpmodem/slc.h
index b71ffe9..dd6f926 100644
--- a/drivers/hfpmodem/slc.h
+++ b/drivers/hfpmodem/slc.h
@@ -27,12 +27,6 @@
 #define AG_CHLD_3	0x20
 #define AG_CHLD_4	0x40
 =

-enum hfp_version {
-	HFP_VERSION_1_5 =3D	0x0105,
-	HFP_VERSION_1_6 =3D	0x0106,
-	HFP_VERSION_LATEST =3D	HFP_VERSION_1_6,
-};
-
 enum hfp_indicator {
 	HFP_INDICATOR_SERVICE =3D 0,
 	HFP_INDICATOR_CALL,
diff --git a/src/hfp.h b/src/hfp.h
index 64a7055..b54de56 100644
--- a/src/hfp.h
+++ b/src/hfp.h
@@ -50,3 +50,9 @@ enum hfp_codec {
 	HFP_CODEC_CVSD =3D 0x01,
 	HFP_CODEC_MSBC =3D 0x02,
 };
+
+enum hfp_version {
+	HFP_VERSION_1_5 =3D	0x0105,
+	HFP_VERSION_1_6 =3D	0x0106,
+	HFP_VERSION_LATEST =3D	HFP_VERSION_1_6,
+};
-- =

1.7.9.5


--===============3522832206827287857==--

