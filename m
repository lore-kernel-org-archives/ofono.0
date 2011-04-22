Content-Type: multipart/mixed; boundary="===============2859029872694076883=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 1/4] gatppp: Add new contructor to use external fd
Date: Fri, 22 Apr 2011 14:06:30 +0200
Message-ID: <1303473993-3606-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1303473993-3606-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2859029872694076883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c  |   43 ++++++++++++++++++++++++++++++++++++++++---
 gatchat/gatppp.h  |    2 ++
 gatchat/ppp.h     |    2 +-
 gatchat/ppp_net.c |   46 ++++++++++++++++++++++++++++------------------
 4 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 993b5ea..d59f69b 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -76,6 +76,7 @@ struct _GAtPPP {
 	gpointer debug_data;
 	gboolean sta_pending;
 	guint ppp_dead_source;
+	int fd;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -288,7 +289,7 @@ void ppp_auth_notify(GAtPPP *ppp, gboolean success)
 void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local, const char *peer,
 					const char *dns1, const char *dns2)
 {
-	ppp->net =3D ppp_net_new(ppp);
+	ppp->net =3D ppp_net_new(ppp, ppp->fd);
 =

 	if (ppp->net =3D=3D NULL) {
 		ppp->disconnect_reason =3D G_AT_PPP_REASON_NET_FAIL;
@@ -296,8 +297,14 @@ void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local=
, const char *peer,
 		return;
 	}
 =

-	if (ppp_net_set_mtu(ppp->net, ppp->mtu) =3D=3D FALSE)
-		DBG(ppp, "Unable to set MTU");
+	/*
+	 * If we have opened the tun interface locally,
+	 * we have to set a MTU value.
+	 */
+	if (ppp->fd < 0) {
+		if (ppp_net_set_mtu(ppp->net, ppp->mtu) =3D=3D FALSE)
+			DBG(ppp, "Unable to set MTU");
+	}
 =

 	ppp_enter_phase(ppp, PPP_PHASE_LINK_UP);
 =

@@ -541,6 +548,9 @@ static GAtPPP *ppp_init_common(GAtHDLC *hdlc, gboolean =
is_server, guint32 ip)
 =

 	ppp->ref_count =3D 1;
 =

+	/* Default value of fd is -1 */
+	ppp->fd =3D -1;
+
 	/* set options to defaults */
 	ppp->mru =3D DEFAULT_MRU;
 	ppp->mtu =3D DEFAULT_MTU;
@@ -629,6 +639,33 @@ GAtPPP *g_at_ppp_server_new_from_io(GAtIO *io, const c=
har *local)
 		return NULL;
 =

 	ppp =3D ppp_init_common(hdlc, TRUE, ip);
+
+	g_at_hdlc_unref(hdlc);
+
+	return ppp;
+}
+
+GAtPPP *g_at_ppp_server_new_from_io_with_fd(GAtIO *io,
+						const char *local, int fd)
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
 	g_at_hdlc_unref(hdlc);
 =

 	return ppp;
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index fb5de4c..4ed4cde 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -54,6 +54,8 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem);
 GAtPPP *g_at_ppp_new_from_io(GAtIO *io);
 GAtPPP *g_at_ppp_server_new(GIOChannel *modem, const char *local);
 GAtPPP *g_at_ppp_server_new_from_io(GAtIO *io, const char *local);
+GAtPPP *g_at_ppp_server_new_from_io_with_fd(GAtIO *io,
+						const char *local, int fd);
 =

 void g_at_ppp_open(GAtPPP *ppp);
 void g_at_ppp_set_connect_function(GAtPPP *ppp, GAtPPPConnectFunc callback,
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index d2786d7..8107820 100644
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
index 1a6cdf7..59c4b5e 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -123,12 +123,12 @@ const char *ppp_net_get_interface(struct ppp_net *net)
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
+	int fdesc, err;
 =

 	net =3D g_try_new0(struct ppp_net, 1);
 	if (net =3D=3D NULL)
@@ -140,23 +140,33 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp)
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
-
-	net->if_name =3D strdup(ifr.ifr_name);
+	/*
+	 * If the fd value is still the default one,
+	 * open the tun interface and configure it.
+	 */
+	if (fd< 0) {
+		/* open a tun interface */
+		fdesc =3D open("/dev/net/tun", O_RDWR);
+		if (fdesc < 0)
+			goto error;
+
+		memset(&ifr, 0, sizeof(ifr));
+		ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
+		strcpy(ifr.ifr_name, "ppp%d");
+
+		err =3D ioctl(fdesc, TUNSETIFF, (void *) &ifr);
+		if (err < 0)
+			goto error;
+
+		net->if_name =3D strdup(ifr.ifr_name);
+		/* create a channel for reading and writing to this interface */
+		channel =3D g_io_channel_unix_new(fdesc);
+	} else {
+		net->if_name =3D strdup("Server ppp");
+		/* create a channel for reading and writing to this interface */
+		channel =3D g_io_channel_unix_new(fd);
+	}
 =

-	/* create a channel for reading and writing to this interface */
-	channel =3D g_io_channel_unix_new(fd);
 	if (channel =3D=3D NULL)
 		goto error;
 =

-- =

1.7.1


--===============2859029872694076883==--

