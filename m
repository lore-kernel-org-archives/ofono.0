Content-Type: multipart/mixed; boundary="===============0500522296281014123=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v4 10/10] emulator: Update supported features
Date: Fri, 06 Apr 2012 15:17:12 +0200
Message-ID: <1333718232-8447-11-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333718232-8447-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0500522296281014123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ECNR (Echo Cancelation/Noise Reduction) and Inband Ringtone
capabilities to supported features (+BRSF event)
---
 src/emulator.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index e7c7d41..371e96c 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -979,6 +979,8 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
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

1.7.1


--===============0500522296281014123==--

