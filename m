Content-Type: multipart/mixed; boundary="===============4968592091464706336=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] mbim driver: fixed the initialization function
Date: Thu, 20 Sep 2018 06:49:12 +0200
Message-ID: <1537418952-25060-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4968592091464706336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbimmodem/mbimmodem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mbimmodem/mbimmodem.c b/drivers/mbimmodem/mbimmodem.c
index a4c9daa..2a01dd6 100644
--- a/drivers/mbimmodem/mbimmodem.c
+++ b/drivers/mbimmodem/mbimmodem.c
@@ -33,7 +33,7 @@ static int mbimmodem_init(void)
 	mbim_devinfo_init();
 	mbim_sim_init();
 	mbim_netreg_init();
-	mbim_sms_exit();
+	mbim_sms_init();
 	mbim_gprs_init();
 	mbim_gprs_context_init();
 	return 0;
-- =

1.9.1


--===============4968592091464706336==--

