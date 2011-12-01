Content-Type: multipart/mixed; boundary="===============3010340286056069365=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC_v0] sierra: Add SIM state polling
Date: Thu, 01 Dec 2011 16:37:11 +0100
Message-ID: <1322753831-11643-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3010340286056069365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It has been reported than for some Sierra modem, the SIM
initialization process leads to +CME ERROR: 10 sim not
present. The issue might come from SIM is not ready.
---
 plugins/sierra.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/plugins/sierra.c b/plugins/sierra.c
index c41e2d1..db54817 100644
--- a/plugins/sierra.c
+++ b/plugins/sierra.c
@@ -47,6 +47,8 @@ static const char *none_prefix[] =3D { NULL };
 =

 struct sierra_data {
 	GAtChat *chat;
+	gboolean have_sim;
+	struct at_util_sim_state_query *sim_state_query;
 };
 =

 static void sierra_debug(const char *str, void *user_data)
@@ -79,6 +81,12 @@ static void sierra_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

+	/* Cleanup potential SIM state polling */
+	at_util_sim_state_query_free(data->sim_state_query);
+
+	/* Cleanup after hot-unplug */
+	g_at_chat_unref(data->chat);
+
 	g_free(data);
 }
 =

@@ -115,6 +123,21 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static void sim_state_cb(gboolean present, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sierra_data *data =3D ofono_modem_get_data(modem);
+
+	at_util_sim_state_query_free(data->sim_state_query);
+	data->sim_state_query =3D NULL;
+
+	data->have_sim =3D present;
+
+	ofono_modem_set_powered(modem, TRUE);
+
+	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -127,7 +150,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		data->chat =3D NULL;
 	}
 =

-	ofono_modem_set_powered(modem, ok);
+	data->sim_state_query =3D at_util_sim_state_query_new(data->chat,
+						2, 20, sim_state_cb, modem);
 }
 =

 static int sierra_enable(struct ofono_modem *modem)
-- =

1.7.1


--===============3010340286056069365==--

