Content-Type: multipart/mixed; boundary="===============6330526898103765715=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v5 1/3] gatppp: add public suspend function
Date: Tue, 10 May 2011 10:34:14 +0200
Message-ID: <1305016456-24542-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305016456-24542-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6330526898103765715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatppp.h |    1 +
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index c776811..2d051d5 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -46,6 +46,9 @@
 #define PPP_ADDR_FIELD	0xff
 #define PPP_CTRL	0x03
 =

+/* Time to wait before and after +++ sequence */
+#define GUARD_TIMEOUTS 1500
+
 enum ppp_phase {
 	PPP_PHASE_DEAD =3D 0,		/* Link dead */
 	PPP_PHASE_ESTABLISHMENT,	/* LCP started */
@@ -78,6 +81,7 @@ struct _GAtPPP {
 	guint ppp_dead_source;
 	GAtSuspendFunc suspend_func;
 	gpointer suspend_data;
+	guint guard_timeout_src;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -500,6 +504,40 @@ void g_at_ppp_shutdown(GAtPPP *ppp)
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
+	ppp->guard_timeout_src  =3D g_timeout_add(GUARD_TIMEOUTS, call_suspend_cb=
, ppp);
+
+	return FALSE;
+}
+
+void g_at_ppp_suspend(GAtPPP *ppp)
+{
+	if (ppp =3D=3D NULL)
+		return;
+
+	ppp_net_suspend_interface(ppp->net);
+	g_at_hdlc_suspend(ppp->hdlc);
+	ppp->guard_timeout_src =3D g_timeout_add(GUARD_TIMEOUTS, send_escape_sequ=
ence, ppp);
+}
+
 void g_at_ppp_ref(GAtPPP *ppp)
 {
 	g_atomic_int_inc(&ppp->ref_count);
@@ -534,6 +572,11 @@ void g_at_ppp_unref(GAtPPP *ppp)
 		ppp->ppp_dead_source =3D 0;
 	}
 =

+	if (ppp->guard_timeout_src) {
+		g_source_remove(ppp->guard_timeout_src);
+		ppp->guard_timeout_src =3D 0;
+	}
+
 	g_at_hdlc_unref(ppp->hdlc);
 =

 	g_free(ppp);
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 9464ffd..66e0ade 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -64,6 +64,7 @@ void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspen=
dFunc func,
 					gpointer user_data);
 void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func, gpointer user_data=
);
 void g_at_ppp_shutdown(GAtPPP *ppp);
+void g_at_ppp_suspend(GAtPPP *ppp);
 void g_at_ppp_ref(GAtPPP *ppp);
 void g_at_ppp_unref(GAtPPP *ppp);
 =

-- =

1.7.1


--===============6330526898103765715==--

