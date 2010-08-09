Content-Type: multipart/mixed; boundary="===============6201540814746146198=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH resend 1/3] voicecall: Rename cb-function hangup to
 hangup_active in core and drivers.
Date: Mon, 09 Aug 2010 23:18:37 +0200
Message-ID: <1281388719-11781-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6201540814746146198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 drivers/atmodem/voicecall.c      |    4 ++--
 drivers/calypsomodem/voicecall.c |    2 +-
 drivers/hfpmodem/voicecall.c     |    2 +-
 drivers/isimodem/voicecall.c     |    2 +-
 drivers/stemodem/voicecall.c     |    2 +-
 include/voicecall.h              |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index fce9144..2578779 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -409,7 +409,7 @@ static void at_answer(struct ofono_voicecall *vc,
 static void at_hangup(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
-	/* Hangup all calls */
+	/* Hangup active call */
 	at_template("AT+CHUP", vc, generic_cb, 0x3f, cb, data);
 }
 =

@@ -874,7 +874,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D at_voicecall_remove,
 	.dial			=3D at_dial,
 	.answer			=3D at_answer,
-	.hangup			=3D at_hangup,
+	.hangup_active		=3D at_hangup,
 	.hold_all_active	=3D at_hold_all_active,
 	.release_all_held	=3D at_release_all_held,
 	.set_udub		=3D at_set_udub,
diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index 511d533..56ec5a9 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -407,7 +407,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D calypso_voicecall_remove,
 	.dial			=3D calypso_dial,
 	.answer			=3D calypso_answer,
-	.hangup			=3D calypso_hangup,
+	.hangup_active		=3D calypso_hangup,
 	.hold_all_active	=3D calypso_hold_all_active,
 	.release_all_held	=3D calypso_release_all_held,
 	.set_udub		=3D calypso_set_udub,
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index f83f26a..69923cc 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -1166,7 +1166,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D hfp_voicecall_remove,
 	.dial			=3D hfp_dial,
 	.answer			=3D hfp_answer,
-	.hangup			=3D hfp_hangup,
+	.hangup_active		=3D hfp_hangup,
 	.hold_all_active	=3D hfp_hold_all_active,
 	.release_all_held	=3D hfp_release_all_held,
 	.set_udub		=3D hfp_set_udub,
diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 3e28dae..4b720be 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1318,7 +1318,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D isi_voicecall_remove,
 	.dial			=3D isi_dial,
 	.answer			=3D isi_answer,
-	.hangup			=3D isi_hangup,
+	.hangup_active		=3D isi_hangup,
 	.hold_all_active	=3D isi_hold_all_active,
 	.release_all_held	=3D isi_release_all_held,
 	.set_udub		=3D isi_set_udub,
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index a56709a..daadf54 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -569,7 +569,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D ste_voicecall_remove,
 	.dial			=3D ste_dial,
 	.answer			=3D ste_answer,
-	.hangup			=3D ste_hangup,
+	.hangup_active		=3D ste_hangup,
 	.hold_all_active	=3D ste_hold_all_active,
 	.release_all_held	=3D ste_release_all_held,
 	.set_udub		=3D ste_set_udub,
diff --git a/include/voicecall.h b/include/voicecall.h
index 6ceb3d8..998c02d 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -67,7 +67,7 @@ struct ofono_voicecall_driver {
 			ofono_voicecall_cb_t cb, void *data);
 	void (*answer)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
-	void (*hangup)(struct ofono_voicecall *vc,
+	void (*hangup_active)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
 	void (*hold_all_active)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
-- =

1.6.3.3


--===============6201540814746146198==--

