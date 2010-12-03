Content-Type: multipart/mixed; boundary="===============7273348980202977633=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/2] plugins: use %m instead of strerror()
Date: Fri, 03 Dec 2010 21:35:47 +0200
Message-ID: <1291404948-13335-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7273348980202977633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c        |    4 ++--
 plugins/isigen.c     |   13 ++++++++-----
 plugins/n900.c       |   14 +++++++-------
 plugins/nokia-gpio.c |   29 +++++++++++++++++------------
 4 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index d8d30b0..1a475b0 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -324,8 +324,8 @@ static int service_level_connection(struct ofono_modem =
*modem, int fd)
 =

 	io =3D g_io_channel_unix_new(fd);
 	if (io =3D=3D NULL) {
-		ofono_error("Service level connection failed: %s (%d)",
-			strerror(errno), errno);
+		ofono_error("Service level connection failed: %m (%d)",
+			errno);
 		return -EIO;
 	}
 =

diff --git a/plugins/isigen.c b/plugins/isigen.c
index 028f1b2..5b2283c 100644
--- a/plugins/isigen.c
+++ b/plugins/isigen.c
@@ -217,7 +217,8 @@ static void reachable_cb(GIsiClient *client, gboolean a=
live, uint16_t object,
 	};
 =

 	if (!alive) {
-		DBG("MTC client: %s", strerror(-g_isi_client_error(client)));
+		errno =3D -g_isi_client_error(client);
+		DBG("MTC client: %m");
 =

 		if (isi->linkstate =3D=3D PN_LINK_UP)
 			g_isi_send(client, msg, sizeof(msg),
@@ -272,25 +273,27 @@ static int isigen_probe(struct ofono_modem *modem)
 =

 	idx =3D g_isi_modem_by_name(ifname);
 	if (idx =3D=3D NULL) {
-		DBG("Interface=3D%s: %s", ifname, strerror(errno));
+		DBG("Interface=3D%s: %m", ifname);
 		return -errno;
 	}
 =

 	if (g_pn_netlink_by_modem(idx)) {
-		DBG("%s: %s", ifname, strerror(EBUSY));
+		errno =3D EBUSY;
+		DBG("%s: %m", ifname);
 		return -EBUSY;
 	}
 =

 	link =3D g_pn_netlink_start(idx, phonet_status_cb, modem);
 	if (link =3D=3D NULL) {
-		DBG("%s: %s", ifname, strerror(errno));
+		DBG("%s: %m", ifname);
 		return -errno;
 	}
 =

 	if (address) {
 		int error =3D g_pn_netlink_set_address(idx, address);
 		if (error && error !=3D -EEXIST) {
-			DBG("g_pn_netlink_set_address: %s", strerror(-error));
+			errno =3D -error;
+			DBG("g_pn_netlink_set_address: %m");
 			g_pn_netlink_stop(link);
 			return -errno;
 		}
diff --git a/plugins/n900.c b/plugins/n900.c
index 7619821..d3105e4 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -218,8 +218,7 @@ static gboolean mtc_startup_synq_cb(GIsiClient *client,
 	const unsigned char *msg =3D data;
 =

 	if (!msg) {
-		DBG("%s: %s", "MTC_STARTUP_SYNQ",
-			strerror(-g_isi_client_error(client)));
+		DBG("%s: %m", "MTC_STARTUP_SYNQ");
 		return TRUE;
 	}
 =

@@ -280,7 +279,8 @@ static void mtc_reachable_cb(GIsiClient *client, gboole=
an alive,
 	struct isi_data *isi =3D opaque;
 =

 	if (!alive) {
-		DBG("MTC client: %s", strerror(-g_isi_client_error(client)));
+		errno =3D -g_isi_client_error(client);
+		DBG("MTC client: %m");
 		/* enable is terminated eventually by timeout */
 		return;
 	}
@@ -332,8 +332,8 @@ static gboolean mtc_power_off_cb(GIsiClient *client,
 	const unsigned char *msg =3D data;
 =

 	if (!msg) {
-		DBG("%s: %s", "MTC_POWER_OFF_RESP",
-			strerror(-g_isi_client_error(client)));
+		errno =3D -g_isi_client_error(client);
+		DBG("%s: %m", "MTC_POWER_OFF_RESP");
 =

 		if (isi->power_state =3D=3D POWER_STATE_OFF_STARTED)
 			mtc_power_off(isi);
@@ -399,12 +399,12 @@ static int n900_probe(struct ofono_modem *modem)
 =

 	idx =3D g_isi_modem_by_name(ifname);
 	if (idx =3D=3D NULL) {
-		DBG("Interface=3D%s: %s", ifname, strerror(errno));
+		DBG("Interface=3D%s: %m", ifname);
 		return -errno;
 	}
 =

 	if (gpio_probe(idx, address, n900_power_cb, modem) !=3D 0) {
-		DBG("gpio for %s: %s", ifname, strerror(errno));
+		DBG("gpio for %s: %m", ifname);
 		return -errno;
 	}
 =

diff --git a/plugins/nokia-gpio.c b/plugins/nokia-gpio.c
index db0aa39..451340e 100644
--- a/plugins/nokia-gpio.c
+++ b/plugins/nokia-gpio.c
@@ -156,7 +156,7 @@ static int file_write(char const *filename, char const =
*output)
 =

 	f =3D fopen(filename, "r+");
 	if (f =3D=3D NULL) {
-		DBG("%s: %s (%d)", filename, strerror(errno), errno);
+		DBG("%s: %m (%d)", filename, errno);
 		return -1;
 	}
 =

@@ -647,14 +647,14 @@ static int gpio_probe_links(void)
 	if (!dir_exists(cmtdir)) {
 =

 		if (mkdir(cmtdir, 0755) =3D=3D -1) {
-			DBG("%s: %s", cmtdir, strerror(errno));
+			DBG("%s: %m", cmtdir);
 			return -(errno =3D ENODEV);
 		}
 	}
 =

 	gpio =3D opendir(gpiodir);
 	if (gpio =3D=3D NULL) {
-		DBG("%s: %s", "gpiodir", strerror(errno));
+		DBG("%s: %m", "gpiodir");
 		return -(errno =3D ENODEV);
 	}
 =

@@ -670,14 +670,14 @@ static int gpio_probe_links(void)
 =

 		nf =3D fopen(nn, "rb");
 		if (nf =3D=3D NULL) {
-			DBG("%s: %s", nn, strerror(errno));
+			DBG("%s: %m", nn);
 			continue;
 		}
 =

 		len =3D fread(name, sizeof name, 1, nf);
 =

 		if (ferror(nf)) {
-			DBG("read from %s: %s", nn, strerror(errno));
+			DBG("read from %s: %m", nn);
 			fclose(nf);
 			continue;
 		}
@@ -696,10 +696,10 @@ static int gpio_probe_links(void)
 		snprintf(to, sizeof to, "%s/%s", cmtdir, name);
 =

 		if (symlink(from, to) =3D=3D -1)
-			DBG("%s: %s", to, strerror(errno));
+			DBG("%s: %m", to);
 	}
 =

-	DBG("%s: %s", "/sys/class/gpio", strerror(errno));
+	DBG("%s: %m", "/sys/class/gpio");
 =

 	return -(errno =3D ENODEV);
 }
@@ -715,13 +715,15 @@ int gpio_probe(GIsiModem *idx, unsigned addr, gpio_fi=
nished_cb_t cb, void *data)
 	}
 =

 	if (self.callback) {
-		DBG("gpio: %s", strerror(EBUSY));
-		return -(errno =3D EBUSY);
+		errno =3D EBUSY;
+		DBG("gpio: %m");
+		return -EBUSY;
 	}
 =

 	if (g_pn_netlink_by_modem(idx)) {
-		DBG("Phonet link %p: %s", idx, strerror(EBUSY));
-		return -(errno =3D EBUSY);
+		errno =3D EBUSY;
+		DBG("Phonet link %p: %m", idx);
+		return -EBUSY;
 	}
 =

 	self.target =3D PHONET_LINK_NONE;
@@ -765,7 +767,10 @@ int gpio_probe(GIsiModem *idx, unsigned addr, gpio_fin=
ished_cb_t cb, void *data)
 	if (addr) {
 		error =3D g_pn_netlink_set_address(idx, addr);
 		if (error && error !=3D -EEXIST)
-			DBG("g_pn_netlink_set_address: %s", strerror(-error));
+		{
+			errno =3D -error;
+			DBG("g_pn_netlink_set_address: %m");
+		}
 	}
 =

 	return 0;
-- =

1.7.1


--===============7273348980202977633==--

