Content-Type: multipart/mixed; boundary="===============7258180108015932575=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 08/11] gsmdial: Configure network interface for PPP
Date: Sat, 12 Jun 2010 13:50:47 +0800
Message-ID: <1276321850-13307-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-8-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7258180108015932575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 35267e1..29e1d22 100644
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


--===============7258180108015932575==--

