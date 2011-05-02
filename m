Content-Type: multipart/mixed; boundary="===============4337433574843514603=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 5/7] voicecall: add +CHLD=4 support for HFP emulator
Date: Mon, 02 May 2011 17:48:06 +0200
Message-ID: <1304351288-3894-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1304351288-3894-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4337433574843514603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index b420071..3fe590d 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2795,6 +2795,13 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			vc->driver->create_multiparty(vc,
 					emulator_generic_cb, em);
 			return;
+		case 4:
+			if (vc->driver->transfer =3D=3D NULL)
+				goto fail;
+
+			vc->driver->transfer(vc,
+					emulator_generic_cb, em);
+			return;
 		default:
 			goto fail;
 		}
@@ -2828,6 +2835,13 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			*info++ =3D '3';
 		}
 =

+		if (vc->driver->transfer) {
+			if (info - buf > 6)
+				*info++ =3D ',';
+
+			*info++ =3D '4';
+		}
+
 		*info++ =3D '\0';
 =

 		ofono_emulator_send_info(em, buf, TRUE);
-- =

1.7.1


--===============4337433574843514603==--

