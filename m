Content-Type: multipart/mixed; boundary="===============3334220534597139791=="
MIME-Version: 1.0
From: y@future.research.nokia.com
Subject: [PATCH 2/2] mbm: use cpin? to check if SIM is missing
Date: Mon, 28 Jun 2010 21:17:08 +0300
Message-ID: <1277749028-3443-2-git-send-email-y>
In-Reply-To: <1277749028-3443-1-git-send-email-y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3334220534597139791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Use AT+CPIN? in case AT+CRSM=3D242 is not supported.
---
 plugins/mbm.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 9193539..bef8783 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -49,6 +49,7 @@
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct mbm_data {
@@ -92,6 +93,18 @@ static void mbm_debug(const char *str, void *user_data)
 	ofono_info("%s %s", prefix, str);
 }
 =

+static void simpin_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	data->have_sim =3D ok;
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
 static void status_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -101,8 +114,12 @@ static void status_check(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	DBG("");
 =

-	if (!ok)
-		goto poweron;
+	if (!ok) {
+		/* If mbm does not support at+crsm=3D242, try at+cpin? */
+		g_at_chat_send(data->modem_port, "AT+CPIN?", cpin_prefix,
+			simpin_check, modem, NULL);
+		return;
+	}
 =

 	/* Modem fakes a 94 04 response from card (File Id not found /
 	 * Pattern not found) when there's no card in the slot.
-- =

1.6.3.3


--===============3334220534597139791==--

