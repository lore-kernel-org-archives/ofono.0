Content-Type: multipart/mixed; boundary="===============2790156243989622232=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 2/6] smsutil: Remove dialect checks from caller
Date: Thu, 03 Feb 2011 15:20:32 +0200
Message-ID: <1296739236-24391-3-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296739236-24391-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2790156243989622232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 1762391..5c1ae4c 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2267,16 +2267,6 @@ char *sms_decode_text(GSList *sms_list)
 			sms_extract_language_variant(sms, &locking_shift,
 								&single_shift);
 =

-			/*
-			 * If language is not defined in 3GPP TS 23.038,
-			 * implementations are instructed to ignore it
-			 */
-			if (locking_shift >=3D GSM_DIALECT_INVALID)
-				locking_shift =3D GSM_DIALECT_DEFAULT;
-
-			if (single_shift >=3D GSM_DIALECT_INVALID)
-				single_shift =3D GSM_DIALECT_DEFAULT;
-
 			converted =3D convert_gsm_to_utf8_with_lang(buf, written,
 								NULL, NULL, 0,
 								locking_shift,
-- =

1.7.1


--===============2790156243989622232==--

