Content-Type: multipart/mixed; boundary="===============1860482208586666076=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH] voicecall: fix CHLD support reply
Date: Tue, 17 May 2011 16:32:39 +0200
Message-ID: <1305642759-27432-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1860482208586666076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 +CHLD=3D(...) syntax is incorrect. Instead, use +CHLD: (...).

 src/voicecall.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index d46f463..2ab67ac 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2838,8 +2838,8 @@ static void emulator_chld_cb(struct ofono_emulator *e=
m,
 		goto fail;
 =

 	case OFONO_EMULATOR_REQUEST_TYPE_SUPPORT:
-		memcpy(buf, "+CHLD=3D(", 7);
-		info =3D buf + 7;
+		memcpy(buf, "+CHLD: (", 8);
+		info =3D buf + 8;
 =

 		ADD_CHLD_SUPPORT(vc->driver->release_all_held &&
 					vc->driver->set_udub, "0")
-- =

1.7.1


--===============1860482208586666076==--

