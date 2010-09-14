Content-Type: multipart/mixed; boundary="===============6649538664811006709=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/6] Fix common misspellings in gatchat
Date: Tue, 14 Sep 2010 00:06:02 -0300
Message-ID: <1284433565-26126-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <4C8EDFF9.4060006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6649538664811006709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix common misspellings by using the list available at
http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_mac=
hines.

From the list cited above, the substitution script found the following
misspellings:

priviledge->privilege
succeded->succeeded
---
 gatchat/gatppp.c      |    2 +-
 gatchat/gsmdial.c     |    2 +-
 gatchat/test-server.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 63508b5..5e875b8 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -51,7 +51,7 @@ enum ppp_phase {
 	PPP_PHASE_ESTABLISHMENT,	/* LCP started */
 	PPP_PHASE_AUTHENTICATION,	/* Auth started */
 	PPP_PHASE_NETWORK,		/* IPCP started */
-	PPP_PHASE_LINK_UP,		/* IPCP negotiation succeded, link up */
+	PPP_PHASE_LINK_UP,		/* IPCP negotiation succeeded, link up */
 	PPP_PHASE_TERMINATION,		/* LCP Terminate phase */
 };
 =

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 9aa2f79..57d0d9e 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -250,7 +250,7 @@ static void ppp_connect(const char *iface, const char *=
local, const char *peer,
 	g_print("Secondary DNS Server: %s\n", dns2);
 =

 	if (getuid() !=3D 0) {
-		g_print("Need root priviledge to config PPP interface\n");
+		g_print("Need root privilege to config PPP interface\n");
 		return;
 	}
 =

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 49012dc..c405f41 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -159,7 +159,7 @@ static gboolean setup_ppp(gpointer user)
 	GAtIO *io;
 =

 	if (getuid() !=3D 0) {
-		g_print("Need root priviledge for PPP connection\n");
+		g_print("Need root privilege for PPP connection\n");
 		return FALSE;
 	}
 =

-- =

1.7.2.3


--===============6649538664811006709==--

