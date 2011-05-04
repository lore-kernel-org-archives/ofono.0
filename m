Content-Type: multipart/mixed; boundary="===============8024690775812201814=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 5/8] emulator: add suspend_ppp() definition and and
 register it into GAtPPP
Date: Wed, 04 May 2011 17:39:03 +0200
Message-ID: <1304523546-643-6-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1304523546-643-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8024690775812201814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 9055909..5963ffb 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -105,6 +105,15 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
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
@@ -132,6 +141,7 @@ static gboolean setup_ppp(gpointer user_data)
 =

 	g_at_ppp_set_connect_function(em->ppp, ppp_connect, em);
 	g_at_ppp_set_disconnect_function(em->ppp, ppp_disconnect, em);
+	g_at_ppp_set_suspend_function(em->ppp, ppp_suspend, em);
 =

 	return FALSE;
 }
-- =

1.7.1


--===============8024690775812201814==--

