Content-Type: multipart/mixed; boundary="===============2125447265085131282=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 2/2] speedup: delay &C0.
Date: Thu, 28 Jul 2011 16:16:10 +0200
Message-ID: <1311862570-29780-3-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1311862570-29780-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2125447265085131282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedup.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index f959e12..16ae4fa 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -131,6 +131,10 @@ static void sim_state_cb(gboolean present, gpointer us=
er_data)
 	data->have_sim =3D present;
 =

 	ofono_modem_set_powered(modem, TRUE);
+
+	/* AT&C0 needs to be send separate and on both channel */
+	g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "AT&C0", NULL, NULL, NULL, NULL);
 }
 =

 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
@@ -172,8 +176,8 @@ static int speedup_enable(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

-	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 =

 	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
 					cfun_enable, modem, NULL);
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

--===============2125447265085131282==--

