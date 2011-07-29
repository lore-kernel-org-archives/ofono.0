Content-Type: multipart/mixed; boundary="===============3326353411664040573=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] zte: delay the sending of &C0 after SIM is ready.
Date: Fri, 29 Jul 2011 15:58:11 +0200
Message-ID: <1311947891-9893-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1311947891-9893-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3326353411664040573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/zte.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index ef1a33a..1dfcf81 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -133,6 +133,10 @@ static void sim_state_cb(gboolean present, gpointer us=
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
@@ -153,10 +157,6 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 		return;
 	}
 =

-	/* AT&C0 needs to be send separate and on both channel */
-	g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
-	g_at_chat_send(data->aux, "AT&C0", NULL, NULL, NULL, NULL);
-
 	data->sim_state_query =3D at_util_sim_state_query_new(data->aux,
 						2, 20, sim_state_cb, modem);
 }
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

--===============3326353411664040573==--

