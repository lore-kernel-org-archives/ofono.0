Content-Type: multipart/mixed; boundary="===============1341454563189193977=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 6/7] voicecall: add +CHLD=1X support for HFP emulator
Date: Mon, 02 May 2011 17:48:07 +0200
Message-ID: <1304351288-3894-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1304351288-3894-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1341454563189193977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 3fe590d..432c739 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2803,9 +2803,19 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 					emulator_generic_cb, em);
 			return;
 		default:
-			goto fail;
+			break;
 		}
-		break;
+
+		if (chld >=3D 10 && chld <=3D 17) {
+			if (vc->driver->release_specific =3D=3D NULL)
+				goto fail;
+
+			vc->driver->release_specific(vc, chld - 10,
+					emulator_generic_cb, em);
+			return;
+		}
+
+		goto fail;
 =

 	case OFONO_EMULATOR_REQUEST_TYPE_SUPPORT:
 		memcpy(buf, "+CHLD=3D", 6);
@@ -2842,6 +2852,14 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			*info++ =3D '4';
 		}
 =

+		if (vc->driver->release_specific) {
+			if (info - buf > 6)
+				*info++ =3D ',';
+
+			*info++ =3D '1';
+			*info++ =3D 'X';
+		}
+
 		*info++ =3D '\0';
 =

 		ofono_emulator_send_info(em, buf, TRUE);
-- =

1.7.1


--===============1341454563189193977==--

