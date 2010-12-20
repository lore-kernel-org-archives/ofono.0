Content-Type: multipart/mixed; boundary="===============6286003070848179352=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] huawei: fix SIM state notification when locked
Date: Mon, 20 Dec 2010 19:51:09 -0200
Message-ID: <1292881869-13246-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1292881869-13246-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6286003070848179352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When SIM is locked, huawei modem does not send any notification about
SIM state change because it does not differentiate 'invalid' from
'locked'.

In order to be able to unlock the sim, this patch forces a notification
of a valid state after a timeout.
---
 plugins/huawei.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index bff1343..7934956 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -56,6 +56,7 @@
 #include <drivers/atmodem/vendor.h>
 =

 static const char *none_prefix[] =3D { NULL };
+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
 static const char *ussdmode_prefix[] =3D { "^USSDMODE:", NULL };
 static const char *cvoice_prefix[] =3D { "^CVOICE:", NULL };
@@ -226,6 +227,41 @@ static gboolean notify_sim_state(struct ofono_modem *m=
odem,
 	return FALSE;
 }
 =

+static void cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	const char *value;
+	GAtResultIter iter;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CPIN:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &value))
+		return;
+
+	/* Force notification of SIM ready because it's in a locked state */
+	if (g_str_has_prefix(value, "SIM"))
+		notify_sim_state(modem, HUAWEI_SIM_STATE_VALID);
+}
+
+static gboolean query_sim_locked(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+	data->sim_poll_timeout =3D 0;
+
+	g_at_chat_send(data->pcui, "AT+CPIN?", cpin_prefix,
+			cpin_cb, modem, NULL);
+
+	return FALSE;
+}
+
 static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -264,6 +300,10 @@ static void sysinfo_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		data->sim_poll_timeout =3D g_timeout_add_seconds(2,
 								query_sim_state,
 								modem);
+	} else if (sim_state =3D=3D	HUAWEI_SIM_STATE_INVALID_OR_LOCKED) {
+		data->sim_poll_timeout =3D g_timeout_add_seconds(2,
+								query_sim_locked,
+								modem);
 	}
 }
 =

-- =

1.7.3.4


--===============6286003070848179352==--

