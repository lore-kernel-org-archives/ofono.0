Content-Type: multipart/mixed; boundary="===============8092130346702838385=="
MIME-Version: 1.0
From: Mingli Wu <mingli@southpole.se>
Subject: [PATCH 2/3] Drop checking whether +CMER is supported.
Date: Mon, 17 Dec 2012 17:22:17 +0100
Message-ID: <1355761338-9081-3-git-send-email-mingli@southpole.se>
In-Reply-To: <1355761338-9081-1-git-send-email-mingli@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8092130346702838385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For Telit HE910,  ofono always got "\r\n+CME ERROR: 14\r\n"
after issuing "AT+CMER=3D3,0,0,2\r" command. "CME ERROR: 14"
means that SIM is busy. Now we igonre the result of the
command "AT+CMER=3D3,0,0,2\r", and register network anyway.
---
 drivers/atmodem/network-registration.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 19b19b2..518a548 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1480,7 +1480,6 @@ static void at_cmer_not_supported(struct ofono_netreg=
 *netreg)
 	ofono_error("+CMER not supported by this modem.  If this is an error"
 			" please submit patches to support this hardware");
 =

-	ofono_netreg_remove(netreg);
 }
 =

 static void at_cmer_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -1490,7 +1489,6 @@ static void at_cmer_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	if (!ok) {
 		at_cmer_not_supported(netreg);
-		return;
 	}
 =

 	/*
-- =

1.7.9.5


--===============8092130346702838385==--

