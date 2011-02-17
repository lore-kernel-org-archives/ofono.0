Content-Type: multipart/mixed; boundary="===============7895548901460347226=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] test-server:Add test of PPP disconnect reason to avoid crash
Date: Thu, 17 Feb 2011 18:27:13 +0100
Message-ID: <1297963633-3820-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7895548901460347226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/test-server.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index e574d64..28bad1d 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -137,6 +137,12 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user)
 	g_at_ppp_unref(ppp);
 	ppp =3D NULL;
 =

+	if (reason =3D=3D G_AT_PPP_REASON_LINK_DEAD) {
+		g_at_server_unref(server);
+		server =3D NULL;
+		return;
+	}
+
 	g_at_server_resume(server);
 	g_at_server_set_debug(server, server_debug, "Server");
 =

-- =

1.7.1


--===============7895548901460347226==--

