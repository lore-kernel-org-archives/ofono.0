Content-Type: multipart/mixed; boundary="===============4039701199826593964=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 3/5] gatppp: add public suspend/resume APIs and suspended
 state
Date: Fri, 20 May 2011 11:38:14 +0200
Message-ID: <1305884296-2601-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305884296-2601-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4039701199826593964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 gatchat/gatppp.h |    2 +
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index c776811..efa909b 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -46,6 +46,8 @@
 #define PPP_ADDR_FIELD	0xff
 #define PPP_CTRL	0x03
 =

+#define GUARD_TIMEOUTS 1500
+
 enum ppp_phase {
 	PPP_PHASE_DEAD =3D 0,		/* Link dead */
 	PPP_PHASE_ESTABLISHMENT,	/* LCP started */
@@ -78,6 +80,8 @@ struct _GAtPPP {
 	guint ppp_dead_source;
 	GAtSuspendFunc suspend_func;
 	gpointer suspend_data;
+	guint guard_timeout_src;
+	gboolean suspended;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -473,6 +477,7 @@ static void ppp_proxy_suspend_net_interface(gpointer us=
er_data)
 {
 	GAtPPP *ppp =3D user_data;
 =

+	ppp->suspended =3D TRUE;
 	ppp_net_suspend_interface(ppp->net);
 =

 	if (ppp->suspend_func)
@@ -500,6 +505,60 @@ void g_at_ppp_shutdown(GAtPPP *ppp)
 	pppcp_signal_close(ppp->lcp);
 }
 =

+static gboolean call_suspend_cb(gpointer user_data)
+{
+	GAtPPP *ppp =3D user_data;
+
+	ppp->guard_timeout_src =3D 0;
+
+	if (ppp->suspend_func)
+		ppp->suspend_func(ppp->suspend_data);
+
+	return FALSE;
+}
+
+static gboolean send_escape_sequence(gpointer user_data)
+{
+	GAtPPP *ppp =3D user_data;
+	GAtIO *io =3D g_at_hdlc_get_io(ppp->hdlc);
+
+	ppp->guard_timeout_src =3D 0;
+	g_at_io_write(io, "+++", 3);
+	ppp->guard_timeout_src  =3D g_timeout_add(GUARD_TIMEOUTS,
+						call_suspend_cb, ppp);
+
+	return FALSE;
+}
+
+void g_at_ppp_suspend(GAtPPP *ppp)
+{
+	if (ppp =3D=3D NULL)
+		return;
+
+	ppp->suspended =3D TRUE;
+	ppp_net_suspend_interface(ppp->net);
+	g_at_hdlc_suspend(ppp->hdlc);
+	ppp->guard_timeout_src =3D g_timeout_add(GUARD_TIMEOUTS,
+						send_escape_sequence, ppp);
+}
+
+void g_at_ppp_resume(GAtPPP *ppp)
+{
+	if (ppp =3D=3D NULL)
+		return;
+
+	if (g_at_hdlc_get_io(ppp->hdlc) =3D=3D NULL) {
+		io_disconnect(ppp);
+		return;
+	}
+
+	ppp->suspended =3D FALSE;
+	g_at_io_set_disconnect_function(g_at_hdlc_get_io(ppp->hdlc),
+							io_disconnect, ppp);
+	ppp_net_resume_interface(ppp->net);
+	g_at_hdlc_resume(ppp->hdlc);
+}
+
 void g_at_ppp_ref(GAtPPP *ppp)
 {
 	g_atomic_int_inc(&ppp->ref_count);
@@ -517,8 +576,9 @@ void g_at_ppp_unref(GAtPPP *ppp)
 	if (is_zero =3D=3D FALSE)
 		return;
 =

-	g_at_io_set_disconnect_function(g_at_hdlc_get_io(ppp->hdlc),
-						NULL, NULL);
+	if (ppp->suspended =3D=3D FALSE)
+		g_at_io_set_disconnect_function(g_at_hdlc_get_io(ppp->hdlc),
+							NULL, NULL);
 =

 	if (ppp->net)
 		ppp_net_free(ppp->net);
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 9464ffd..ab337d7 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -64,6 +64,8 @@ void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspen=
dFunc func,
 					gpointer user_data);
 void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func, gpointer user_data=
);
 void g_at_ppp_shutdown(GAtPPP *ppp);
+void g_at_ppp_suspend(GAtPPP *ppp);
+void g_at_ppp_resume(GAtPPP *ppp);
 void g_at_ppp_ref(GAtPPP *ppp);
 void g_at_ppp_unref(GAtPPP *ppp);
 =

-- =

1.7.1


--===============4039701199826593964==--

