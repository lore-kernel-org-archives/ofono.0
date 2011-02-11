Content-Type: multipart/mixed; boundary="===============2344693871381222019=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [RFC v2] ifxmodem: Integration with n_gsm kernel mux and its line
 discipline
Date: Thu, 10 Feb 2011 17:34:32 -0800
Message-ID: <1297388072-8326-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2344693871381222019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RFC v2: Suggested way of integrating Infineon MAL with upcoming kernel mux =
(n_gsm)

---
 drivers/ifxmodem/gprs-context.c |   70 +++++++++++++++++++++++++++++++++++=
++-
 include/gsmmux.h                |   40 ++++++++++++++++++++++
 plugins/ifx.c                   |   70 +++++++++++++++++++++++++++++++----=
---
 3 files changed, 165 insertions(+), 15 deletions(-)
 create mode 100644 include/gsmmux.h

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 2c68b44..3217492 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -27,8 +27,14 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <linux/types.h>
+#include <arpa/inet.h>
+#include <linux/if_ether.h>
 =

 #include <glib.h>
 =

@@ -40,6 +46,7 @@
 #include "gatresult.h"
 #include "gatrawip.h"
 =

+#include "gsmmux.h"
 #include "ifxmodem.h"
 =

 #define TUN_SYSFS_DIR "/sys/devices/virtual/misc/tun"
@@ -63,6 +70,7 @@ struct gprs_context_data {
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 	GAtRawIP *rawip;
+	gboolean use_ofono_mux;
 	enum state state;
 	char address[32];
 	char dns1[32];
@@ -79,7 +87,43 @@ static void rawip_debug(const char *str, void *data)
 	ofono_info("%s: %s", (const char *) data, str);
 }
 =

-static const char *setup_rawip(struct ofono_gprs_context *gc)
+static const char *setup_rawip_kmux(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct gsm_netconfig netconfig =3D { 0 };
+	int fd;
+	int n;
+	char *interface =3D NULL;
+	char ifname[IFNAMSIZ];
+
+	DBG("");
+	memset(&netconfig, 0, sizeof(struct gsm_netconfig));
+
+	fd =3D g_io_channel_unix_get_fd(g_at_chat_get_channel(gcd->chat));
+	ofono_info("Got file descriptor: %d", fd);
+
+	g_at_chat_suspend(gcd->chat);
+
+	netconfig.adaption =3D 3;
+	netconfig.protocol =3D htons(ETH_P_IP);
+	n =3D ioctl(fd, GSMIOC_ENABLE_NET, &netconfig);
+	if (n < 0) {
+		ofono_error("Cannot enable network on the mux: %d", n);
+		return NULL;
+	}
+	ofono_info("Net index: %d", n);
+
+	interface =3D if_indextoname(n, ifname);
+	if (interface =3D=3D NULL) {
+		ofono_error("Interface index %d error %d error msg %s", n, errno, strerr=
or(errno));
+		return NULL;
+	}
+	ofono_info("Interface name: %s", interface);
+
+	return interface;
+}
+
+static const char *setup_rawip_internal(struct ofono_gprs_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	GAtIO *io;
@@ -153,7 +197,14 @@ static void session_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	dns[1] =3D gcd->dns2;
 	dns[2] =3D 0;
 =

-	interface =3D setup_rawip(gc);
+	if (gcd->use_ofono_mux =3D=3D FALSE) {
+		ofono_info("Calling setup_rawip_kmux()");
+		interface =3D setup_rawip_kmux(gc);
+	}
+	else {
+		ofono_info("Calling setup_rawip_internal()");
+		interface =3D setup_rawip_internal(gc);
+	}
 	if (interface =3D=3D NULL)
 		interface =3D "invalid";
 =

@@ -436,7 +487,9 @@ static int ifx_gprs_context_probe(struct ofono_gprs_con=
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
@@ -455,6 +508,19 @@ static int ifx_gprs_context_probe(struct ofono_gprs_co=
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
+	}
+	else {
+		ofono_info("setting up to use user space mux for data");
+		gcd->use_ofono_mux =3D TRUE;
+	}
+
 	ofono_gprs_context_set_data(gc, gcd);
 =

 	chat =3D g_at_chat_get_slave(gcd->chat);
diff --git a/include/gsmmux.h b/include/gsmmux.h
new file mode 100644
index 0000000..d1880e7
--- /dev/null
+++ b/include/gsmmux.h
@@ -0,0 +1,40 @@
+#ifndef _LINUX_GSMMUX_H
+#define _LINUX_GSMMUX_H
+
+// #include <linux/if.h>
+#if !defined(IFNAMSIZ)
+#define IFNAMSIZ        16
+#endif
+
+struct gsm_config {
+	unsigned int adaption;
+	unsigned int encapsulation;
+	unsigned int initiator;
+	unsigned int t1;
+	unsigned int t2;
+	unsigned int t3;
+	unsigned int n2;
+	unsigned int mru;
+	unsigned int mtu;
+	unsigned int k;
+	unsigned int i;
+	unsigned int unused[8];		/* Padding for expansion without
+					   breaking stuff */
+};
+
+#define GSMIOC_GETCONF		_IOR('G', 0, struct gsm_config)
+#define GSMIOC_SETCONF		_IOW('G', 1, struct gsm_config)
+
+struct gsm_netconfig {
+	unsigned int adaption;  /* Adaption to use in network mode */
+	unsigned short protocol;/* Protocol to use - only ETH_P_IP supported */
+	unsigned short unused2;
+	char if_name[IFNAMSIZ];	/* interface name format string */
+	__u8 unused[28];        /* For future use */
+};
+
+#define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
+#define GSMIOC_DISABLE_NET     _IO('G', 3)
+
+
+#endif
diff --git a/plugins/ifx.c b/plugins/ifx.c
index 527a8c4..4d0be96 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -26,13 +26,16 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
+#include <linux/types.h>
 =

 #include <glib.h>
 #include <gatchat.h>
 #include <gatmux.h>
 #include <gattty.h>
+#include "gsmmux.h"
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -75,9 +78,9 @@
 static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1: ",
 					"GPRS2: ", "GPRS3: ", "Aux: " };
 =

-static const char *dlc_nodes[NUM_DLC] =3D { "/dev/ttyGSM1", "/dev/ttyGSM2",
-					"/dev/ttyGSM3", "/dev/ttyGSM4",
-					"/dev/ttyGSM5", "/dev/ttyGSM6" };
+static const char *dlc_nodes[NUM_DLC] =3D { "/dev/gsmtty1", "/dev/gsmtty2",
+					"/dev/gsmtty3", "/dev/gsmtty4",
+					"/dev/gsmtty5", "/dev/gsmtty6" };
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
@@ -471,6 +474,8 @@ static void mux_setup_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
+	int err;
+	struct gsm_config cfg;
 	int fd;
 =

 	DBG("");
@@ -504,6 +509,34 @@ static void mux_setup_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		goto error;
 	}
 =

