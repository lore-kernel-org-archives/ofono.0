Content-Type: multipart/mixed; boundary="===============4776108659149323426=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 4/4] emulator: fix local HFP AG features
Date: Tue, 21 Jun 2011 14:49:49 +0200
Message-ID: <1308660589-2187-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1308660589-2187-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4776108659149323426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 1439854..906404d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -882,8 +882,11 @@ struct ofono_emulator *ofono_emulator_create(struct of=
ono_modem *modem,
 		return NULL;
 =

 	em->type =3D type;
-	/* TODO: Check real local features */
-	em->l_features =3D 32;
+	em->l_features |=3D HFP_AG_FEATURE_3WAY;
+	em->l_features |=3D HFP_AG_FEATURE_REJECT_CALL;
+	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_STATUS;
+	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_CONTROL;
+	em->l_features |=3D HFP_AG_FEATURE_EXTENDED_RES_CODE;
 	em->events_mode =3D 3;	/* default mode is forwarding events */
 	em->cmee_mode =3D 0;	/* CME ERROR disabled by default */
 =

-- =

1.7.1


--===============4776108659149323426==--

