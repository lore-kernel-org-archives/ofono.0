Content-Type: multipart/mixed; boundary="===============3358109921985389594=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 2/2] qmi: netmon: fix crashs on get_rssi_cb when BER or RSSI
 are empty
Date: Sun, 28 Apr 2019 13:28:15 +0200
Message-ID: <20190428112815.1407-2-lynxis@fe80.eu>
In-Reply-To: <20190428112815.1407-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3358109921985389594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The message can be emitted without the fields being present. In this case b=
er or rssi are 0
resulting in a null pointer deref.
---
 drivers/qmimodem/netmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index 14a55632e8a6..729879ce73d8 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -89,8 +89,8 @@ static void get_rssi_cb(struct qmi_result *result, void *=
user_data)
 =

 	/* RSSI */
 	rssi =3D qmi_result_get(result, 0x11, &len);
-	num =3D GUINT16_FROM_LE(rssi->count);
 	if (rssi) {
+		num =3D GUINT16_FROM_LE(rssi->count);
 		for (i =3D 0; i < num; i++) {
 			DBG("RSSI: %hhu on RAT %hhd",
 				rssi->info[i].rssi,
@@ -126,8 +126,8 @@ static void get_rssi_cb(struct qmi_result *result, void=
 *user_data)
 =

 	/* Bit error rate */
 	ber =3D qmi_result_get(result, 0x15, &len);
-	num =3D GUINT16_FROM_LE(ber->count);
 	if (ber) {
+		num =3D GUINT16_FROM_LE(ber->count);
 		for (i =3D 0; i < ber->count; i++) {
 			DBG("Bit error rate: %hu on RAT %hhd",
 				GUINT16_FROM_LE(ber->info[i].rate),
-- =

2.21.0


--===============3358109921985389594==--

