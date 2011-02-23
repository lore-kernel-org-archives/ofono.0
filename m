Content-Type: multipart/mixed; boundary="===============8711224514093109227=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/4] PPP:Add new function declarations for using resume
 callback
Date: Wed, 23 Feb 2011 16:29:23 +0100
Message-ID: <1298474966-1691-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8711224514093109227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gat.h     |    1 +
 gatchat/gathdlc.h |    7 +++++++
 gatchat/gatppp.h  |    2 ++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gatchat/gat.h b/gatchat/gat.h
index ddf8695..77ea402 100644
--- a/gatchat/gat.h
+++ b/gatchat/gat.h
@@ -29,6 +29,7 @@ extern "C" {
 #endif
 =

 typedef void (*GAtDisconnectFunc)(gpointer user_data);
+typedef void (*GAtResumeFunc)(gpointer user_data);
 typedef void (*GAtReceiveFunc)(const unsigned char *data, gsize size,
 							gpointer user_data);
 typedef void (*GAtDebugFunc)(const char *str, gpointer user_data);
diff --git a/gatchat/gathdlc.h b/gatchat/gathdlc.h
index 132e1a9..b74bef8 100644
--- a/gatchat/gathdlc.h
+++ b/gatchat/gathdlc.h
@@ -55,6 +55,13 @@ void g_at_hdlc_set_recording(GAtHDLC *hdlc, const char *=
filename);
 =

 GAtIO *g_at_hdlc_get_io(GAtHDLC *hdlc);
 =

+gboolean g_at_hdlc_need_write_data(GAtHDLC *hdlc);
+
+void g_at_hdlc_notify_ppp_disc(GAtHDLC *hdlc);
+
+void g_at_hdlc_set_resume(GAtHDLC *hdlc, GAtResumeFunc func,
+							gpointer user_data);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index fb5de4c..98d7cea 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -61,6 +61,8 @@ void g_at_ppp_set_connect_function(GAtPPP *ppp, GAtPPPCon=
nectFunc callback,
 void g_at_ppp_set_disconnect_function(GAtPPP *ppp, GAtPPPDisconnectFunc fu=
nc,
 					gpointer user_data);
 void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func, gpointer user_data=
);
+void g_at_ppp_set_resume_function(GAtPPP *ppp, GAtResumeFunc func,
+					gpointer user_data);
 void g_at_ppp_shutdown(GAtPPP *ppp);
 void g_at_ppp_ref(GAtPPP *ppp);
 void g_at_ppp_unref(GAtPPP *ppp);
-- =

1.7.1


--===============8711224514093109227==--

