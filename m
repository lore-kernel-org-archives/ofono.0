Content-Type: multipart/mixed; boundary="===============8355658776117615485=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 13/26] gatppp: add g_at_ppp_suspend() definition
Date: Fri, 01 Apr 2011 10:56:15 +0200
Message-ID: <1301648188-7208-14-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8355658776117615485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 9df6b8e..5f005fe 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -484,6 +484,15 @@ void g_at_ppp_shutdown(GAtPPP *ppp)
 	pppcp_signal_close(ppp->lcp);
 }
 =

+void g_at_ppp_suspend(GAtPPP *ppp)
+{
+	if (ppp =3D=3D NULL)
+		return;
+
+	ppp_net_suspend_interface(ppp->net);
+	g_at_hdlc_suspend(ppp->hdlc);
+}
+
 void g_at_ppp_ref(GAtPPP *ppp)
 {
 	g_atomic_int_inc(&ppp->ref_count);
-- =

1.7.1


--===============8355658776117615485==--

