Content-Type: multipart/mixed; boundary="===============4845232454353828283=="
MIME-Version: 1.0
From: Helen Clemson <clemson.helen@gmail.com>
Subject: [PATCH] plugins: Restructure caif channel creation
Date: Thu, 02 Dec 2010 12:05:40 +0100
Message-ID: <1291287940-15823-1-git-send-email-clemson.helen@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4845232454353828283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Helen Clemson <helen.clemson@stericsson.com>

This is restructuring the caif channel creation, so that at a later
date multiple AT channels can be supported. This effectively moves
the channel creation from ste_enable, into its own function,
ste_create_channel.
---
 plugins/ste.c |   40 ++++++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index ecdc326..8bebfa4 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -64,8 +64,12 @@
 #include <drivers/stemodem/caif_socket.h>
 #include <drivers/stemodem/if_caif.h>
 =

+#define NUM_CHAT	1
+
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 =

+static char *chat_prefixes[NUM_CHAT] =3D { "Default: " };
+
 struct ste_data {
 	GAtChat *chat;
 	guint cpin_poll_source;
@@ -162,11 +166,9 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	init_simpin_check(modem);
 }
 =

-static int ste_enable(struct ofono_modem *modem)
+static GIOChannel *ste_create_channel(struct ofono_modem *modem)
 {
-	struct ste_data *data =3D ofono_modem_get_data(modem);
 	GIOChannel *channel;
-	GAtSyntax *syntax;
 	const char *device;
 	int fd;
 =

@@ -182,7 +184,7 @@ static int ste_enable(struct ofono_modem *modem)
 		fd =3D socket(AF_CAIF, SOCK_STREAM, CAIFPROTO_AT);
 		if (fd < 0) {
 			ofono_error("Failed to create CAIF socket for AT");
-			return -EIO;
+			return NULL;
 		}
 =

 		/* Bind CAIF socket to specified interface */
@@ -197,7 +199,7 @@ static int ste_enable(struct ofono_modem *modem)
 				ofono_error("Failed to bind caif socket "
 					"to interface");
 				close(fd);
-				return err;
+				return NULL;
 			}
 		}
 =

@@ -210,37 +212,51 @@ static int ste_enable(struct ofono_modem *modem)
 		if (err < 0) {
 			ofono_error("Failed to connect CAIF socket for AT");
 			close(fd);
-			return err;
+			return NULL;
 		}
 	} else {
 		fd =3D open(device, O_RDWR);
 		if (fd < 0) {
 			ofono_error("Failed to open device %s", device);
-			return -EIO;
+			return NULL;
 		}
 	}
 =

 	channel =3D g_io_channel_unix_new(fd);
 	if (channel =3D=3D NULL)  {
 		close(fd);
-		return -EIO;
+		return NULL;
 	}
 	g_io_channel_set_close_on_unref(channel, TRUE);
 =

+	return channel;
+}
+
+static int ste_enable(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+
 	syntax =3D g_at_syntax_new_gsm_permissive();
 =

+	channel =3D ste_create_channel(modem);
+	if (!channel)
+		return -EIO;
+
 	data->chat =3D g_at_chat_new_blocking(channel, syntax);
-	g_at_syntax_unref(syntax);
+	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
+		NULL, NULL, NULL, NULL);
+
 	g_io_channel_unref(channel);
+	g_at_syntax_unref(syntax);
 =

 	if (data->chat =3D=3D NULL)
 		return -ENOMEM;
 =

 	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(data->chat, ste_debug, "");
+		g_at_chat_set_debug(data->chat, ste_debug, chat_prefixes[0]);
 =

-	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
-			NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL, cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
-- =

1.7.1


--===============4845232454353828283==--

