Content-Type: multipart/mixed; boundary="===============5222206533284802733=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 3/8] gatppp: add function to set ppp_suspend() and proxy
 function to call ppp_net_suspend_interface()
Date: Wed, 04 May 2011 17:39:01 +0200
Message-ID: <1304523546-643-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1304523546-643-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5222206533284802733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |   24 ++++++++++++++++++++++++
 gatchat/gatppp.h |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 993b5ea..c776811 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -76,6 +76,8 @@ struct _GAtPPP {
 	gpointer debug_data;
 	gboolean sta_pending;
 	guint ppp_dead_source;
+	GAtSuspendFunc suspend_func;
+	gpointer suspend_data;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -467,6 +469,28 @@ void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func=
, gpointer user_data)
 	ppp->debug_data =3D user_data;
 }
 =

+static void ppp_proxy_suspend_net_interface(gpointer user_data)
+{
+	GAtPPP *ppp =3D user_data;
+
+	ppp_net_suspend_interface(ppp->net);
+
+	if (ppp->suspend_func)
+		ppp->suspend_func(ppp->suspend_data);
+}
+
+void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspendFunc func,
+					gpointer user_data)
+{
+	if (ppp =3D=3D NULL)
+		return;
+
+	ppp->suspend_func =3D func;
+	ppp->suspend_data =3D user_data;
+	g_at_hdlc_set_suspend_function(ppp->hdlc,
+					ppp_proxy_suspend_net_interface, ppp);
+}
+
 void g_at_ppp_shutdown(GAtPPP *ppp)
 {
 	if (ppp->phase =3D=3D PPP_PHASE_DEAD || ppp->phase =3D=3D PPP_PHASE_TERMI=
NATION)
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index fb5de4c..9464ffd 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -60,6 +60,8 @@ void g_at_ppp_set_connect_function(GAtPPP *ppp, GAtPPPCon=
nectFunc callback,
 					gpointer user_data);
 void g_at_ppp_set_disconnect_function(GAtPPP *ppp, GAtPPPDisconnectFunc fu=
nc,
 					gpointer user_data);
+void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspendFunc func,
+					gpointer user_data);
 void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func, gpointer user_data=
);
 void g_at_ppp_shutdown(GAtPPP *ppp);
 void g_at_ppp_ref(GAtPPP *ppp);
-- =

1.7.1


--===============5222206533284802733==--