+	memset(&cfg, 0, sizeof(struct gsm_config));
+
+	if ((err =3D ioctl(fd, GSMIOC_GETCONF, &cfg)) < 0) {
+		ofono_error("Failed to get configuration on n_gsm multiplexer: %d", err);
+		goto error;
+	}
+
+	ofono_info("Got default configuration...");
+	ofono_info("adaption =3D %d", cfg.adaption);
+	ofono_info("encapsulation =3D %d", cfg.encapsulation);
+	ofono_info("initiator =3D %d", cfg.initiator);
+	ofono_info("t1 =3D %d", cfg.t1);
+	ofono_info("t2 =3D %d", cfg.t2);
+	ofono_info("t3 =3D %d", cfg.t3);
+	ofono_info("n2 =3D %d", cfg.n2);
+	ofono_info("mru =3D %d", cfg.mru);
+	ofono_info("mtu =3D %d", cfg.mtu);
+	ofono_info("k =3D %d", cfg.k);
+
+	cfg.encapsulation =3D 0; /* encoding - set to basic */
+	cfg.initiator =3D 1; /* we are starting side */
+	cfg.mru =3D 1500;
+	cfg.mtu =3D 1500;
+	if ((err =3D ioctl(fd, GSMIOC_SETCONF, &cfg)) < 0) {
+		ofono_error("Failed to configure n_gsm multiplexer: %d", err);
+		goto error;
+	}
+
 	data->dlc_poll_count =3D 0;
 	data->dlc_poll_source =3D g_timeout_add_seconds(1, dlc_ready_check,
 								modem);
@@ -511,6 +544,9 @@ static void mux_setup_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	return;
 =

 error:
+	if (ioctl(fd, TIOCSETD, &data->saved_ldisc) < 0)
+		ofono_warn("Failed to restore line discipline");
+
 	data->saved_ldisc =3D -1;
 =

 	g_io_channel_unref(data->device);
@@ -727,26 +763,34 @@ static void ifx_post_online(struct ofono_modem *modem)
 	if (mw)
 		ofono_message_waiting_register(mw);
 =

+	ofono_warn("Creating GPRS");
 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_IFX,
 					"atmodem", data->dlcs[NETREG_DLC]);
 	if (gprs =3D=3D NULL)
 		return;
 =

-	if (data->mux_ldisc < 0) {
-		gc =3D ofono_gprs_context_create(modem, 0,
+	ofono_warn("Creating GPRS context");
+	gc =3D ofono_gprs_context_create(modem, 0,
 					"ifxmodem", data->dlcs[GPRS1_DLC]);
-		if (gc)
-			ofono_gprs_add_context(gprs, gc);
+	if (gc) {
+		ofono_warn("Adding GPRS context");
+		ofono_gprs_add_context(gprs, gc);
+	}
 =

-		gc =3D ofono_gprs_context_create(modem, 0,
+	ofono_warn("Creaing 2nd GPRS context");
+	gc =3D ofono_gprs_context_create(modem, 0,
 					"ifxmodem", data->dlcs[GPRS2_DLC]);
-		if (gc)
-			ofono_gprs_add_context(gprs, gc);
+	if (gc) {
+		ofono_warn("Adding 2nd GPRS context");
+		ofono_gprs_add_context(gprs, gc);
+	}
 =

-		gc =3D ofono_gprs_context_create(modem, 0,
+	ofono_warn("Creaing 3nd GPRS context");
+	gc =3D ofono_gprs_context_create(modem, 0,
 					"ifxmodem", data->dlcs[GPRS3_DLC]);
-		if (gc)
-			ofono_gprs_add_context(gprs, gc);
+	if (gc) {
+		ofono_warn("Adding 3nd GPRS context");
+		ofono_gprs_add_context(gprs, gc);
 	}
 }
 =

-- =

1.7.1


--===============2344693871381222019==--

