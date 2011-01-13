Content-Type: multipart/mixed; boundary="===============6184565265706115561=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH] cdmamodem: M15 Coding style fix
Date: Thu, 13 Jan 2011 13:02:53 -0800
Message-ID: <1294952573-4633-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6184565265706115561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/cdmamodem.h |    4 ++--
 drivers/cdmamodem/voicecall.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index b085541..5011ade 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -21,5 +21,5 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

-extern void cdma_voicecall_init();
-extern void cdma_voicecall_exit();
+extern void cdma_voicecall_init(void);
+extern void cdma_voicecall_exit(void);
diff --git a/drivers/cdmamodem/voicecall.c b/drivers/cdmamodem/voicecall.c
index 5b4f3cc..a0fa79f 100644
--- a/drivers/cdmamodem/voicecall.c
+++ b/drivers/cdmamodem/voicecall.c
@@ -147,12 +147,12 @@ static struct ofono_cdma_voicecall_driver driver =3D {
 	.hangup			=3D cdma_hangup,
 };
 =

-void cdma_voicecall_init()
+void cdma_voicecall_init(void)
 {
 	ofono_cdma_voicecall_driver_register(&driver);
 }
 =

-void cdma_voicecall_exit()
+void cdma_voicecall_exit(void)
 {
 	ofono_cdma_voicecall_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============6184565265706115561==--

