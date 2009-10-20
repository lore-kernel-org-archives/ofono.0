Content-Type: multipart/mixed; boundary="===============8004325741161132268=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 1/1] Catch +CIEV commands from AG
Date: Tue, 20 Oct 2009 18:34:20 -0200
Message-ID: <1256070860-24476-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8004325741161132268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a callback to get status update from AG side. +CIEV commands send
updates such as roaming status, battery and signal level and call
status.
---
 plugins/hfp.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 9733cfc..211c874 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -104,6 +104,33 @@ error:
 	hfp_disable(modem);
 }
 =

+static void ciev_cb(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int index, value, i;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV:"))
+		goto error;
+
+	g_at_result_iter_next_number(&iter, &index);
+	g_at_result_iter_next_number(&iter, &value);
+
+	for (i =3D 0; i < HFP_INDICATOR_LAST; i++) {
+		if (index !=3D data->cind_pos[i])
+			continue;
+
+		data->cind_val[i] =3D value;
+	}
+	return;
+
+error:
+	hfp_disable(modem);
+}
+
 static void cmer_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -116,6 +143,9 @@ static void cmer_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 =

 	g_at_chat_send(data->chat, "AT+CIND?", cind_prefix,
 			cind_status_cb, modem, NULL);
+
+	g_at_chat_register(data->chat, "+CIEV:", ciev_cb, FALSE,
+			modem, NULL);
 }
 =

 static void cind_cb(gboolean ok, GAtResult *result, gpointer user_data)
-- =

1.6.4.4


--===============8004325741161132268==--

