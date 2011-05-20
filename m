Content-Type: multipart/mixed; boundary="===============3512420039463471448=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 2/5] ppp_net: add ppp_net_resume_interface() API
Date: Fri, 20 May 2011 11:38:13 +0200
Message-ID: <1305884296-2601-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305884296-2601-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3512420039463471448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp.h     |    1 +
 gatchat/ppp_net.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 22809d8..ae96e42 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -108,6 +108,7 @@ void ppp_net_process_packet(struct ppp_net *net, const =
guint8 *packet);
 void ppp_net_free(struct ppp_net *net);
 gboolean ppp_net_set_mtu(struct ppp_net *net, guint16 mtu);
 void ppp_net_suspend_interface(struct ppp_net *net);
+void ppp_net_resume_interface(struct ppp_net *net);
 =

 /* PPP functions related to main GAtPPP object */
 void ppp_debug(GAtPPP *ppp, const char *str);
diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 25bcfa4..39cfdfd 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -212,3 +212,13 @@ void ppp_net_suspend_interface(struct ppp_net *net)
 	g_source_remove(net->watch);
 	net->watch =3D 0;
 }
+
+void ppp_net_resume_interface(struct ppp_net *net)
+{
+	if (net =3D=3D NULL || net->channel =3D=3D NULL)
+		return;
+
+	net->watch =3D g_io_add_watch(net->channel,
+			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			ppp_net_callback, net);
+}
-- =

1.7.1


--===============3512420039463471448==--

