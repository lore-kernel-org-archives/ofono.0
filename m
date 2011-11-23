Content-Type: multipart/mixed; boundary="===============5309289651611149326=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 4/6] ppp_net: Add reference count
Date: Wed, 23 Nov 2011 14:57:50 +0200
Message-ID: <1322053072-20252-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322053072-20252-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5309289651611149326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp.h     |    2 ++
 gatchat/ppp_net.c |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index fa36816..fdaacbc 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -115,6 +115,8 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd);
 const char *ppp_net_get_interface(struct ppp_net *net);
 void ppp_net_process_packet(struct ppp_net *net, const guint8 *packet,
 				gsize len);
+void ppp_net_ref(struct ppp_net *net);
+void ppp_net_unref(struct ppp_net **net);
 void ppp_net_free(struct ppp_net *net);
 gboolean ppp_net_set_mtu(struct ppp_net *net, guint16 mtu);
 void ppp_net_suspend_interface(struct ppp_net *net);
diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 1609b99..e4d4d76 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -41,6 +41,7 @@
 #define MAX_PACKET 1500
 =

 struct ppp_net {
+	gint ref_count;
 	GAtPPP *ppp;
 	char *if_name;
 	GIOChannel *channel;
@@ -189,6 +190,7 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd)
 	net->ppp =3D ppp;
 =

 	net->mtu =3D MAX_PACKET;
+	net->ref_count =3D 1;
 	return net;
 =

 error:
@@ -206,6 +208,21 @@ badalloc:
 	return NULL;
 }
 =

+void ppp_net_ref(struct ppp_net *net)
+{
+	g_atomic_int_inc(&net->ref_count);
+}
+
+void ppp_net_unref(struct ppp_net **net)
+{
+	if (*net =3D=3D NULL ||
+			g_atomic_int_dec_and_test(&(*net)->ref_count) =3D=3D FALSE)
+		return;
+
+	ppp_net_free(*net);
+	*net =3D NULL;
+}
+
 void ppp_net_free(struct ppp_net *net)
 {
 	if (net->watch) {
-- =

1.7.5.4


--===============5309289651611149326==--

