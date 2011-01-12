Content-Type: multipart/mixed; boundary="===============4002258695383041043=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 05/16] hfpmodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:07 +0200
Message-ID: <1294829538-3893-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4002258695383041043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/call-volume.c          |    4 ++--
 drivers/hfpmodem/hfpmodem.h             |   12 ++++++------
 drivers/hfpmodem/network-registration.c |    4 ++--
 drivers/hfpmodem/voicecall.c            |    4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hfpmodem/call-volume.c b/drivers/hfpmodem/call-volume.c
index f985175..19f57c4 100644
--- a/drivers/hfpmodem/call-volume.c
+++ b/drivers/hfpmodem/call-volume.c
@@ -226,12 +226,12 @@ static struct ofono_call_volume_driver driver =3D {
 	.mute			=3D NULL,
 };
 =

-void hfp_call_volume_init()
+void hfp_call_volume_init(void)
 {
 	ofono_call_volume_driver_register(&driver);
 }
 =

-void hfp_call_volume_exit()
+void hfp_call_volume_exit(void)
 {
 	ofono_call_volume_driver_unregister(&driver);
 }
diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index bf5d563..fca1a9b 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -72,11 +72,11 @@ struct hfp_data {
 	gboolean agent_registered;
 };
 =

-extern void hfp_netreg_init();
-extern void hfp_netreg_exit();
+extern void hfp_netreg_init(void);
+extern void hfp_netreg_exit(void);
 =

-extern void hfp_call_volume_init();
-extern void hfp_call_volume_exit();
+extern void hfp_call_volume_init(void);
+extern void hfp_call_volume_exit(void);
 =

-extern void hfp_voicecall_init();
-extern void hfp_voicecall_exit();
+extern void hfp_voicecall_init(void);
+extern void hfp_voicecall_exit(void);
diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index 03ddc7b..273490e 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -348,12 +348,12 @@ static struct ofono_netreg_driver driver =3D {
 	.strength			=3D hfp_signal_strength,
 };
 =

-void hfp_netreg_init()
+void hfp_netreg_init(void)
 {
 	ofono_netreg_driver_register(&driver);
 }
 =

-void hfp_netreg_exit()
+void hfp_netreg_exit(void)
 {
 	ofono_netreg_driver_unregister(&driver);
 }
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 53ca4bd..4c8ee37 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -1174,12 +1174,12 @@ static struct ofono_voicecall_driver driver =3D {
 	.send_tones		=3D hfp_send_dtmf
 };
 =

-void hfp_voicecall_init()
+void hfp_voicecall_init(void)
 {
 	ofono_voicecall_driver_register(&driver);
 }
 =

-void hfp_voicecall_exit()
+void hfp_voicecall_exit(void)
 {
 	ofono_voicecall_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============4002258695383041043==--

