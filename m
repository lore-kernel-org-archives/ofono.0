Content-Type: multipart/mixed; boundary="===============4803402375605309506=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Add write/read operations for cyclic files in SIM.
Date: Sun, 21 Jun 2009 03:30:14 +0200
Message-ID: <1245547814-6729-1-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <200906180228.39043.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4803402375605309506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I added the read method for symmetry, it's currently same as for linear
fixed EFs.  It might make sense to make it read always the oldest record or
something, but that will be clear when there's a use case.  Or we can
remove it.
---
 drivers/atmodem/sim.c |   35 +++++++++++++++++++++++++++++++++++
 src/driver.h          |    6 ++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 620aefc..ab05a5b 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -328,6 +328,39 @@ error:
 	}
 }
 =

+static void at_sim_update_cyclic(struct ofono_modem *modem, int fileid,
+					int length, const unsigned char *value,
+					ofono_generic_cb_t cb, void *data)
+{
+	struct at_data *at =3D ofono_modem_userdata(modem);
+	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
+	char *buf =3D g_try_new(char, 36 + length * 2);
+	int len, ret;
+
+	if (!cbd || !buf)
+		goto error;
+
+	len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,", fileid, length);
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhx", *value++);
+	ret =3D g_at_chat_send(at->parser, buf, crsm_prefix,
+				at_crsm_update_cb, cbd, g_free);
+
+	g_free(buf);
+
+	if (ret > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, data);
+	}
+}
+
 static void at_cimi_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -383,8 +416,10 @@ static struct ofono_sim_ops ops =3D {
 	.read_file_info		=3D at_sim_read_info,
 	.read_file_transparent	=3D at_sim_read_binary,
 	.read_file_linear	=3D at_sim_read_record,
+	.read_file_cyclic	=3D at_sim_read_record,
 	.write_file_transparent	=3D at_sim_update_binary,
 	.write_file_linear	=3D at_sim_update_record,
+	.write_file_cyclic	=3D at_sim_update_cyclic,
 	.read_imsi		=3D at_read_imsi,
 };
 =

diff --git a/src/driver.h b/src/driver.h
index 3eade28..f324c1c 100644
--- a/src/driver.h
+++ b/src/driver.h
@@ -378,12 +378,18 @@ struct ofono_sim_ops {
 	void (*read_file_linear)(struct ofono_modem *modem, int fileid,
 			int record, int length,
 			ofono_sim_read_cb_t cb, void *data);
+	void (*read_file_cyclic)(struct ofono_modem *modem, int fileid,
+			int record, int length,
+			ofono_sim_read_cb_t cb, void *data);
 	void (*write_file_transparent)(struct ofono_modem *modem, int fileid,
 			int start, int length, const unsigned char *value,
 			ofono_generic_cb_t cb, void *data);
 	void (*write_file_linear)(struct ofono_modem *modem, int fileid,
 			int record, int length, const unsigned char *value,
 			ofono_generic_cb_t cb, void *data);
+	void (*write_file_cyclic)(struct ofono_modem *modem, int fileid,
+			int length, const unsigned char *value,
+			ofono_generic_cb_t cb, void *data);
 	void (*read_imsi)(struct ofono_modem *modem,
 			ofono_imsi_cb_t cb, void *data);
 };
-- =

1.6.0


--===============4803402375605309506==--

