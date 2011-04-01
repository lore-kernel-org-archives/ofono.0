Content-Type: multipart/mixed; boundary="===============6791983665250469921=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 07/26] gatppp: add g_at_ppp_set_suspend_function()
 definition
Date: Fri, 01 Apr 2011 10:56:09 +0200
Message-ID: <1301648188-7208-8-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6791983665250469921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 993b5ea..9df6b8e 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -467,6 +467,14 @@ void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func=
, gpointer user_data)
 	ppp->debug_data =3D user_data;
 }
 =

+void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspendFunc func, gpoin=
ter user_data)
+{
+	if (ppp =3D=3D NULL)
+		return;
+
+	g_at_hdlc_set_suspend_function(ppp->hdlc, func, user_data);
+}
+
 void g_at_ppp_shutdown(GAtPPP *ppp)
 {
 	if (ppp->phase =3D=3D PPP_PHASE_DEAD || ppp->phase =3D=3D PPP_PHASE_TERMI=
NATION)
-- =

1.7.1


--===============6791983665250469921==--

