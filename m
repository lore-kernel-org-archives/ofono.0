Content-Type: multipart/mixed; boundary="===============3743043778519490068=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 7/7] voicecall: add +CHLD=2X support for HFP emulator
Date: Mon, 02 May 2011 17:48:08 +0200
Message-ID: <1304351288-3894-8-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1304351288-3894-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3743043778519490068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 432c739..69cd238 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2815,6 +2815,15 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			return;
 		}
 =

+		if (chld >=3D 20 && chld <=3D 27) {
+			if (vc->driver->private_chat =3D=3D NULL)
+				goto fail;
+
+			vc->driver->private_chat(vc, chld - 20,
+					emulator_generic_cb, em);
+			return;
+		}
+
 		goto fail;
 =

 	case OFONO_EMULATOR_REQUEST_TYPE_SUPPORT:
@@ -2860,6 +2869,14 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			*info++ =3D 'X';
 		}
 =

+		if (vc->driver->private_chat) {
+			if (info - buf > 6)
+				*info++ =3D ',';
+
+			*info++ =3D '2';
+			*info++ =3D 'X';
+		}
+
 		*info++ =3D '\0';
 =

 		ofono_emulator_send_info(em, buf, TRUE);
-- =

1.7.1


--===============3743043778519490068==--

