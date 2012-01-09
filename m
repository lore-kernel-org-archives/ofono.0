Content-Type: multipart/mixed; boundary="===============3354215526768335578=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/5] speedup: Check for supported modem capabilities first
Date: Mon, 09 Jan 2012 14:10:57 +0100
Message-ID: <1326114660-10111-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1326114660-10111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3354215526768335578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedup.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index a90dfe3..f03f8f3 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -47,11 +48,15 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+static const char *gcap_prefix[] =3D { "+GCAP:", NULL };
+
 struct speedup_data {
 	GAtChat *modem;
 	GAtChat *aux;
 	gboolean have_sim;
 	struct at_util_sim_state_query *sim_state_query;
+	gboolean have_gsm;
+	gboolean have_cdma;
 };
 =

 static int speedup_probe(struct ofono_modem *modem)
@@ -165,6 +170,36 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 						2, 20, sim_state_cb, modem);
 }
 =

+static void gcap_support(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	const char *gcap;
+
+	if (!ok)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+GCAP:"))
+		goto done;
+
+	while (g_at_result_iter_next_unquoted_string(&iter, &gcap)) {
+		if (*gcap =3D=3D '\0')
+			break;
+
+		if (!strcmp(gcap, "+CGSM"))
+			data->have_gsm =3D TRUE;
+		else if (!strcmp(gcap, "+CIS707-A"))
+			data->have_cdma =3D TRUE;
+	}
+
+done:
+	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
+					cfun_enable, modem, NULL);
+}
+
 static int speedup_enable(struct ofono_modem *modem)
 {
 	struct speedup_data *data =3D ofono_modem_get_data(modem);
@@ -185,8 +220,9 @@ static int speedup_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 =

-	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
-					cfun_enable, modem, NULL);
+	/* Check for GSM/CDMA capabilities */
+	g_at_chat_send(data->aux, "ATI", gcap_prefix,
+					gcap_support, modem, NULL);
 =

 	return -EINPROGRESS;
 }
-- =

1.7.1


--===============3354215526768335578==--

