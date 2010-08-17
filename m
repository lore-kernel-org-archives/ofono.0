Content-Type: multipart/mixed; boundary="===============0134447971415655876=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH v5 2/8] stemodem: Add polling for SIM ready.
Date: Tue, 17 Aug 2010 14:22:28 +0200
Message-ID: <1282047754-15562-3-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1282047754-15562-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0134447971415655876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Interim solution until support for SIM 'ready' notification is supported.
---
Change: AT-channel configuration is moved to separate patch.

 plugins/ste.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index ef375ea..fcf4d15 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -60,8 +60,13 @@
 #include <drivers/stemodem/caif_socket.h>
 #include <drivers/stemodem/if_caif.h>
 =

+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+
 struct ste_data {
 	GAtChat *chat;
+	guint cpin_poll_source;
+	guint cpin_poll_count;
+	gboolean have_sim;
 };
 =

 static int ste_probe(struct ofono_modem *modem)
@@ -88,6 +93,10 @@ static void ste_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 =

 	g_at_chat_unref(data->chat);
+
+	if (data->cpin_poll_source > 0)
+		g_source_remove(data->cpin_poll_source);
+
 	g_free(data);
 }
 =

@@ -96,16 +105,55 @@ static void ste_debug(const char *str, void *user_data)
 	ofono_info("%s", str);
 }
 =

+static gboolean init_simpin_check(gpointer user_data);
+
+static void simpin_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+
+	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
+	if (!ok && result->final_or_pdu &&
+			!strcmp(result->final_or_pdu, "+CME ERROR: 10") &&
+			data->cpin_poll_count++ < 5) {
+		data->cpin_poll_source =3D
+			g_timeout_add_seconds(1, init_simpin_check, modem);
+		return;
+	}
+
+	data->cpin_poll_count =3D 0;
+
+	/* Modem returns ERROR if there is no SIM in slot. */
+	data->have_sim =3D ok;
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static gboolean init_simpin_check(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+
+	data->cpin_poll_source =3D 0;
+
+	g_at_chat_send(data->chat, "AT+CPIN?", cpin_prefix,
+			simpin_check, modem, NULL);
+
+	return FALSE;
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 =

 	DBG("");
 =

-	if (!ok)
+	if (!ok) {
 		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
 =

-	ofono_modem_set_powered(modem, TRUE);
+	init_simpin_check(modem);
 }
 =

 static int ste_enable(struct ofono_modem *modem)
-- =

1.6.3.3


--===============0134447971415655876==--

