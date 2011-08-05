Content-Type: multipart/mixed; boundary="===============3849298930414088360=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 1/2] gatppp: save dumpfile into ppp info to start recording
 during open phase.
Date: Fri, 05 Aug 2011 10:34:03 +0200
Message-ID: <1312533244-28622-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312533244-28622-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3849298930414088360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 2ff6c86..47a4949 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -85,6 +85,7 @@ struct _GAtPPP {
 	gboolean suspended;
 	gboolean xmit_acfc;
 	gboolean xmit_pfc;
+	gchar *dumpfile;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -541,6 +542,8 @@ gboolean g_at_ppp_open(GAtPPP *ppp, GAtIO *io)
 	if (ppp->hdlc =3D=3D NULL)
 		return FALSE;
 =

+	g_at_hdlc_set_recording(ppp->hdlc, ppp->dumpfile);
+
 	ppp->suspended =3D FALSE;
 	g_at_hdlc_set_receive(ppp->hdlc, ppp_receive, ppp);
 	g_at_hdlc_set_suspend_function(ppp->hdlc,
@@ -593,7 +596,11 @@ void g_at_ppp_set_recording(GAtPPP *ppp, const char *f=
ilename)
 	if (ppp =3D=3D NULL)
 		return;
 =

-	g_at_hdlc_set_recording(ppp->hdlc, filename);
+	g_free(ppp->dumpfile);
+
+	ppp->dumpfile =3D g_strdup(filename);
+
+	g_at_hdlc_set_recording(ppp->hdlc, ppp->dumpfile);
 }
 =

 void g_at_ppp_set_connect_function(GAtPPP *ppp, GAtPPPConnectFunc func,
@@ -745,6 +752,8 @@ void g_at_ppp_unref(GAtPPP *ppp)
 =

 	g_at_hdlc_unref(ppp->hdlc);
 =

+	g_free(ppp->dumpfile);
+
 	g_free(ppp);
 }
 =

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============3849298930414088360==--

