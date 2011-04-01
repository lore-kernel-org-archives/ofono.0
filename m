Content-Type: multipart/mixed; boundary="===============2329275200350450334=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 19/26] ppp_net: add ppp_net_resume_interface() definition
Date: Fri, 01 Apr 2011 10:56:21 +0200
Message-ID: <1301648188-7208-20-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2329275200350450334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_net.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 9abf590..6ace16b 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -205,3 +205,13 @@ void ppp_net_suspend_interface(struct ppp_net *net)
 	if (net->watch)
 		g_source_remove(net->watch);
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


--===============2329275200350450334==--

