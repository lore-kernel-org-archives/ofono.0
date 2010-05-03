Content-Type: multipart/mixed; boundary="===============9149068190766077312=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] gatio: do not read if no read_handler
Date: Mon, 03 May 2010 15:45:45 -0700
Message-ID: <1272926745-4595-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9149068190766077312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If no read_handler specified, leave data alone in case someone
else wants to read it.
---
 gatchat/gatio.c   |    4 ++++
 gatchat/gsmdial.c |   12 ++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gatchat/gatio.c b/gatchat/gatio.c
index 61b0260..b4a3806 100644
--- a/gatchat/gatio.c
+++ b/gatchat/gatio.c
@@ -91,6 +91,10 @@ static gboolean received_data(GIOChannel *channel, GIOCo=
ndition cond,
 	if (cond & G_IO_NVAL)
 		return FALSE;
 =

+	/* if nobody wants this data, leave it alone */
+	if (io->read_handler =3D=3D NULL)
+		return TRUE;
+
 	/* Regardless of condition, try to read all the data available */
 	do {
 		toread =3D ring_buffer_avail_no_wrap(io->buf);
diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index a531aa3..5fb406d 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -235,6 +235,8 @@ static void ppp_connect(const char *iface, const char *=
ip,
 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
 {
 	g_print("PPP Link down: %d\n", reason);
+	g_at_chat_resume(control);
+	g_at_chat_resume(modem);
 }
 =

 static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -249,14 +251,8 @@ static void connect_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	/* get the data IO channel */
 	channel =3D g_at_chat_get_channel(modem);
 =

-	/*
-	 * shutdown gatchat or else it tries to take all the input
-	 * from the modem and does not let PPP get it.
-	 */
-	g_at_chat_unref(control);
-	control =3D NULL;
-	g_at_chat_unref(modem);
-	modem =3D NULL;
+	g_at_chat_suspend(control);
+	g_at_chat_suspend(modem);
 =

 	/* open ppp */
 	ppp =3D g_at_ppp_new(channel);
-- =

1.6.6.1


--===============9149068190766077312==--

