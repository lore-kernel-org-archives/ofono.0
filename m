Content-Type: multipart/mixed; boundary="===============8644938349724442591=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] speedup: during enable, we have to go offline first.
Date: Thu, 28 Jul 2011 10:25:08 +0200
Message-ID: <1311841508-19358-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8644938349724442591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index 90ca5e3..a7aa43c 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -177,7 +177,7 @@ static int speedup_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 =

-	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
+	g_at_chat_send(data->aux, "AT+CFUN=3D4", NULL,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============8644938349724442591==--

