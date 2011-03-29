Content-Type: multipart/mixed; boundary="===============3648699135023104582=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/1] isimodem: fix operator name reading with old ISI modems
Date: Tue, 29 Mar 2011 10:54:14 +0300
Message-ID: <1301385254-28543-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <[PATCH 0/1] fix operator name reading with old ISI modems>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3648699135023104582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/debug.c                |    2 ++
 drivers/isimodem/network-registration.c |    8 ++++++--
 drivers/isimodem/network.h              |    2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 6fb451f..b48dd95 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -1035,6 +1035,8 @@ const char *net_message_id_name(enum net_message_id v=
alue)
 		_(NET_AVAILABLE_GET_RESP);
 		_(NET_OPER_NAME_READ_REQ);
 		_(NET_OPER_NAME_READ_RESP);
+		_(NET_OLD_OPER_NAME_READ_REQ);
+		_(NET_OLD_OPER_NAME_READ_RESP);
 		_(NET_COMMON_MESSAGE);
 	}
 	return "NET_<UNKNOWN>";
diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index 8bf2423..f8a91ec 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -466,7 +466,8 @@ static void name_get_resp_cb(const GIsiMessage *msg, vo=
id *data)
 =

 	memset(&op, 0, sizeof(struct ofono_network_operator));
 =

-	if (!check_response_status(msg, NET_OPER_NAME_READ_RESP))
+	if (!check_response_status(msg, NET_OPER_NAME_READ_RESP) &&
+		!check_response_status(msg, NET_OLD_OPER_NAME_READ_RESP))
 		goto error;
 =

 	for (g_isi_sb_iter_init(&iter, msg, 6);
@@ -513,7 +514,7 @@ static void isi_current_operator(struct ofono_netreg *n=
etreg,
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(netreg, cb, data);
 =

-	const uint8_t msg[] =3D {
+	uint8_t msg[] =3D {
 		NET_OPER_NAME_READ_REQ,
 		NET_HARDCODED_LATIN_OPER_NAME,
 		OFONO_MAX_OPERATOR_NAME_LENGTH,
@@ -525,6 +526,9 @@ static void isi_current_operator(struct ofono_netreg *n=
etreg,
 	if (cbd =3D=3D NULL || nd =3D=3D NULL)
 		goto error;
 =

+	if (nd->version.major < 14)
+		msg[0] =3D NET_OLD_OPER_NAME_READ_REQ;
+
 	if (g_isi_client_send(nd->client, msg, sizeof(msg), name_get_resp_cb,
 				cbd, g_free))
 		return;
diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
index ee1fbf2..57c92ac 100644
--- a/drivers/isimodem/network.h
+++ b/drivers/isimodem/network.h
@@ -45,6 +45,8 @@ enum net_message_id {
 	NET_RSSI_IND =3D					0x1E,
 	NET_CIPHERING_IND =3D				0x20,
 	NET_TIME_IND =3D					0x27,
+	NET_OLD_OPER_NAME_READ_REQ =3D			0x28,
+	NET_OLD_OPER_NAME_READ_RESP =3D			0x29,
 	NET_CHANNEL_INFO_IND =3D				0x2C,
 	NET_RAT_IND =3D					0x35,
 	NET_RAT_REQ =3D					0x36,
-- =

1.7.1


--===============3648699135023104582==--

