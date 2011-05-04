Content-Type: multipart/mixed; boundary="===============5748360086947645384=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 2/8] ppp_net: add ppp_net_suspend_interface() function
Date: Wed, 04 May 2011 17:39:00 +0200
Message-ID: <1304523546-643-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1304523546-643-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5748360086947645384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp.h     |    1 +
 gatchat/ppp_net.c |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index d2786d7..22809d8 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -107,6 +107,7 @@ const char *ppp_net_get_interface(struct ppp_net *net);
 void ppp_net_process_packet(struct ppp_net *net, const guint8 *packet);
 void ppp_net_free(struct ppp_net *net);
 gboolean ppp_net_set_mtu(struct ppp_net *net, guint16 mtu);
+void ppp_net_suspend_interface(struct ppp_net *net);
 =

 /* PPP functions related to main GAtPPP object */
 void ppp_debug(GAtPPP *ppp, const char *str);
diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 1a6cdf7..9abf590 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -196,3 +196,12 @@ void ppp_net_free(struct ppp_net *net)
 	g_free(net->if_name);
 	g_free(net);
 }
+
+void ppp_net_suspend_interface(struct ppp_net *net)
+{
+	if (net =3D=3D NULL || net->channel =3D=3D NULL)
+		return;
+
+	if (net->watch)
+		g_source_remove(net->watch);
+}
-- =

1.7.1


--===============5748360086947645384==--

