Content-Type: multipart/mixed; boundary="===============2163711254150272017=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 16/16] gatchat: M15 coding styles fixes
Date: Wed, 12 Jan 2011 12:52:18 +0200
Message-ID: <1294829538-3893-17-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2163711254150272017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatsyntax.c   |    4 ++--
 gatchat/gatsyntax.h   |    4 ++--
 gatchat/gsmdial.c     |    4 ++--
 gatchat/test-server.c |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gatchat/gatsyntax.c b/gatchat/gatsyntax.c
index f5a409b..2fc70b8 100644
--- a/gatchat/gatsyntax.c
+++ b/gatchat/gatsyntax.c
@@ -332,12 +332,12 @@ GAtSyntax *g_at_syntax_new_full(GAtSyntaxFeedFunc fee=
d,
 }
 =

 =

-GAtSyntax *g_at_syntax_new_gsmv1()
+GAtSyntax *g_at_syntax_new_gsmv1(void)
 {
 	return g_at_syntax_new_full(gsmv1_feed, gsmv1_hint, GSMV1_STATE_IDLE);
 }
 =

-GAtSyntax *g_at_syntax_new_gsm_permissive()
+GAtSyntax *g_at_syntax_new_gsm_permissive(void)
 {
 	return g_at_syntax_new_full(gsm_permissive_feed, gsm_permissive_hint,
 					GSM_PERMISSIVE_STATE_IDLE);
diff --git a/gatchat/gatsyntax.h b/gatchat/gatsyntax.h
index d76cf6f..afc0bd3 100644
--- a/gatchat/gatsyntax.h
+++ b/gatchat/gatsyntax.h
@@ -69,13 +69,13 @@ GAtSyntax *g_at_syntax_new_full(GAtSyntaxFeedFunc feed,
  * properly and can be used to detect a modem's deviations from the releva=
nt
  * standards.
  */
-GAtSyntax *g_at_syntax_new_gsmv1();
+GAtSyntax *g_at_syntax_new_gsmv1(void);
 =

 /* This syntax implements an extremely lax parser that can handle a variety
  * of modems.  Unfortunately it does not deal with echo at all, so echo mu=
st
  * be explicitly turned off before using the parser
  */
-GAtSyntax *g_at_syntax_new_gsm_permissive();
+GAtSyntax *g_at_syntax_new_gsm_permissive(void);
 =

 GAtSyntax *g_at_syntax_ref(GAtSyntax *syntax);
 void g_at_syntax_unref(GAtSyntax *syntax);
diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 22ff2ff..1be80e3 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -509,7 +509,7 @@ static void check_mode(gboolean ok, GAtResult *result, =
gpointer user_data)
 	g_at_chat_send(control, "AT+CFUN=3D1", NULL, check_pin, NULL, NULL);
 }
 =

-static int open_serial()
+static int open_serial(void)
 {
 	GAtSyntax *syntax;
 	GIOChannel *channel;
@@ -551,7 +551,7 @@ static int open_serial()
 	return 0;
 }
 =

-static int open_ip()
+static int open_ip(void)
 {
 	int sk, err;
 	struct sockaddr_in addr;
diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index cb451e9..ffe59d7 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -67,7 +67,7 @@ static GAtServer *server;
 static GAtPPP *ppp;
 unsigned int server_watch;
 =

-static gboolean server_cleanup()
+static gboolean server_cleanup(void)
 {
 	if (server_watch)
 		g_source_remove(server_watch);
@@ -1090,7 +1090,7 @@ static gboolean signal_cb(GIOChannel *channel, GIOCon=
dition cond, gpointer data)
 	return TRUE;
 }
 =

-static int create_signal_io()
+static int create_signal_io(void)
 {
 	sigset_t mask;
 	GIOChannel *signal_io;
-- =

1.7.0.4


--===============2163711254150272017==--

