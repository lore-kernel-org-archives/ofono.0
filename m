Content-Type: multipart/mixed; boundary="===============0407055421818901943=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 06/18] emulator: add ppp_suspend() CB and register it
Date: Fri, 25 Mar 2011 16:25:37 +0100
Message-ID: <1301066749-12052-7-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0407055421818901943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c84f0a9..c1ceb36 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -99,6 +99,15 @@ static void ppp_disconnect(GAtPPPDisconnectReason reason=
, gpointer user_data)
 	g_at_server_resume(em->server);
 }
 =

+static void ppp_suspend(gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+
+	DBG("");
+
+	g_at_server_resume(em->server);
+}
+
 static gboolean setup_ppp(gpointer user_data)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -126,6 +135,7 @@ static gboolean setup_ppp(gpointer user_data)
 =

 	g_at_ppp_set_connect_function(em->ppp, ppp_connect, em);
 	g_at_ppp_set_disconnect_function(em->ppp, ppp_disconnect, em);
+	g_at_ppp_set_suspend_function(em->ppp, ppp_suspend, em);
 =

 	return FALSE;
 }
-- =

1.7.1


--===============0407055421818901943==--

