Content-Type: multipart/mixed; boundary="===============8682839641682120243=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 1/4] ubloxmodem: pre-eliminary support for ublox SARA serial
 modems
Date: Fri, 31 May 2019 14:44:18 +0300
Message-ID: <20190531114421.21092-2-philippe.deswert@digitalistgroup.com>
In-Reply-To: <20190531114421.21092-1-philippe.deswert@digitalistgroup.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8682839641682120243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding support for ublox sara models of NB-IoT modems
---
 drivers/ubloxmodem/lte.c        |  9 +++++++++
 drivers/ubloxmodem/netmon.c     |  2 ++
 drivers/ubloxmodem/ubloxmodem.c | 14 ++++++++++++++
 drivers/ubloxmodem/ubloxmodem.h |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/drivers/ubloxmodem/lte.c b/drivers/ubloxmodem/lte.c
index eb9062d9..6cb982e8 100644
--- a/drivers/ubloxmodem/lte.c
+++ b/drivers/ubloxmodem/lte.c
@@ -86,6 +86,8 @@ static void at_lte_set_default_attach_info_cb(gboolean ok=
, GAtResult *result,
 		cid =3D 4;
 	} else if (ublox_is_toby_l4(ldd->model)) {
 		cid =3D 1;
+	} else if (ublox_is_sara(ldd->model)) {
+		cid =3D 1;
 	} else {
 		ofono_error("Unknown model; "
 			"unable to determine EPS default bearer CID");
@@ -146,6 +148,13 @@ static void ublox_lte_set_default_attach_info(const st=
ruct ofono_lte *lte,
 				info->apn);
 		else
 			snprintf(buf, sizeof(buf), "AT+CGDCONT=3D1");
+	} else if (ublox_is_sara(ldd->model)) {
+		if (strlen(info->apn) > 0)
+			snprintf(buf, sizeof(buf), "AT+CGDCONT=3D1,%s,\"%s\"",
+				at_util_gprs_proto_to_pdp_type(info->proto),
+				info->apn);
+		else
+			snprintf(buf, sizeof(buf), "AT+CGDCONT=3D1");
 	}
 =

 	if (g_at_chat_send(ldd->chat, buf, none_prefix,
diff --git a/drivers/ubloxmodem/netmon.c b/drivers/ubloxmodem/netmon.c
index ef042ed4..b16e0ca6 100644
--- a/drivers/ubloxmodem/netmon.c
+++ b/drivers/ubloxmodem/netmon.c
@@ -86,6 +86,8 @@ static int ublox_map_radio_access_technology(int tech)
 	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
 		return OFONO_NETMON_CELL_TYPE_UMTS;
 	case ACCESS_TECHNOLOGY_EUTRAN:
+	case ACCESS_TECHNOLOGY_NB_IOT_M1:
+       case ACCESS_TECHNOLOGY_NB_IOT_NB1:
 		return OFONO_NETMON_CELL_TYPE_LTE;
 	}
 =

diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
index a52a67ea..1fc59c68 100644
--- a/drivers/ubloxmodem/ubloxmodem.c
+++ b/drivers/ubloxmodem/ubloxmodem.c
@@ -39,6 +39,14 @@ const struct ublox_model ublox_models[] =3D {
 	{
 		.name =3D "SARA-G270",
 	},
+	{
+		.name =3D "SARA-R410M-02B",
+		.flags =3D UBLOX_SARA,
+	},
+	{
+		.name =3D "SARA-R412M-02B",
+		.flags =3D UBLOX_SARA,
+	},
 	/* TOBY L2 series */
 	{
 		.name =3D "TOBY-L200",
@@ -102,6 +110,12 @@ int ublox_model_to_id(const struct ublox_model *model)
 	return model - ublox_models;
 }
 =

+int ublox_is_sara(const struct ublox_model *model)
+{
+        return model->flags & UBLOX_SARA;
+}
+
+
 int ublox_is_toby_l2(const struct ublox_model *model)
 {
 	return model->flags & UBLOX_F_TOBY_L2;
diff --git a/drivers/ubloxmodem/ubloxmodem.h b/drivers/ubloxmodem/ubloxmode=
m.h
index 2c5b7433..3588f186 100644
--- a/drivers/ubloxmodem/ubloxmodem.h
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -27,6 +27,7 @@ enum ublox_flags {
 	UBLOX_F_TOBY_L2		=3D (1 << 0),
 	UBLOX_F_TOBY_L4		=3D (1 << 1),
 	UBLOX_F_HAVE_USBCONF	=3D (1 << 2),
+	UBLOX_SARA		=3D (1 << 3),
 };
 =

 struct ublox_model {
@@ -37,6 +38,7 @@ struct ublox_model {
 const struct ublox_model *ublox_model_from_name(const char *name);
 const struct ublox_model *ublox_model_from_id(int id);
 int ublox_model_to_id(const struct ublox_model *model);
+int ublox_is_sara(const struct ublox_model *model);
 int ublox_is_toby_l2(const struct ublox_model *model);
 int ublox_is_toby_l4(const struct ublox_model *model);
 =

-- =

2.20.1


--===============8682839641682120243==--

