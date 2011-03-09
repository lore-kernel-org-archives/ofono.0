Content-Type: multipart/mixed; boundary="===============7022268678642935962=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH 1/3] ifx: integration of kernel mux (n_gsm) and its line
 discipline
Date: Wed, 09 Mar 2011 16:46:07 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5DB9@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7022268678642935962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

---
 plugins/ifx.c |   83 ++++++++++++++++++++++++++++++++++++++++++++---------=
---
 1 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 527a8c4..9c2a5c1 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -26,8 +26,12 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
+#include <linux/types.h>
+#include <linux/gsmmux.h>
+#include <unistd.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -75,9 +79,9 @@
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
@@ -392,6 +396,7 @@ static gboolean dlc_ready_check(gpointer user_data)
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
 	struct stat st;
 	int i;
+	GHashTable *options;
 =

 	DBG("");
 =

@@ -405,8 +410,14 @@ static gboolean dlc_ready_check(gpointer user_data)
 		return TRUE;
 	}
 =

+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (options =3D=3D NULL)
+		goto error;
+
+	g_hash_table_insert(options, "Local", "on");
+
 	for (i =3D 0; i < NUM_DLC; i++) {
-		GIOChannel *channel =3D g_at_tty_open(dlc_nodes[i], NULL);
+		GIOChannel *channel =3D g_at_tty_open(dlc_nodes[i], options);
 =

 		data->dlcs[i] =3D create_chat(channel, modem, dlc_prefixes[i]);
 		if (data->dlcs[i] =3D=3D NULL) {
@@ -415,6 +426,8 @@ static gboolean dlc_ready_check(gpointer user_data)
 		}
 	}
 =

+	g_hash_table_destroy(options);
+
 	data->dlc_poll_source =3D 0;
 =

 	/* iterate through mainloop */
@@ -455,7 +468,7 @@ static void setup_internal_mux(struct ofono_modem *mode=
m)
 			ofono_error("Failed to create channel");
 			goto error;
 		}
-        }
+	}
 =

 	/* wait for DLC creation to settle */
 	data->dlc_init_source =3D g_timeout_add(10, dlc_setup, modem);
@@ -471,7 +484,9 @@ static void mux_setup_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
-	int fd;
+	int err;
+	struct gsm_config cfg;
+	int fd =3D -1;
 =

 	DBG("");
 =

@@ -504,6 +519,37 @@ static void mux_setup_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		goto error;
 	}
 =

+	memset(&cfg, 0, sizeof(struct gsm_config));
+
+	err =3D ioctl(fd, GSMIOC_GETCONF, &cfg);
+	if (err < 0) {
+		ofono_error("Failed to get multiplexer configuration: %d", err);
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
+
+	err =3D ioctl(fd, GSMIOC_SETCONF, &cfg);
+	if (err < 0) {
+		ofono_error("Failed to configure n_gsm multiplexer: %d", err);
+		goto error;
+	}
+
 	data->dlc_poll_count =3D 0;
 	data->dlc_poll_source =3D g_timeout_add_seconds(1, dlc_ready_check,
 								modem);
@@ -511,6 +557,9 @@ static void mux_setup_cb(gboolean ok, GAtResult *result=
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
@@ -593,9 +642,9 @@ static int ifx_enable(struct ofono_modem *modem)
 					NULL, NULL, NULL);
 =

 	/* Enable multiplexer */
-	data->frame_size =3D 1509;
+	data->frame_size =3D 1500;
 =

-	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
+	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1500,10,3,30,,", NULL,
 					mux_setup_cb, modem, NULL);
 =

 	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
@@ -732,22 +781,20 @@ static void ifx_post_online(struct ofono_modem *modem)
 	if (gprs =3D=3D NULL)
 		return;
 =

-	if (data->mux_ldisc < 0) {
-		gc =3D ofono_gprs_context_create(modem, 0,
+	gc =3D ofono_gprs_context_create(modem, 0,
 					"ifxmodem", data->dlcs[GPRS1_DLC]);
-		if (gc)
-			ofono_gprs_add_context(gprs, gc);
+	if (gc)
+		ofono_gprs_add_context(gprs, gc);
 =

-		gc =3D ofono_gprs_context_create(modem, 0,
+	gc =3D ofono_gprs_context_create(modem, 0,
 					"ifxmodem", data->dlcs[GPRS2_DLC]);
-		if (gc)
+	if (gc)
 			ofono_gprs_add_context(gprs, gc);
 =

-		gc =3D ofono_gprs_context_create(modem, 0,
+	gc =3D ofono_gprs_context_create(modem, 0,
 					"ifxmodem", data->dlcs[GPRS3_DLC]);
-		if (gc)
-			ofono_gprs_add_context(gprs, gc);
-	}
+	if (gc)
+		ofono_gprs_add_context(gprs, gc);
 }
 =

 static struct ofono_modem_driver ifx_driver =3D {
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


--===============7022268678642935962==--

