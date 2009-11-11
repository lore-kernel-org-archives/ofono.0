Content-Type: multipart/mixed; boundary="===============0702081542289086081=="
MIME-Version: 1.0
From: Ryan M. Raasch <ryan.raasch@gmail.com>
Subject: [PATCH] Fixed modem options to work with capitalized variable names
 in modem.conf
Date: Wed, 11 Nov 2009 23:44:57 +0100
Message-ID: <1257979497-17560-1-git-send-email-ryan.raasch@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0702081542289086081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This patch fixes the calypso driver when setting the modemconf variables.

Regards,
Ryan

---
 plugins/calypso.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/plugins/calypso.c b/plugins/calypso.c
index eba55dd..ddbec73 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -272,13 +272,13 @@ static void modem_initialize(struct ofono_modem *mode=
m)
 	if (options =3D=3D NULL)
 		goto error;
 =

-	g_hash_table_insert(options, "baud", "115200");
-	g_hash_table_insert(options, "parity", "none");
-	g_hash_table_insert(options, "stopbits", "1");
-	g_hash_table_insert(options, "databits", "8");
-	g_hash_table_insert(options, "xonxoff", "on");
-	g_hash_table_insert(options, "local", "on");
-	g_hash_table_insert(options, "rtscts", "on");
+	g_hash_table_insert(options, "Baud", "115200");
+	g_hash_table_insert(options, "Parity", "none");
+	g_hash_table_insert(options, "StopBits", "1");
+	g_hash_table_insert(options, "DataBits", "8");
+	g_hash_table_insert(options, "XonXoff", "on");
+	g_hash_table_insert(options, "Local", "on");
+	g_hash_table_insert(options, "RtsCts", "on");
 =

 	io =3D g_at_tty_open(device, options);
 	g_hash_table_destroy(options);
-- =

1.6.4.GIT


--===============0702081542289086081==--

