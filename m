Content-Type: multipart/mixed; boundary="===============2279366017401035659=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 2/6] huawei: Open qcdm port to fetch network status & SID
Date: Wed, 18 Jan 2012 18:05:13 +0100
Message-ID: <1326906317-11601-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1326906317-11601-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2279366017401035659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 5d8875a..58f8832 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -78,6 +78,7 @@ enum {
 struct huawei_data {
 	GAtChat *modem;
 	GAtChat *pcui;
+	GAtHDLC *diag;
 	gboolean have_sim;
 	int sim_state;
 	guint sysinfo_poll_source;
@@ -120,6 +121,7 @@ static void huawei_remove(struct ofono_modem *modem)
 =

 	/* Cleanup after hot-unplug */
 	g_at_chat_unref(data->pcui);
+	g_at_hdlc_unref(data->diag);
 =

 	g_free(data);
 }
@@ -357,6 +359,9 @@ static void shutdown_device(struct huawei_data *data)
 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
 =

+	g_at_hdlc_unref(data->diag);
+	data->diag =3D NULL;
+
 	g_at_chat_cancel_all(data->pcui);
 	g_at_chat_unregister_all(data->pcui);
 =

@@ -577,6 +582,38 @@ static GAtChat *open_device(struct ofono_modem *modem,
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
+		g_at_hdlc_set_debug(hdlc, huawei_debug, "DIAG: ");
+
+	g_at_hdlc_set_xmit_accm(hdlc, 0);
+	g_at_hdlc_set_recv_accm(hdlc, 0);
+
+	return hdlc;
+}
+
 static int huawei_enable(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
@@ -594,6 +631,10 @@ static int huawei_enable(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

+	data->diag =3D open_qcdm(modem);
+	if (data->diag !=3D NULL)
+		g_at_chat_set_slave_qcdm(data->pcui, data->diag);
+
 	g_at_chat_set_slave(data->modem, data->pcui);
 =

 	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
@@ -634,6 +675,9 @@ static int huawei_disable(struct ofono_modem *modem)
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


--===============2279366017401035659==--

