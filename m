Content-Type: multipart/mixed; boundary="===============2292011315788711335=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v5 12/12] emulator: Update supported features
Date: Thu, 26 Apr 2012 16:27:04 +0200
Message-ID: <1335450424-19964-13-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1335450424-19964-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2292011315788711335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ECNR (Echo Cancelation/Noise Reduction) and Inband Ringtone
capabilities to supported features (+BRSF event)
---
 src/emulator.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 2c40898..93f49e7 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -984,6 +984,8 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
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


--===============2292011315788711335==--

