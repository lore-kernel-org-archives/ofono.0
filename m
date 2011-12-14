Content-Type: multipart/mixed; boundary="===============7240217506796988664=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 07/10] huaweicdma: Open qcdm port to be used for network
 status and cell location
Date: Wed, 14 Dec 2011 18:56:09 +0100
Message-ID: <1323885372-3574-8-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323885372-3574-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7240217506796988664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huaweicdma.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 6fba0c1..f32e27f 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
@@ -43,6 +43,7 @@
 struct huaweicdma_data {
 	GAtChat *modem;
 	GAtChat *pcui;
+	GAtHDLC *diag;
 };
 =

 static void huaweicdma_debug(const char *str, void *data)
@@ -77,6 +78,7 @@ static void huaweicdma_remove(struct ofono_modem *modem)
 =

 	/* Cleanup after hot-unplug */
 	g_at_chat_unref(data->pcui);
+	g_at_hdlc_unref(data->diag);
 =

 	g_free(data);
 }
@@ -94,6 +96,9 @@ static void cfun_enable(gboolean ok, GAtResult *result, g=
pointer user_data)
 =

 		g_at_chat_unref(data->pcui);
 		data->pcui =3D NULL;
+
+		g_at_hdlc_unref(data->diag);
+		data->diag =3D NULL;
 	}
 =

 	ofono_modem_set_powered(modem, ok);
@@ -132,6 +137,38 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static GAtHDLC *open_qcdm(struct ofono_modem *modem)
+{
+	const char *device;
+	GIOChannel *channel;
+	GAtHDLC *hdlc;
+
+	device =3D ofono_modem_get_string(modem, "Diag");
+	if (device =3D=3D NULL)
+		return NULL;
+
+	DBG("Diagnostic Monitor %s", device);
+
+	channel =3D g_at_tty_open_qcdm(device);
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	hdlc =3D g_at_hdlc_new(channel);
+
+	g_io_channel_unref(channel);
+
+	if (hdlc =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_hdlc_set_debug(hdlc, huaweicdma_debug, "DIAG: ");
+
+	g_at_hdlc_set_xmit_accm(hdlc, 0);
+	g_at_hdlc_set_recv_accm(hdlc, 0);
+
+	return hdlc;
+}
+
 static int huaweicdma_enable(struct ofono_modem *modem)
 {
 	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
@@ -149,6 +186,10 @@ static int huaweicdma_enable(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

+	data->diag =3D open_qcdm(modem);
+	if (data->diag !=3D NULL)
+		g_at_chat_set_slave_qcdm(data->pcui, data->diag);
+
 	g_at_chat_set_slave(data->modem, data->pcui);
 =

 	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
@@ -186,6 +227,9 @@ static int huaweicdma_disable(struct ofono_modem *modem)
 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
 =

+	g_at_hdlc_unref(data->diag);
+	data->diag =3D NULL;
+
 	g_at_chat_cancel_all(data->pcui);
 	g_at_chat_unregister_all(data->pcui);
 =

-- =

1.7.1


--===============7240217506796988664==--

