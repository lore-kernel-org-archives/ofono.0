Content-Type: multipart/mixed; boundary="===============0276337682233262432=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 5/5] gsmdial: Configure network interface for PPP
Date: Fri, 25 Jun 2010 11:19:09 +0800
Message-ID: <1277435949-5976-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1277435949-5976-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0276337682233262432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index a69a610..59f1a5c 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -38,6 +38,8 @@
 #include <gattty.h>
 #include <gatppp.h>
 =

+#define IFCONFIG_PATH "/sbin/ifconfig"
+
 static const char *none_prefix[] =3D { NULL };
 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *creg_prefix[] =3D { "+CREG:", NULL };
@@ -221,16 +223,43 @@ out:
 	return FALSE;
 }
 =

+static gboolean execute(const char *cmd)
+{
+	int status;
+
+	status =3D system(cmd);
+	if (status < 0) {
+		g_print("Failed to execute command: %s\n", strerror(errno));
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static void ppp_connect(const char *iface, const char *local, const char *=
peer,
 			const char *dns1, const char *dns2,
 			gpointer user_data)
 {
+	char buf[512];
+
 	/* print out the negotiated address and dns server */
 	g_print("Network Device: %s\n", iface);
 	g_print("IP Address: %s\n", local);
 	g_print("Peer IP Address: %s\n", peer);
 	g_print("Primary DNS Server: %s\n", dns1);
 	g_print("Secondary DNS Server: %s\n", dns2);
+
+	if (getuid() !=3D 0) {
+		g_print("Need root priviledge to config PPP interface\n");
+		return;
+	}
+
+	snprintf(buf, sizeof(buf), "%s %s up", IFCONFIG_PATH, iface);
+	execute(buf);
+
+	snprintf(buf, sizeof(buf), "%s %s %s pointopoint %s", IFCONFIG_PATH,
+				iface, local, peer);
+	execute(buf);
 }
 =

 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
-- =

1.6.3.3


--===============0276337682233262432==--

