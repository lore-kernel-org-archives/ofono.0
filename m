Content-Type: multipart/mixed; boundary="===============6031748952062838334=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 11/18] gatppp: add g_at_ppp_resume() definition.
Date: Fri, 25 Mar 2011 16:25:42 +0100
Message-ID: <1301066749-12052-12-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6031748952062838334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 9df6b8e..29271e4 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -537,6 +537,22 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const char =
*remote,
 	ipcp_set_server_info(ppp->ipcp, r, d1, d2);
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
+}
+
 static GAtPPP *ppp_init_common(GAtHDLC *hdlc, gboolean is_server, guint32 =
ip)
 {
 	GAtPPP *ppp;
-- =

1.7.1


--===============6031748952062838334==--

