Content-Type: multipart/mixed; boundary="===============2038507887317679690=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCHv2 1/2] mbm: fix initial polling for sim
Date: Mon, 23 Aug 2010 17:18:09 +0300
Message-ID: <1282573090-8351-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282573090-8351-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2038507887317679690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

There seems to be no specific error codes returned when SIM is missing.
Poll at least 5 times upon an error and give up after that.
---
 plugins/mbm.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index eb7b1a4..8541aaf 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -108,10 +108,8 @@ static void simpin_check(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	DBG("");
 =

-	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
-	if (!ok && result->final_or_pdu &&
-			!strcmp(result->final_or_pdu, "+CME ERROR: 10") &&
-			data->cpin_poll_count++ < 5) {
+	/* Modem returns an error if SIM is not ready. */
+	if (!ok && data->cpin_poll_count++ < 5) {
 		data->cpin_poll_source =3D
 			g_timeout_add_seconds(1, init_simpin_check, modem);
 		return;
@@ -119,7 +117,7 @@ static void simpin_check(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	data->cpin_poll_count =3D 0;
 =

-	/* Modem returns ERROR if there is no SIM in slot. */
+	/* There is probably no SIM if SIM is not ready after 5 seconds. */
 	data->have_sim =3D ok;
 =

 	ofono_modem_set_powered(modem, TRUE);
-- =

1.7.0.4


--===============2038507887317679690==--

