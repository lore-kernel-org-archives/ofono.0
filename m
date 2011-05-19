Content-Type: multipart/mixed; boundary="===============5030057076357817553=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 1/5] gatppp: Add new contructor to use external fd
Date: Thu, 19 May 2011 11:58:28 +0200
Message-ID: <1305799112-14289-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305799112-14289-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5030057076357817553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c  |   33 ++++++++++++++++++++++++++++++++-
 gatchat/gatppp.h  |    1 +
 gatchat/ppp.h     |    2 +-
 gatchat/ppp_net.c |   47 ++++++++++++++++++++++++++++++++---------------
 4 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index c776811..1f2d227 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -78,6 +78,7 @@ struct _GAtPPP {
 	guint ppp_dead_source;
 	GAtSuspendFunc suspend_func;
 	gpointer suspend_data;
+	int fd;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -290,7 +291,7 @@ void ppp_auth_notify(GAtPPP *ppp, gboolean success)
 void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local, const char *peer,
 					const char *dns1, const char *dns2)
 {
-	ppp->net =3D ppp_net_new(ppp);
+	ppp->net =3D ppp_net_new(ppp, ppp->fd);
 =

 	if (ppp->net =3D=3D NULL) {
 		ppp->disconnect_reason =3D G_AT_PPP_REASON_NET_FAIL;
@@ -316,6 +317,7 @@ void ppp_ipcp_down_notify(GAtPPP *ppp)
 		return;
 =

 	ppp_net_free(ppp->net);
+	ppp->fd =3D -1;
 	ppp->net =3D NULL;
 }
 =

@@ -522,6 +524,8 @@ void g_at_ppp_unref(GAtPPP *ppp)
 =

 	if (ppp->net)
 		ppp_net_free(ppp->net);
+	else if (ppp->fd >=3D 0)
+		close(ppp->fd);
 =

 	if (ppp->chap)
 		ppp_chap_free(ppp->chap);
@@ -565,6 +569,8 @@ static GAtPPP *ppp_init_common(GAtHDLC *hdlc, gboolean =
is_server, guint32 ip)
 =

 	ppp->ref_count =3D 1;
 =

+	ppp->fd =3D -1;
+
 	/* set options to defaults */
 	ppp->mru =3D DEFAULT_MRU;
 	ppp->mtu =3D DEFAULT_MTU;
@@ -657,3 +663,28 @@ GAtPPP *g_at_ppp_server_new_from_io(GAtIO *io, const c=
har *local)
 =

 	return ppp;
 }
+
+GAtPPP *g_at_ppp_server_new_full(GAtIO *io, const char *local, int fd)
+{
+	GAtHDLC *hdlc;
+	GAtPPP *ppp;
+	guint32 ip;
+
+	if (local =3D=3D NULL)
+		ip =3D 0;
+	else if (inet_pton(AF_INET, local, &ip) !=3D 1)
+		return NULL;
+
+	hdlc =3D g_at_hdlc_new_from_io(io);
+	if (hdlc =3D=3D NULL)
+		return NULL;
+
+	ppp =3D ppp_init_common(hdlc, TRUE, ip);
+
+	/* Set the fd value returned by ConnMan */
+	ppp->fd =3D fd;
+
+	g_at_hdlc_unref(hdlc);
+
+	return ppp;
+}
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 9464ffd..365123a 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -54,6 +54,7 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem);
 GAtPPP *g_at_ppp_new_from_io(GAtIO *io);
 GAtPPP *g_at_ppp_server_new(GIOChannel *modem, const char *local);
 GAtPPP *g_at_ppp_server_new_from_io(GAtIO *io, const char *local);
+GAtPPP *g_at_ppp_server_new_full(GAtIO *io, const char *local, int fd);
 =

 void g_at_ppp_open(GAtPPP *ppp);
 void g_at_ppp_set_connect_function(GAtPPP *ppp, GAtPPPConnectFunc callback,
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 22809d8..f866944 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -102,7 +102,7 @@ void ppp_chap_free(struct ppp_chap *chap);
 void ppp_chap_process_packet(struct ppp_chap *chap, const guint8 *new_pack=
et);
 =

 /* TUN / Network related functions */
-struct ppp_net *ppp_net_new(GAtPPP *ppp);
+struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd);
 const char *ppp_net_get_interface(struct ppp_net *net);
 void ppp_net_process_packet(struct ppp_net *net, const guint8 *packet);
 void ppp_net_free(struct ppp_net *net);
diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 25bcfa4..52b3554 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -123,35 +123,52 @@ const char *ppp_net_get_interface(struct ppp_net *net)
 	return net->if_name;
 }
 =

-struct ppp_net *ppp_net_new(GAtPPP *ppp)
+struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd)
 {
 	struct ppp_net *net;
 	GIOChannel *channel =3D NULL;
 	struct ifreq ifr;
-	int fd, err;
+	int err;
 =

 	net =3D g_try_new0(struct ppp_net, 1);
-	if (net =3D=3D NULL)
+	if (net =3D=3D NULL) {
+		if (fd >=3D 0)
+			close(fd);
+
 		return NULL;
+	}
 =

 	net->ppp_packet =3D ppp_packet_new(MAX_PACKET, PPP_IP_PROTO);
 	if (net->ppp_packet =3D=3D NULL) {
+		if (fd >=3D 0)
+			close(fd);
+
 		g_free(net);
 		return NULL;
 	}
 =

-	/* open a tun interface */
-	fd =3D open("/dev/net/tun", O_RDWR);
-	if (fd < 0)
-		goto error;
-
-	memset(&ifr, 0, sizeof(ifr));
-	ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
-	strcpy(ifr.ifr_name, "ppp%d");
-
-	err =3D ioctl(fd, TUNSETIFF, (void *) &ifr);
-	if (err < 0)
-		goto error;
+	/*
+	 * If the fd value is still the default one,
+	 * open the tun interface and configure it.
+	 */
+	if (fd < 0) {
+		/* open a tun interface */
+		fd =3D open("/dev/net/tun", O_RDWR);
+		if (fd < 0)
+			goto error;
+
+		memset(&ifr, 0, sizeof(ifr));
+		ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
+		strcpy(ifr.ifr_name, "ppp%d");
+
+		err =3D ioctl(fd, TUNSETIFF, (void *) &ifr);
+		if (err < 0)
+			goto error;
+	} else {
+		err =3D ioctl(fd, TUNGETIFF, (void *) &ifr);
+		if (err < 0)
+			goto error;
+	}
 =

 	net->if_name =3D strdup(ifr.ifr_name);
 =

-- =

1.7.1


--===============5030057076357817553==--

