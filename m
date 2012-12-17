Content-Type: multipart/mixed; boundary="===============9144720780434342516=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] telit: set baud rate to 115200
Date: Mon, 17 Dec 2012 11:15:57 +0100
Message-ID: <1355739357-24794-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9144720780434342516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Telit HE910 needs the baud rate to be set.
---
 plugins/telit.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index fe2ccd6..64f763a 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -186,6 +186,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	GAtSyntax *syntax;
 	GIOChannel *channel;
 	GAtChat *chat;
+	GHashTable *options;
 =

 	device =3D ofono_modem_get_string(modem, key);
 	if (device =3D=3D NULL)
@@ -193,7 +194,13 @@ static GAtChat *open_device(struct ofono_modem *modem,
 =

 	DBG("%s %s", key, device);
 =

-	channel =3D g_at_tty_open(device, NULL);
+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (options =3D=3D NULL)
+		return NULL;
+
+	g_hash_table_insert(options, "Baud", "115200");
+
+	channel =3D g_at_tty_open(device, options);
 	if (channel =3D=3D NULL)
 		return NULL;
 =

-- =

1.7.7.6


--
Scanned by MailScanner.


--===============9144720780434342516==--

