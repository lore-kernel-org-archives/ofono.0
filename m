Content-Type: multipart/mixed; boundary="===============9032305312051869247=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 08/16] calypsomodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:10 +0200
Message-ID: <1294829538-3893-9-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9032305312051869247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/calypsomodem/calypsomodem.h |    8 ++++----
 drivers/calypsomodem/stk.c          |    4 ++--
 drivers/calypsomodem/voicecall.c    |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/calypsomodem/calypsomodem.h b/drivers/calypsomodem/cal=
ypsomodem.h
index caf7a3d..47ebf34 100644
--- a/drivers/calypsomodem/calypsomodem.h
+++ b/drivers/calypsomodem/calypsomodem.h
@@ -21,8 +21,8 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

-extern void calypso_voicecall_init();
-extern void calypso_voicecall_exit();
+extern void calypso_voicecall_init(void);
+extern void calypso_voicecall_exit(void);
 =

-extern void calypso_stk_init();
-extern void calypso_stk_exit();
+extern void calypso_stk_init(void);
+extern void calypso_stk_exit(void);
diff --git a/drivers/calypsomodem/stk.c b/drivers/calypsomodem/stk.c
index 203cb9b..196b9e3 100644
--- a/drivers/calypsomodem/stk.c
+++ b/drivers/calypsomodem/stk.c
@@ -300,12 +300,12 @@ static struct ofono_stk_driver driver =3D {
 	.terminal_response	=3D calypso_stk_terminal_response,
 };
 =

-void calypso_stk_init()
+void calypso_stk_init(void)
 {
 	ofono_stk_driver_register(&driver);
 }
 =

-void calypso_stk_exit()
+void calypso_stk_exit(void)
 {
 	ofono_stk_driver_unregister(&driver);
 }
diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index 0e6a388..f87e480 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -434,12 +434,12 @@ static struct ofono_voicecall_driver driver =3D {
 	.send_tones		=3D calypso_send_dtmf
 };
 =

-void calypso_voicecall_init()
+void calypso_voicecall_init(void)
 {
 	ofono_voicecall_driver_register(&driver);
 }
 =

-void calypso_voicecall_exit()
+void calypso_voicecall_exit(void)
 {
 	ofono_voicecall_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============9032305312051869247==--

