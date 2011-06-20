Content-Type: multipart/mixed; boundary="===============3006870287550479023=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 3/3] emulator: fix local HFP AG features
Date: Mon, 20 Jun 2011 17:13:48 +0200
Message-ID: <1308582828-3806-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1308582828-3806-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3006870287550479023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 1439854..d19706d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -882,8 +882,10 @@ struct ofono_emulator *ofono_emulator_create(struct of=
ono_modem *modem,
 		return NULL;
 =

 	em->type =3D type;
-	/* TODO: Check real local features */
-	em->l_features =3D 32;
+	em->l_features =3D AG_FEATURE_3WAY | AG_FEATURE_REJECT_CALL |
+			AG_FEATURE_ENHANCED_CALL_STATUS |
+			AG_FEATURE_ENHANCED_CALL_CONTROL |
+			AG_FEATURE_EXTENDED_RES_CODE;
 	em->events_mode =3D 3;	/* default mode is forwarding events */
 	em->cmee_mode =3D 0;	/* CME ERROR disabled by default */
 =

-- =

1.7.1


--===============3006870287550479023==--

