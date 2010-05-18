Content-Type: multipart/mixed; boundary="===============3192799676470623935=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 2/2] Add isimodem network time support
Date: Tue, 18 May 2010 18:21:22 +0300
Message-ID: <1274196082-2889-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1274196082-2889-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3192799676470623935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/debug.c                |    2 +
 drivers/isimodem/network-registration.c |   39 +++++++++++++++++++++++++++=
++++
 drivers/isimodem/network.h              |    3 ++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 3ba9d52..86530fd 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -744,6 +744,7 @@ const char *net_message_id_name(enum net_message_id val=
ue)
 		_(NET_RSSI_GET_REQ);
 		_(NET_RSSI_GET_RESP);
 		_(NET_RSSI_IND);
+		_(NET_TIME_IND);
 		_(NET_RAT_IND);
 		_(NET_RAT_REQ);
 		_(NET_RAT_RESP);
@@ -768,6 +769,7 @@ const char *net_subblock_name(enum net_subblock value)
 		_(NET_GSM_REG_INFO);
 		_(NET_DETAILED_NETWORK_INFO);
 		_(NET_GSM_OPERATOR_INFO);
+		_(NET_TIME_INFO);
 		_(NET_GSM_BAND_INFO);
 		_(NET_RAT_INFO);
 		_(NET_AVAIL_NETWORK_INFO_COMMON);
diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index eddf6fd..75dd6bc 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -746,6 +746,44 @@ static void rssi_ind_cb(GIsiClient *client, const void=
 *restrict data,
 	ofono_netreg_strength_notify(netreg, msg[1]);
 }
 =

+static void time_ind_cb(GIsiClient *client, const void *restrict data,
+			size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	const unsigned char *nitz =3D msg + 3;
+	struct ofono_netreg *netreg =3D opaque;
+
+	struct ofono_network_time info;
+
+	if (!msg || len < 13 || msg[0] !=3D NET_TIME_IND
+		|| nitz[0] !=3D NET_TIME_INFO)
+		return;
+
+	nitz +=3D 2;
+
+	/* Value is years since last turn of century */
+	info.year =3D nitz[0] !=3D NET_INVALID_TIME ? nitz[0] : -1;
+	info.year +=3D 2000;
+
+	info.mon =3D nitz[1] !=3D NET_INVALID_TIME ? nitz[1] : -1;
+	info.mday =3D nitz[2] !=3D NET_INVALID_TIME ? nitz[2] : -1;
+	info.hour =3D nitz[3] !=3D NET_INVALID_TIME ? nitz[3] : -1;
+	info.min =3D nitz[4] !=3D NET_INVALID_TIME ? nitz[4] : -1;
+	info.sec =3D nitz[5] !=3D NET_INVALID_TIME ? nitz[5] : -1;
+
+	/* Most significant bit set indicates negative offset. The
+	 * second most significant bit is 'reserved'. The value is the
+	 * offset from UTCin a count of 15min intervals, possibly
+	 * including the current DST adjustment. */
+	info.utcoff =3D (nitz[6] & 0x3F) * 15 * 60;
+	if (nitz[6] & 0x80)
+		info.utcoff *=3D -1;
+
+	info.dst =3D nitz[7] !=3D NET_INVALID_TIME ? nitz[7] : -1;
+
+	ofono_netreg_time_notify(netreg, &info);
+}
+
 static bool rssi_resp_cb(GIsiClient *client, const void *restrict data,
 				size_t len, uint16_t object, void *opaque)
 {
@@ -851,6 +889,7 @@ static gboolean isi_netreg_register(gpointer user)
 	g_isi_subscribe(nd->client, NET_REG_STATUS_IND, reg_status_ind_cb,
 			netreg);
 	g_isi_subscribe(nd->client, NET_RAT_IND, rat_ind_cb, netreg);
+	g_isi_subscribe(nd->client, NET_TIME_IND, time_ind_cb, netreg);
 =

 	/* Bootstrap current RAT setting */
 	if (!g_isi_request_make(nd->client, rat, sizeof(rat),
diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
index ec52321..77b4ec3 100644
--- a/drivers/isimodem/network.h
+++ b/drivers/isimodem/network.h
@@ -30,6 +30,7 @@ extern "C" {
 #define NETWORK_TIMEOUT		5
 #define NETWORK_SCAN_TIMEOUT	180
 #define NETWORK_SET_TIMEOUT	240
+#define NET_INVALID_TIME	0x64
 =

 enum net_message_id {
 	NET_SET_REQ =3D 0x07,
@@ -37,6 +38,7 @@ enum net_message_id {
 	NET_RSSI_GET_REQ =3D 0x0B,
 	NET_RSSI_GET_RESP =3D 0x0C,
 	NET_RSSI_IND =3D 0x1E,
+	NET_TIME_IND =3D 0x27,
 	NET_RAT_IND =3D 0x35,
 	NET_RAT_REQ =3D 0x36,
 	NET_RAT_RESP =3D 0x37,
@@ -57,6 +59,7 @@ enum net_subblock {
 	NET_GSM_REG_INFO =3D 0x09,
 	NET_DETAILED_NETWORK_INFO =3D 0x0B,
 	NET_GSM_OPERATOR_INFO =3D 0x0C,
+	NET_TIME_INFO =3D 0x10,
 	NET_GSM_BAND_INFO =3D 0x11,
 	NET_RAT_INFO =3D 0x2C,
 	NET_AVAIL_NETWORK_INFO_COMMON =3D 0xE1,
-- =

1.7.0.4


--===============3192799676470623935==--

