Content-Type: multipart/mixed; boundary="===============3557266025059159764=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH 2/3] ifxmodem: integration of kernel mux (n_gsm)
Date: Wed, 09 Mar 2011 16:46:22 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5DBA@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3557266025059159764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

---
 drivers/ifxmodem/gprs-context.c |   95 +++++++++++++++++++++++++++++++++++=
++--
 1 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 2c68b44..0d133f9 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -29,6 +29,11 @@
 #include <stdio.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <arpa/inet.h>
+#include <linux/if_ether.h>
+#include <linux/gsmmux.h>
 =

 #include <glib.h>
 =

@@ -63,6 +68,7 @@ struct gprs_context_data {
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 	GAtRawIP *rawip;
+	gboolean use_ofono_mux;
 	enum state state;
 	char address[32];
 	char dns1[32];
@@ -79,7 +85,46 @@ static void rawip_debug(const char *str, void *data)
 	ofono_info("%s: %s", (const char *) data, str);
 }
 =

-static const char *setup_rawip(struct ofono_gprs_context *gc)
+static const char *setup_rawip_kmux(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct gsm_netconfig netconfig;
+	int fd;
+	int n;
+	char *interface =3D NULL;
+	char ifname[IFNAMSIZ];
+
+	memset(&netconfig, 0, sizeof(struct gsm_netconfig));
+	gcd->rawip =3D NULL;
+
+	fd =3D g_io_channel_unix_get_fd(g_at_chat_get_channel(gcd->chat));
+
+	g_at_chat_suspend(gcd->chat);
+
+	netconfig.adaption =3D 3;
+	netconfig.protocol =3D htons(ETH_P_IP);
+
+	n =3D ioctl(fd, GSMIOC_ENABLE_NET, &netconfig);
+	if (n < 0) {
+		ofono_error("Cannot enable network on the mux: %d", n);
+		return NULL;
+	}
+
+	ofono_info("Net index: %d", n);
+
+	interface =3D if_indextoname(n, ifname);
+	if (interface =3D=3D NULL) {
+		ofono_error("Interface index %d error %d error msg %s", n,
+						errno, strerror(errno));
+		return NULL;
+	}
+
+	ofono_info("Interface name: %s", interface);
+
+	return interface;
+}
+
+static const char *setup_rawip_internal(struct ofono_gprs_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	GAtIO *io;
@@ -153,7 +198,14 @@ static void session_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	dns[1] =3D gcd->dns2;
 	dns[2] =3D 0;
 =

-	interface =3D setup_rawip(gc);
+	if (gcd->use_ofono_mux =3D=3D FALSE) {
+		ofono_info("Calling setup_rawip_kmux()");
+		interface =3D setup_rawip_kmux(gc);
+	} else {
+		ofono_info("Calling setup_rawip_internal()");
+		interface =3D setup_rawip_internal(gc);
+	}
+
 	if (interface =3D=3D NULL)
 		interface =3D "invalid";
 =

@@ -352,7 +404,9 @@ static void deactivate_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	DBG("ok %d", ok);
 =

-	g_at_rawip_unref(gcd->rawip);
+	if (gcd->rawip)
+		g_at_rawip_unref(gcd->rawip);
+
 	gcd->rawip =3D NULL;
 =

 	gcd->active_context =3D 0;
@@ -370,6 +424,8 @@ static void ifx_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	GAtChat *chat =3D g_at_chat_get_slave(gcd->chat);
 	char buf[64];
+	int fd;
+	int n;
 =

 	DBG("cid %u", cid);
 =

@@ -377,7 +433,14 @@ static void ifx_gprs_deactivate_primary(struct ofono_g=
prs_context *gc,
 	gcd->down_cb =3D cb;
 	gcd->cb_data =3D data;
 =

-	g_at_rawip_shutdown(gcd->rawip);
+	if (gcd->rawip)
+		g_at_rawip_shutdown(gcd->rawip);
+
+	fd =3D g_io_channel_unix_get_fd(g_at_chat_get_channel(gcd->chat));
+
+	n =3D ioctl(fd, GSMIOC_DISABLE_NET, NULL);
+	if (n < 0)
+		ofono_error("Cannot disable network on the mux: %d", n);
 =

 	sprintf(buf, "AT+CGACT=3D0,%u", gcd->active_context);
 	if (g_at_chat_send(chat, buf, none_prefix,
@@ -394,6 +457,8 @@ static void cgev_notify(GAtResult *result, gpointer use=
r_data)
 	const char *event;
 	int cid;
 	GAtResultIter iter;
+	int fd;
+	int n;
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -424,6 +489,14 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 		gcd->rawip =3D NULL;
 	}
 =

+	if (gcd->use_ofono_mux =3D=3D FALSE) {
+		fd =3D g_io_channel_unix_get_fd(g_at_chat_get_channel(gcd->chat));
+
+		n =3D ioctl(fd, GSMIOC_DISABLE_NET, NULL);
+		if (n < 0)
+			ofono_error("Cannot disable network on the mux: %d", n);
+	}
+
 	ofono_gprs_context_deactivated(gc, gcd->active_context);
 =

 	gcd->active_context =3D 0;
@@ -436,7 +509,9 @@ static int ifx_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 					unsigned int vendor, void *data)
 {
 	GAtChat *chat =3D data;
+	const char *ldisc;
 	struct gprs_context_data *gcd;
+	struct ofono_modem *modem;
 	struct stat st;
 =

 	DBG("");
@@ -455,6 +530,18 @@ static int ifx_gprs_context_probe(struct ofono_gprs_co=
ntext *gc,
 =

 	gcd->chat =3D g_at_chat_clone(chat);
 =

+	modem =3D ofono_gprs_context_get_modem(gc);
+	ldisc =3D ofono_modem_get_string(modem, "LineDiscipline");
+
+	ofono_info("Got LineDiscipline variable from udev: %s", ldisc);
+	if (ldisc !=3D NULL) {
+		ofono_info("setting up to use kernel mux for data");
+		gcd->use_ofono_mux =3D FALSE;
+	} else {
+		ofono_info("setting up to use user space mux for data");
+		gcd->use_ofono_mux =3D TRUE;
+	}
+
 	ofono_gprs_context_set_data(gc, gcd);
 =

 	chat =3D g_at_chat_get_slave(gcd->chat);
-- =

1.6.3.3

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============3557266025059159764==--

