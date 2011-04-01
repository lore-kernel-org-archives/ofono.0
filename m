Content-Type: multipart/mixed; boundary="===============4720535736482400693=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 14/26] emulator: add ppp_suspend() CB and register it
Date: Fri, 01 Apr 2011 10:56:16 +0200
Message-ID: <1301648188-7208-15-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4720535736482400693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c84f0a9..ededf9d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -99,6 +99,16 @@ static void ppp_disconnect(GAtPPPDisconnectReason reason=
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
+	g_at_ppp_suspend(em->ppp);
+	g_at_server_resume(em->server);
+}
+
 static gboolean setup_ppp(gpointer user_data)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -126,6 +136,7 @@ static gboolean setup_ppp(gpointer user_data)
 =

 	g_at_ppp_set_connect_function(em->ppp, ppp_connect, em);
 	g_at_ppp_set_disconnect_function(em->ppp, ppp_disconnect, em);
+	g_at_ppp_set_suspend_function(em->ppp, ppp_suspend, em);
 =

 	return FALSE;
 }
-- =

1.7.1


--===============4720535736482400693==--

