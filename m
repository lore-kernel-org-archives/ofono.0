Content-Type: multipart/mixed; boundary="===============3446909212592521351=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/6] atmodem: removed simauth init
Date: Thu, 09 Nov 2017 09:17:07 -0800
Message-ID: <1510247832-19632-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3446909212592521351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atmodem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index 684b228..e0d5ab6 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -50,7 +50,6 @@ static int atmodem_init(void)
 	at_call_volume_init();
 	at_gprs_init();
 	at_gprs_context_init();
-	at_sim_auth_init();
 	at_gnss_init();
 	at_lte_init();
 =

@@ -59,7 +58,6 @@ static int atmodem_init(void)
 =

 static void atmodem_exit(void)
 {
-	at_sim_auth_exit();
 	at_stk_exit();
 	at_sim_exit();
 	at_sms_exit();
-- =

2.7.4


--===============3446909212592521351==--

