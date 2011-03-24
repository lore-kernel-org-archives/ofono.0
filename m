Content-Type: multipart/mixed; boundary="===============3551729583975481773=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/1] isimodem: fix network registration for older modems
Date: Thu, 24 Mar 2011 14:14:09 +0200
Message-ID: <1300968849-19877-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1300968849-19877-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3551729583975481773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/network-registration.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index a30fc8c..8bf2423 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -78,6 +78,7 @@ struct netreg_data {
 	struct reg_info reg;
 	struct gsm_info gsm;
 	struct rat_info rat;
+	GIsiVersion version;
 	char nitz_name[OFONO_MAX_OPERATOR_NAME_LENGTH + 1];
 };
 =

@@ -338,7 +339,8 @@ static void rat_resp_cb(const GIsiMessage *msg, void *d=
ata)
 			goto error;
 	}
 =

-	if (g_isi_client_resource(nd->client) =3D=3D PN_MODEM_NETWORK)
+	if (g_isi_client_resource(nd->client) =3D=3D PN_MODEM_NETWORK ||
+			nd->version.major < 14)
 		req[0] =3D NET_MODEM_REG_STATUS_GET_REQ;
 =

 	if (g_isi_client_send(nd->client, req, sizeof(req),
@@ -649,7 +651,8 @@ static void isi_list_operators(struct ofono_netreg *net=
reg,
 	if (cbd =3D=3D NULL || nd =3D=3D NULL)
 		goto error;
 =

-	if (g_isi_client_resource(nd->client) =3D=3D PN_MODEM_NETWORK)
+	if (g_isi_client_resource(nd->client) =3D=3D PN_MODEM_NETWORK ||
+			nd->version.major < 14)
 		msg[0] =3D NET_MODEM_AVAILABLE_GET_REQ;
 =

 	if (g_isi_client_send_with_timeout(nd->client, msg, sizeof(msg),
@@ -938,6 +941,9 @@ static void reachable_cb(const GIsiMessage *msg, void *=
data)
 	if (nd =3D=3D NULL)
 		return;
 =

+	nd->version.major =3D g_isi_msg_version_major(msg);
+	nd->version.minor =3D g_isi_msg_version_minor(msg);
+
 	g_isi_client_ind_subscribe(nd->client, NET_RSSI_IND, rssi_ind_cb,
 					netreg);
 	g_isi_client_ind_subscribe(nd->client, NET_NITZ_NAME_IND, name_ind_cb,
-- =

1.7.1


--===============3551729583975481773==--

