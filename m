Content-Type: multipart/mixed; boundary="===============2037226933275379467=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 4/4] gsmdial:Remove root user test
Date: Wed, 23 Feb 2011 16:29:26 +0100
Message-ID: <1298474966-1691-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2037226933275379467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index c2bcf73..8c0b91f 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -250,11 +250,6 @@ static void ppp_connect(const char *iface, const char =
*local, const char *peer,
 	g_print("Primary DNS Server: %s\n", dns1);
 	g_print("Secondary DNS Server: %s\n", dns2);
 =

-	if (getuid() !=3D 0) {
-		g_print("Need root privilege to config PPP interface\n");
-		return;
-	}
-
 	snprintf(buf, sizeof(buf), "%s %s up", IFCONFIG_PATH, iface);
 	execute(buf);
 =

@@ -283,6 +278,16 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
 	g_at_ppp_unref(ppp);
 	ppp =3D NULL;
 =

+	if (reason =3D=3D G_AT_PPP_REASON_LINK_DEAD) {
+		g_at_chat_unref(modem);
+		modem =3D NULL;
+		return;
+	}
+
+	if (reason =3D=3D G_AT_PPP_REASON_NET_FAIL) {
+		g_print("Failed to create tun\nNeed root privilege to configure PPP inte=
rface\n");
+	}
+
 	g_at_chat_resume(modem);
 =

 	g_at_chat_register(modem, "NO CARRIER", no_carrier_notify,
-- =

1.7.1


--===============2037226933275379467==--

