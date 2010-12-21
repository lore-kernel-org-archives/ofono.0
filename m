Content-Type: multipart/mixed; boundary="===============5645665791132952827=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] huawei: fix SIM state notification when locked
Date: Tue, 21 Dec 2010 17:27:10 -0200
Message-ID: <1292959630-23211-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1292881869-13246-2-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5645665791132952827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When SIM is locked, huawei modem does not send any notification about
SIM state change because it does not differentiate 'invalid' from
'locked'.

In order to be able to unlock the sim, this patch forces a notification
of a valid state after a timeout.
---
 plugins/huawei.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index bff1343..de45b03 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -226,6 +226,30 @@ static gboolean notify_sim_state(struct ofono_modem *m=
odem,
 	return FALSE;
 }
 =

+static void cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	if (!ok)
+		return;
+
+	/* Force notification of SIM ready because it's in a locked state */
+	notify_sim_state(modem, HUAWEI_SIM_STATE_VALID);
+}
+
+static gboolean query_sim_locked(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+	data->sim_poll_timeout =3D 0;
+
+	g_at_chat_send(data->pcui, "AT+CPIN?", NULL,
+			cpin_cb, modem, NULL);
+
+	return FALSE;
+}
+
 static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -264,6 +288,10 @@ static void sysinfo_cb(gboolean ok, GAtResult *result,=
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


--===============5645665791132952827==--

