Content-Type: multipart/mixed; boundary="===============5575948929301941369=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 3/7] voicecall: add +CHLD=0 support for HFP emulator
Date: Mon, 02 May 2011 17:48:04 +0200
Message-ID: <1304351288-3894-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1304351288-3894-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5575948929301941369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 3507f33..9225de9 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2758,6 +2758,22 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			goto fail;
 =

 		switch (chld) {
+		case 0:
+			if (vc->driver->set_udub =3D=3D NULL)
+				goto fail;
+
+			if (vc->driver->release_all_held =3D=3D NULL)
+				goto fail;
+
+			if (voicecalls_have_waiting(vc)) {
+				vc->driver->set_udub(vc,
+						emulator_generic_cb, em);
+				return;
+			}
+
+			vc->driver->release_all_held(vc,
+					emulator_generic_cb, em);
+			return;
 		case 1:
 			if (vc->driver->release_all_active =3D=3D NULL)
 				goto fail;
@@ -2781,8 +2797,15 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 		memcpy(buf, "+CHLD=3D", 6);
 		info =3D buf + 6;
 =

-		if (vc->driver->release_all_active)
+		if (vc->driver->release_all_held && vc->driver->set_udub)
+			*info++ =3D '0';
+
+		if (vc->driver->release_all_active) {
+			if (info - buf > 6)
+				*info++ =3D ',';
+
 			*info++ =3D '1';
+		}
 =

 		if (vc->driver->hold_all_active) {
 			if (info - buf > 6)
-- =

1.7.1


--===============5575948929301941369==--

