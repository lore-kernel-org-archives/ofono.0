Content-Type: multipart/mixed; boundary="===============7514452465297583049=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 04/11] atmodem: Fix GAtPPPConnectFunc interface change
Date: Sat, 12 Jun 2010 13:50:43 +0800
Message-ID: <1276321850-13307-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7514452465297583049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs-context.c |    5 +++--
 gatchat/gsmdial.c              |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 4ddf88e..fea80b0 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -65,7 +65,8 @@ struct gprs_context_data {
 	void *cb_data;                                  /* Callback data */
 };
 =

-static void ppp_connect(const char *interface, const char *ip,
+static void ppp_connect(const char *interface, const char *local,
+			const char *remote,
 			const char *dns1, const char *dns2,
 			gpointer user_data)
 {
@@ -78,7 +79,7 @@ static void ppp_connect(const char *interface, const char=
 *ip,
 	dns[2] =3D 0;
 =

 	gcd->state =3D STATE_ACTIVE;
-	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, ip,
+	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, local,
 					STATIC_IP_NETMASK, NULL,
 					dns, gcd->cb_data);
 }
diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index a7d38c9..35267e1 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -221,13 +221,14 @@ out:
 	return FALSE;
 }
 =

-static void ppp_connect(const char *iface, const char *ip,
+static void ppp_connect(const char *iface, const char *local, const char *=
peer,
 			const char *dns1, const char *dns2,
 			gpointer user_data)
 {
 	/* print out the negotiated address and dns server */
 	g_print("Network Device: %s\n", iface);
-	g_print("IP Address: %s\n", ip);
+	g_print("IP Address: %s\n", local);
+	g_print("Peer IP Address: %s\n", peer);
 	g_print("Primary DNS Server: %s\n", dns1);
 	g_print("Secondary DNS Server: %s\n", dns2);
 }
-- =

1.6.3.3


--===============7514452465297583049==--

