Content-Type: multipart/mixed; boundary="===============7706351823786484917=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 18:01:26 +0200
Message-ID: <20190924160126.26221-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7706351823786484917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

uBlox devices present their USB interfaces well before those interfaces
are ready to respond to any commands.  The documentation says to monitor
the 'greeting text' to detect readiness, but this 'greeting text' is not
actually specified for any device other than the TOBY L4.

What seems to work is to probe the device with 'AT' commands until the
device responds, and then to wait an additional second before
proceeding.  The TOBY L4 reliably sends its 'greeting text' (+AT: READY)
within this interval.

It would be more rigorous to actually wait for the 'READY' indication
for the TOBY L4, but that would require knowing the device model before
the device model is actually queried.  This is doable via the USB
product ID, but overkill when the above heuristic seems to work
reliably.

Before this patch, the ublox plugin was trying to achieve something like
the above with the g_at_chat_set_wakeup_command() function, but that had
some issues:

i)  it did not work reliably, in particular failing badly on the TOBY L4
with responses getting out of sync with commands
ii) it was an inappropriate use of the wakeup_command which is intended
for devices that may sleep when there is no communication during some
interval

This patch adds an init sequence that probes the device for readiness
before continuing with initialization.
---

Changed in v2:
- drop return statement
- drop superfluous empty line

 plugins/ublox.c | 119 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 105 insertions(+), 14 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 9ee38a6b..5be9d4cc 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -29,6 +29,7 @@
 #include <glib.h>
 #include <gatchat.h>
 #include <gattty.h>
+#include <ell/ell.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -66,6 +67,10 @@ struct ublox_data {
 =

 	const struct ublox_model *model;
 	int flags;
+
+	struct l_timeout *init_timeout;
+	int init_count;
+	guint init_cmd;
 };
 =

 static void ublox_debug(const char *str, void *user_data)
@@ -223,6 +228,80 @@ fail:
 	ofono_modem_set_powered(modem, FALSE);
 }
 =

+static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ublox_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (!ok)
+		goto fail;
+
+	/* When the 'init command' succeeds, we insert an additional
+	 * delay of 1 second before proceeding with the actual
+	 * intialization of the device.  We reuse the init_timeout
+	 * instance for this, just clearing the command to indicate
+	 * that additional retries aren't necessary.
+	 */
+	data->init_cmd =3D 0;
+	data->init_count =3D 0;
+	l_timeout_modify_ms(data->init_timeout, 1000);
+
+	return;
+
+fail:
+	l_timeout_remove(data->init_timeout);
+	data->init_timeout =3D NULL;
+
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void init_timeout_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ublox_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	/* As long as init_cmd is set we need to either keep retrying
+	 * or fail everything after excessive retries
+	 */
+	if (data->init_cmd && data->init_count++ < 20) {
+		g_at_chat_retry(data->aux, data->init_cmd);
+		l_timeout_modify_ms(timeout, 1000);
+		return;
+	}
+
+	l_timeout_remove(data->init_timeout);
+	data->init_timeout =3D NULL;
+
+	if (data->init_cmd) {
+		ofono_error("failed to init modem after 20 attempts");
+		goto fail;
+	}
+
+	g_at_chat_send(data->aux, "ATE0", none_prefix,
+					NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "AT+CMEE=3D1", none_prefix,
+					NULL, NULL, NULL);
+
+	if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
+				query_model_cb, modem, NULL) > 0)
+		return;
+
+fail:
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+	ofono_modem_set_powered(modem, FALSE);
+}
+
 static int ublox_enable(struct ofono_modem *modem)
 {
 	struct ublox_data *data =3D ofono_modem_get_data(modem);
@@ -250,22 +329,34 @@ static int ublox_enable(struct ofono_modem *modem)
 		g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
 	}
 =

-	/* The modem can take a while to wake up if just powered on. */
-	g_at_chat_set_wakeup_command(data->aux, "AT\r", 1000, 11000);
-
-	g_at_chat_send(data->aux, "ATE0", none_prefix,
-					NULL, NULL, NULL);
-	g_at_chat_send(data->aux, "AT+CMEE=3D1", none_prefix,
-					NULL, NULL, NULL);
-
-	if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
-				query_model_cb, modem, NULL) > 0)
-		return -EINPROGRESS;
+	/*
+	 * uBlox devices present their USB interfaces well before those
+	 * interfaces are actually ready to use.  The specs say to monitor
+	 * the 'greeting text' to detect whether the device is ready to use;
+	 * unfortunately, other than for the TOBY L4, the greeting text is
+	 * not actually specified.
+	 *
+	 * What has been determined experimentally to work is to probe with
+	 * an 'AT' command until it responds and then wait an additional
+	 * second before continuing with device initialization.  Even for
+	 * the TOBY L4 where one should wait for the '+AT: READY' URC
+	 * before intialization, this seems to be sufficient; the 'READY'
+	 * indication always arrives within this time.
+	 *
+	 * (It would be more rigorous to actually wait for the 'READY'
+	 * indication, but that would require knowing the device model
+	 * before the device model is actually queried.  Do-able via
+	 * USB Product ID, but overkill when the above seems to work
+	 * reliably.)
+	 */
 =

-	g_at_chat_unref(data->aux);
-	data->aux =3D NULL;
+	data->init_count =3D 0;
+	data->init_cmd =3D g_at_chat_send(data->aux, "AT", none_prefix,
+					init_cmd_cb, modem, NULL);
+	data->init_timeout =3D l_timeout_create_ms(500, init_timeout_cb, modem,
+							NULL);
 =

-	return -EINVAL;
+	return -EINPROGRESS;
 }
 =

 static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
-- =

2.20.1


--===============7706351823786484917==--

