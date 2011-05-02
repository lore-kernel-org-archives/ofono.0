Content-Type: multipart/mixed; boundary="===============8984651420720428231=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 4/7] voicecall: add +CHLD=3 support for HFP emulator
Date: Mon, 02 May 2011 17:48:05 +0200
Message-ID: <1304351288-3894-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1304351288-3894-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8984651420720428231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 9225de9..b420071 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2788,6 +2788,13 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			vc->driver->hold_all_active(vc,
 					emulator_generic_cb, em);
 			return;
+		case 3:
+			if (vc->driver->create_multiparty =3D=3D NULL)
+				goto fail;
+
+			vc->driver->create_multiparty(vc,
+					emulator_generic_cb, em);
+			return;
 		default:
 			goto fail;
 		}
@@ -2814,6 +2821,13 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			*info++ =3D '2';
 		}
 =

+		if (vc->driver->create_multiparty) {
+			if (info - buf > 6)
+				*info++ =3D ',';
+
+			*info++ =3D '3';
+		}
+
 		*info++ =3D '\0';
 =

 		ofono_emulator_send_info(em, buf, TRUE);
-- =

1.7.1


--===============8984651420720428231==--

