Content-Type: multipart/mixed; boundary="===============8713121590581870240=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH] voicecall: remove unnecessary local var
Date: Tue, 24 May 2011 09:56:57 +0200
Message-ID: <1306223817-6474-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8713121590581870240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 0273ed6..94a20a9 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2606,12 +2606,8 @@ static void sim_watch(struct ofono_atom *atom,
 static void emulator_generic_cb(const struct ofono_error *error, void *dat=
a)
 {
 	struct ofono_emulator *em =3D data;
-	struct ofono_error result;
-
-	result.error =3D error->error;
-	result.type =3D error->type;
 =

-	ofono_emulator_send_final(em, &result);
+	ofono_emulator_send_final(em, error);
 }
 =

 static void emulator_ata_cb(struct ofono_emulator *em,
-- =

1.7.1


--===============8713121590581870240==--

