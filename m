Content-Type: multipart/mixed; boundary="===============4128737552419361871=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 21/26] gatppp: add g_at_ppp_resume() definition.
Date: Fri, 01 Apr 2011 10:56:23 +0200
Message-ID: <1301648188-7208-22-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4128737552419361871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 5f005fe..6dfd965 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -493,6 +493,23 @@ void g_at_ppp_suspend(GAtPPP *ppp)
 	g_at_hdlc_suspend(ppp->hdlc);
 }
 =

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
+	g_at_io_set_disconnect_function(g_at_hdlc_get_io(ppp->hdlc),
+							io_disconnect, ppp);
+
+	g_at_hdlc_resume(ppp->hdlc);
+	ppp_net_resume_interface(ppp->net);
+}
+
 void g_at_ppp_ref(GAtPPP *ppp)
 {
 	g_atomic_int_inc(&ppp->ref_count);
-- =

1.7.1


--===============4128737552419361871==--

