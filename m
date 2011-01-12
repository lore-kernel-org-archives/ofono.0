Content-Type: multipart/mixed; boundary="===============2886950291376467801=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 04/16] mbmmodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:06 +0200
Message-ID: <1294829538-3893-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2886950291376467801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/gprs-context.c |    4 ++--
 drivers/mbmmodem/mbmmodem.h     |    8 ++++----
 drivers/mbmmodem/stk.c          |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index 0a1ca2c..b9b4574 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -514,12 +514,12 @@ static struct ofono_gprs_context_driver driver =3D {
 	.deactivate_primary	=3D mbm_gprs_deactivate_primary,
 };
 =

-void mbm_gprs_context_init()
+void mbm_gprs_context_init(void)
 {
 	ofono_gprs_context_driver_register(&driver);
 }
 =

-void mbm_gprs_context_exit()
+void mbm_gprs_context_exit(void)
 {
 	ofono_gprs_context_driver_unregister(&driver);
 }
diff --git a/drivers/mbmmodem/mbmmodem.h b/drivers/mbmmodem/mbmmodem.h
index 65786d7..4c6f263 100644
--- a/drivers/mbmmodem/mbmmodem.h
+++ b/drivers/mbmmodem/mbmmodem.h
@@ -21,8 +21,8 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

-extern void mbm_gprs_context_init();
-extern void mbm_gprs_context_exit();
+extern void mbm_gprs_context_init(void);
+extern void mbm_gprs_context_exit(void);
 =

-extern void mbm_stk_init();
-extern void mbm_stk_exit();
+extern void mbm_stk_init(void);
+extern void mbm_stk_exit(void);
diff --git a/drivers/mbmmodem/stk.c b/drivers/mbmmodem/stk.c
index 81c36db..d0a9f3b 100644
--- a/drivers/mbmmodem/stk.c
+++ b/drivers/mbmmodem/stk.c
@@ -270,12 +270,12 @@ static struct ofono_stk_driver driver =3D {
 	.terminal_response	=3D mbm_stk_terminal_response,
 };
 =

-void mbm_stk_init()
+void mbm_stk_init(void)
 {
 	ofono_stk_driver_register(&driver);
 }
 =

-void mbm_stk_exit()
+void mbm_stk_exit(void)
 {
 	ofono_stk_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============2886950291376467801==--

