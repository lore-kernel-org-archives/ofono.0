Content-Type: multipart/mixed; boundary="===============0356488357906387342=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 10/11] stk: Add host route to route the traffic through the
 stk interface
Date: Tue, 28 Jun 2011 19:16:22 +0200
Message-ID: <1309281383-6605-11-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309281383-6605-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0356488357906387342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 9eecee3..58b58df 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -31,6 +31,7 @@
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <unistd.h>
+#include <net/route.h>
 #include <sys/ioctl.h>
 =

 #include <glib.h>
@@ -666,6 +667,44 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	stk_agent_request_cancel(stk->current_agent);
 }
 =

+static void stk_add_host_route(struct ofono_stk *stk, const char *interfac=
e)
+{
+	struct rtentry rt;
+	struct sockaddr_in addr;
+	int sk;
+
+	if (interface =3D=3D NULL)
+		return;
+
+	sk =3D socket(PF_INET, SOCK_DGRAM, 0);
+	if (sk < 0)
+		return;
+
+	memset(&rt, 0, sizeof(rt));
+	rt.rt_flags =3D RTF_UP | RTF_HOST;
+	rt.rt_dev =3D (char *) interface;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D stk->dest_addr.sin_addr.s_addr;
+	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D INADDR_ANY;
+	memcpy(&rt.rt_gateway, &addr, sizeof(rt.rt_gateway));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D INADDR_ANY;
+	memcpy(&rt.rt_genmask, &addr, sizeof(rt.rt_genmask));
+
+	if (ioctl(sk, SIOCADDRT, &rt) < 0)
+		ofono_error("Failed to add host route");
+
+	close(sk);
+}
+
 static gsize stk_channel_data_write(struct ofono_stk *stk, gboolean packag=
e,
 					const unsigned char *data, gsize len)
 {
@@ -767,6 +806,8 @@ static void ofono_stk_activate_context_cb(int error, co=
nst char *interface,
 		stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED;
 	}
 =

+	stk_add_host_route(stk, interface);
+
 	if (stk->protocol =3D=3D STK_TRANSPORT_PROTOCOL_TCP_CLIENT_REMOTE) {
 		sk =3D socket(AF_INET, SOCK_STREAM, 0);
 		if (sk < 0) {
-- =

1.7.1


--===============0356488357906387342==--

