Content-Type: multipart/mixed; boundary="===============6387924810206085620=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/3] gsmdial: use g_at_ppp_new_from_io()
Date: Mon, 10 May 2010 11:39:43 -0700
Message-ID: <1273516783-5132-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1273516783-5132-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6387924810206085620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index fd9b73b..cfdec87 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -241,7 +241,7 @@ static void ppp_disconnect(GAtPPPDisconnectReason reaso=
n, gpointer user_data)
 =

 static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
-	GIOChannel *channel;
+	GAtIO *io;
 =

 	if (!ok) {
 		g_print("Unable to define context\n");
@@ -249,7 +249,7 @@ static void connect_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	}
 =

 	/* get the data IO channel */
-	channel =3D g_at_chat_get_channel(modem);
+	io =3D g_at_chat_get_io(modem);
 =

 	/*
 	 * shutdown gatchat or else it tries to take all the input
@@ -259,7 +259,7 @@ static void connect_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	g_at_chat_suspend(modem);
 =

 	/* open ppp */
-	ppp =3D g_at_ppp_new(channel);
+	ppp =3D g_at_ppp_new_from_io(io);
 	if (!ppp) {
 		g_print("Unable to create PPP object\n");
 		exit(1);
-- =

1.6.6.1


--===============6387924810206085620==--

