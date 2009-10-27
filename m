Content-Type: multipart/mixed; boundary="===============2238163048114522329=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: [PATCH 1/2] Altered the options for the modem.conf to include more
 tty options.
Date: Tue, 27 Oct 2009 13:54:31 +0100
Message-ID: <632f5f310910270554q7a69a7dcj39bd947289b00bb3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2238163048114522329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The modem.conf patch split into gatchat changes.

Regards,
Ryan

---
 gatchat/gattty.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

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
-- =

1.6.4.GIT

--===============2238163048114522329==--

