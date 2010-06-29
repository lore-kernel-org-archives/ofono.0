Content-Type: multipart/mixed; boundary="===============5944345800383893772=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH] mbm: use CPIN? to check if SIM is missing
Date: Tue, 29 Jun 2010 14:06:41 +0300
Message-ID: <1277809601-9390-1-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <AANLkTilYOIv-J2SzZd531IdEAFbUuL1vDltcFm47bkUk@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5944345800383893772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AT+CRSM=3D242 is not supported by all mbm models.
---
 plugins/mbm.c |   28 ++++++----------------------
 1 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 9193539..864b0df 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -48,7 +48,7 @@
 #include <drivers/atmodem/vendor.h>
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
-static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct mbm_data {
@@ -92,32 +92,16 @@ static void mbm_debug(const char *str, void *user_data)
 	ofono_info("%s %s", prefix, str);
 }
 =

-static void status_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+static void simpin_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
-	GAtResultIter iter;
-	gint sw[2];
 =

 	DBG("");
 =

-	if (!ok)
-		goto poweron;
-
-	/* Modem fakes a 94 04 response from card (File Id not found /
-	 * Pattern not found) when there's no card in the slot.
-	 */
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+CRSM:"))
-		goto poweron;
-
-	g_at_result_iter_next_number(&iter, &sw[0]);
-	g_at_result_iter_next_number(&iter, &sw[1]);
-
-	data->have_sim =3D sw[0] !=3D 0x94 || sw[1] !=3D 0x04;
+	/* Modem returns error if there is no SIM in slot */
+	data->have_sim =3D ok;
 =

-poweron:
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

@@ -133,8 +117,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		return;
 	}
 =

-	g_at_chat_send(data->modem_port, "AT+CRSM=3D242", crsm_prefix,
-			status_check, modem, NULL);
+	g_at_chat_send(data->modem_port, "AT+CPIN?", cpin_prefix,
+			simpin_check, modem, NULL);
 }
 =

 static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
-- =

1.6.3.3


--===============5944345800383893772==--

