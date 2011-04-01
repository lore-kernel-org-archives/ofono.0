Content-Type: multipart/mixed; boundary="===============2341217676667011997=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 11/26] ppp_net: add ppp_net_suspend_interface() definition
Date: Fri, 01 Apr 2011 10:56:13 +0200
Message-ID: <1301648188-7208-12-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2341217676667011997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_net.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

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


--===============2341217676667011997==--

