Content-Type: multipart/mixed; boundary="===============8875631425031750486=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 16/18] gatppp: add g_at_ppp_suspend() definition
Date: Fri, 25 Mar 2011 16:25:47 +0100
Message-ID: <1301066749-12052-17-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8875631425031750486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 29271e4..27b7e96 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -484,6 +484,14 @@ void g_at_ppp_shutdown(GAtPPP *ppp)
 	pppcp_signal_close(ppp->lcp);
 }
 =

+void g_at_ppp_suspend(GAtPPP *ppp)
+{
+	if (ppp =3D=3D NULL)
+		return;
+
+	g_at_hdlc_suspend(ppp->hdlc);
+}
+
 void g_at_ppp_ref(GAtPPP *ppp)
 {
 	g_atomic_int_inc(&ppp->ref_count);
-- =

1.7.1


--===============8875631425031750486==--

