Content-Type: multipart/mixed; boundary="===============3910462230838615004=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: [PATCH] rilmodem: set proto type during setting initial attach apn
Date: Mon, 20 Jul 2020 18:16:03 +0900
Message-ID: <20200720091603.16172-1-wjs890204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3910462230838615004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added the protocol type of initial attach apn depends on protocol
type in LTE Atom.
---
 drivers/rilmodem/lte.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rilmodem/lte.c b/drivers/rilmodem/lte.c
index 61718961..b613d354 100644
--- a/drivers/rilmodem/lte.c
+++ b/drivers/rilmodem/lte.c
@@ -71,6 +71,7 @@ static void ril_lte_set_default_attach_info(const struct =
ofono_lte *lte,
 	struct cb_data *cbd =3D cb_data_new(cb, data, (struct ofono_lte *)lte);
 	struct parcel rilp;
 	char buf[OFONO_GPRS_MAX_APN_LENGTH + 1];
+	const char *proto =3D ril_util_gprs_proto_to_ril_string(info->proto);
 =

 	DBG("%s", info->apn);
 =

@@ -80,10 +81,11 @@ static void ril_lte_set_default_attach_info(const struc=
t ofono_lte *lte,
 	if (strlen(info->apn) > 0) {
 		sprintf(buf, "%s", info->apn);
 		parcel_w_string(&rilp, buf);
-	} else
+	} else {
 		parcel_w_string(&rilp, "");	/* apn */
+	}
 =

-	parcel_w_string(&rilp, "ip");		/* protocol */
+	parcel_w_string(&rilp, proto);	/* protocol */
 	parcel_w_int32(&rilp, 0);		/* auth type */
 	parcel_w_string(&rilp, "");		/* username */
 	parcel_w_string(&rilp, "");		/* password */
-- =

2.17.1

--===============3910462230838615004==--

