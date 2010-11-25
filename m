Content-Type: multipart/mixed; boundary="===============5983183680553266366=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 3/3] gisi: use strerror_r() instead of strerror()
Date: Thu, 25 Nov 2010 12:51:05 +0200
Message-ID: <1290682265-11373-3-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1290682265-11373-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5983183680553266366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gisi/netlink.c |    8 ++++++--
 gisi/server.c  |   11 ++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/gisi/netlink.c b/gisi/netlink.c
index 44a4a8d..dcc322c 100644
--- a/gisi/netlink.c
+++ b/gisi/netlink.c
@@ -240,8 +240,12 @@ static gboolean g_pn_nl_process(GIOChannel *channel, G=
IOCondition cond,
 		case NLMSG_ERROR: {
 			struct nlmsgerr *err =3D NLMSG_DATA(nlh);
 			if (err->error)
-				g_printerr("Netlink error: %s",
-						strerror(-err->error));
+			{
+				char msg[256];
+
+				strerror_r(-err->error, msg, sizeof(msg));
+				g_printerr("Netlink error: %s", msg);
+			}
 			return TRUE;
 		}
 		case RTM_NEWADDR:
diff --git a/gisi/server.c b/gisi/server.c
index 159bb2d..df2e4eb 100644
--- a/gisi/server.c
+++ b/gisi/server.c
@@ -157,7 +157,10 @@ g_isi_server_add_name(GIsiServer *self)
 		return;
 =

 	if (ioctl(self->fd, SIOCPNGETOBJECT, &object) < 0) {
-		g_warning("%s: %s", "ioctl(SIOCPNGETOBJECT)", strerror(errno));
+		char msg[256];
+
+		strerror_r(errno, msg, sizeof(msg));
+		g_warning("%s: %s", "ioctl(SIOCPNGETOBJECT)", msg);
 	} else {
 		struct sockaddr_pn spn =3D {
 			.spn_family =3D PF_PHONET,
@@ -173,8 +176,10 @@ g_isi_server_add_name(GIsiServer *self)
 =

 		if (sendto(self->fd, req, sizeof(req), 0,
 				(void *)&spn, sizeof(spn)) !=3D sizeof(req)) {
-			g_warning("%s: %s", "sendto(PN_NAMESERVICE)",
-				  strerror(errno));
+			char msg[256];
+
+			strerror_r(errno, msg, sizeof(msg));
+			g_warning("%s: %s", "sendto(PN_NAMESERVICE)", msg);
 		}
 	}
 }
-- =

1.7.1


--===============5983183680553266366==--

