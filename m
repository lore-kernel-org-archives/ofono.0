Content-Type: multipart/mixed; boundary="===============2311595982352996220=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: [PATCH 1/1] Extended modem.conf
Date: Tue, 27 Oct 2009 10:42:39 +0100
Message-ID: <632f5f310910270242g5d1f594bse3a9085e542d27a@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2311595982352996220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allright. This is the one to consider. I used the checkpatch.pl, which
informed me of my wayward ways.

I read from previous mails that the signed-off is not needed, is that
still in effect?

Sorry for the noise.

Regards,
Ryan

---
 gatchat/gattty.c    |   16 +++++++-------
 plugins/atgen.c     |   48 ++++++++++++++++++++++++++++++++++++++--
 plugins/modemconf.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 3 files changed, 111 insertions(+), 12 deletions(-)

diff --git a/gatchat/gattty.c b/gatchat/gattty.c
index f18eca4..64dd8ab 100644
--- a/gatchat/gattty.c
+++ b/gatchat/gattty.c
@@ -208,21 +208,21 @@ static int open_device(const char *tty,
GHashTable *options)
 							(void *) &value)) {
 			gboolean ok =3D FALSE;

-			if (g_str_equal(key, "baud"))
+			if (g_str_equal(key, "Baud"))
 				ok =3D set_baud(value, &ti);
-			else if (g_str_equal(key, "stopbits"))
+			else if (g_str_equal(key, "StopBits"))
 				ok =3D set_stop_bits(value, &ti);
-			else if (g_str_equal(key, "databits"))
+			else if (g_str_equal(key, "DataBits"))
 				ok =3D set_data_bits(value, &ti);
-			else if (g_str_equal(key, "parity"))
+			else if (g_str_equal(key, "Parity"))
 				ok =3D set_parity(value, &ti);
-			else if (g_str_equal(key, "xonxoff"))
+			else if (g_str_equal(key, "XonXoff"))
 				ok =3D set_xonxoff(value, &ti);
-			else if (g_str_equal(key, "rtscts"))
+			else if (g_str_equal(key, "Rtscts"))
 				ok =3D set_rtscts(value, &ti);
-			else if (g_str_equal(key, "local"))
+			else if (g_str_equal(key, "Local"))
 				ok =3D set_local(value, &ti);
-			else if (g_str_equal(key, "read"))
+			else if (g_str_equal(key, "Read"))
 				ok =3D set_read(value, &ti);

 			if (ok =3D=3D FALSE)
diff --git a/plugins/atgen.c b/plugins/atgen.c
index c0fbbb2..db59e36 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -48,6 +48,24 @@
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>

+static const char *tty_opts[] =3D
+  {
+	  "Baud",
+	  "Read",
+	  "Local",
+	  "StopBits",
+	  "DataBits",
+	  "Parity",
+	  "XonXoff",
+	  "Rtscts",
+	  NULL,
+  };
+
+static void unregister_tty_option(gpointer data)
+{
+	g_free(data);
+}
+
 static int atgen_probe(struct ofono_modem *modem)
 {
 	return 0;
@@ -68,6 +86,9 @@ static int atgen_enable(struct ofono_modem *modem)
 	GIOChannel *channel;
 	GAtSyntax *syntax;
 	const char *device;
+	const char *value;
+	GHashTable *options;
+	int i =3D 0;

 	DBG("%p", modem);

@@ -75,23 +96,44 @@ static int atgen_enable(struct ofono_modem *modem)
 	if (!device)
 		return -EINVAL;

-	channel =3D g_at_tty_open(device, NULL);
-	if (!channel)
+	options =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+					g_free, unregister_tty_option);
+	if (!options)
+		return -ENOMEM;
+
+	while (tty_opts[i]) {
+
+		value =3D ofono_modem_get_string(modem, tty_opts[i]);
+		if (value) {
+			g_hash_table_replace(options, g_strdup(tty_opts[i]),
+					     g_strdup(value));
+		}
+		i++;
+	};
+
+	channel =3D g_at_tty_open(device, options);
+	if (!channel) {
+		g_hash_table_destroy(options);
 		return -EIO;
+	}

 	syntax =3D g_at_syntax_new_gsmv1();
 	chat =3D g_at_chat_new(channel, syntax);
 	g_at_syntax_unref(syntax);
 	g_io_channel_unref(channel);

-	if (!chat)
+	if (!chat) {
+		g_hash_table_destroy(options);
 		return -ENOMEM;
+	}

 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(chat, atgen_debug, NULL);

 	ofono_modem_set_data(modem, chat);

+	g_hash_table_destroy(options);
+
 	return 0;
 }

diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index 192faa6..6b317e6 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -72,7 +72,7 @@ static int set_address(struct ofono_modem *modem,
 static int set_device(struct ofono_modem *modem,
 					GKeyFile *keyfile, const char *group)
 {
-	char *device;
+	char *device, *value;

 	device =3D g_key_file_get_string(keyfile, group, "Device", NULL);
 	if (!device)
@@ -82,6 +82,63 @@ static int set_device(struct ofono_modem *modem,

 	g_free(device);

+	value =3D g_key_file_get_string(keyfile, group, "Baud", NULL);
+	if (value) {
+		ofono_modem_set_string(modem, "Baud", value);
+		g_free(value);
+	} else
+		ofono_modem_set_string(modem, "Baud", "115200");
+
+	value =3D g_key_file_get_string(keyfile, group, "Read", NULL);
+	if (value) {
+		ofono_modem_set_string(modem, "Read", value);
+		g_free(value);
+	} else
+		ofono_modem_set_string(modem, "Read", "on");
+
+	value =3D g_key_file_get_string(keyfile, group, "Local", NULL);
+	if (value) {
+		ofono_modem_set_string(modem, "Local", value);
+		g_free(value);
+	} else
+		ofono_modem_set_string(modem, "Local", "none");
+
+	value =3D g_key_file_get_string(keyfile, group, "StopBits", NULL);
+	if (value) {
+		ofono_modem_set_string(modem, "StopBits", value);
+		g_free(value);
+	} else
+		ofono_modem_set_string(modem, "StopBits", "1");
+
+	value =3D g_key_file_get_string(keyfile, group, "DataBits", NULL);
+	if (value) {
+		ofono_modem_set_string(modem, "DataBits", value);
+		g_free(value);
+	} else
+		ofono_modem_set_string(modem, "Databits", "8");
+
+	value =3D g_key_file_get_string(keyfile, group, "Parity", NULL);
+	if (value) {
+		ofono_modem_set_string(modem, "Parity", value);
+		g_free(value);
+	} else
+		ofono_modem_set_string(modem, "Parity", "none");
+
+	value =3D g_key_file_get_string(keyfile, group, "XonXoff", NULL);
+	if (value) {
+		ofono_modem_set_string(modem, "XonXoff", value);
+		g_free(value);
+	} else
+		ofono_modem_set_string(modem, "XonXoff", "off");
+
+	value =3D g_key_file_get_string(keyfile, group, "Rtscts", NULL);
+	if (value) {
+		ofono_modem_set_string(modem, "Rtscts", value);
+		g_free(value);
+	} else
+		ofono_modem_set_string(modem, "Rtscts", "on");
+
+
 	return 0;
 }

-- =

1.6.4.GIT

--===============2311595982352996220==--

