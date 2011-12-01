Content-Type: multipart/mixed; boundary="===============4167481973283666347=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC_v1 2/2] sierra: Add SIM state polling
Date: Thu, 01 Dec 2011 17:48:53 +0100
Message-ID: <1322758133-19701-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1322758133-19701-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4167481973283666347==
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
index b33382d..45e75c1 100644
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
@@ -82,6 +84,9 @@ static void sierra_remove(struct ofono_modem *modem)
 	/* Cleanup after hot-unplug */
 	g_at_chat_unref(data->chat);
 =

+	/* Cleanup potential SIM state polling */
+	at_util_sim_state_query_free(data->sim_state_query);
+
 	g_free(data);
 }
 =

@@ -118,6 +123,21 @@ static GAtChat *open_device(struct ofono_modem *modem,
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
@@ -128,9 +148,13 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	if (!ok) {
 		g_at_chat_unref(data->chat);
 		data->chat =3D NULL;
+
+		ofono_modem_set_powered(modem, FALSE);
+		return;
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


--===============4167481973283666347==--

