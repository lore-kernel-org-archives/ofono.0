Content-Type: multipart/mixed; boundary="===============1981174706274186159=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v6 11/12] emulator: Update supported features
Date: Wed, 01 Aug 2012 12:09:46 +0200
Message-ID: <1343815787-22670-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343815787-22670-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1981174706274186159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ECNR (Echo Cancelation/Noise Reduction) and Inband Ringtone
capabilities to supported features (+BRSF event)
---
 src/emulator.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 14a39f3..791d88b 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -981,6 +981,8 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 =

 	em->type =3D type;
 	em->l_features |=3D HFP_AG_FEATURE_3WAY;
+	em->l_features |=3D HFP_AG_FEATURE_ECNR;
+	em->l_features |=3D HFP_AG_FEATURE_IN_BAND_RING_TONE;
 	em->l_features |=3D HFP_AG_FEATURE_REJECT_CALL;
 	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_STATUS;
 	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_CONTROL;
-- =

1.7.9.5


--===============1981174706274186159==--

