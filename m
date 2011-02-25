Content-Type: multipart/mixed; boundary="===============6209267733355629878=="
MIME-Version: 1.0
From: Antoine Reversat <a.reversat@gmail.com>
Subject: [PATCH 2/3] Add CNAP support for isimodem
Date: Fri, 25 Feb 2011 14:23:17 -0500
Message-ID: <1298661798-4059-2-git-send-email-a.reversat@gmail.com>
In-Reply-To: <AANLkTik_2_gbnD3EgGJkAtQj8OBHWXA6nY093LSJDN5V@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6209267733355629878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |   42 ++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 0f9753b..0870556 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -56,8 +56,10 @@ struct isi_call {
 	uint8_t cause;
 	uint8_t addr_type;
 	uint8_t presentation;
+	uint8_t name_presentation;
 	uint8_t reason;
 	char address[20];
+	char name[20];
 	char addr_pad[4];
 };
 =

@@ -245,6 +247,34 @@ static void isi_call_destination_address_sb_proc(struc=
t isi_voicecall *ivc,
 		isi_call_any_address_sb_proc(ivc, call, sb);
 }
 =

+static void isi_call_origin_info_sb_proc(struct isi_voicecall *ivc,
+						struct isi_call *call,
+						GIsiSubBlockIter *sb)
+{
+	uint8_t pres;
+	uint8_t id;
+	uint8_t len;
+	char *name;
+
+	if (!g_isi_sb_iter_get_byte(sb, &pres, 2))
+		return;
+
+	if (!g_isi_sb_iter_get_byte(sb, &id, 6))
+		return;
+
+	if (!g_isi_sb_iter_get_byte(sb, &len, 7))
+		return;
+
+	if (!g_isi_sb_iter_get_alpha_tag(sb, &name, 2 * len, 8))
+		return;
+
+	DBG("Got name %s", name);
+	call->name_presentation =3D pres;
+	strncpy(call->name, name, sizeof(call->name));
+
+	g_free(name);
+}
+
 static void isi_call_mode_sb_proc(struct isi_voicecall *ivc,
 					struct isi_call *call,
 					GIsiSubBlockIter *sb)
@@ -402,13 +432,18 @@ static struct ofono_call isi_call_as_ofono_call(const=
 struct isi_call *call)
 	ocall.status =3D isi_call_status_to_clcc(call);
 =

 	memcpy(number->number, call->address, sizeof(number->number));
+	memcpy(ocall.name, call->name, sizeof(ocall.name));
 =

 	number->type =3D 0x80 | call->addr_type;
 	ocall.clip_validity =3D call->presentation & 3;
+	ocall.cnap_validity =3D call->name_presentation & 3;
 =

 	if (ocall.clip_validity =3D=3D 0 && strlen(number->number) =3D=3D 0)
 		ocall.clip_validity =3D 2;
 =

+	if (ocall.cnap_validity =3D=3D 0 && strlen(call->name) =3D=3D 0)
+		ocall.cnap_validity =3D 2;
+
 	return ocall;
 }
 =

@@ -519,11 +554,12 @@ static void isi_call_notify(struct ofono_voicecall *o=
vc, struct isi_call *call)
 =

 	ocall =3D isi_call_as_ofono_call(call);
 =

-	DBG("id=3D%u,%s,%u,\"%s\",%u,%u",
+	DBG("id=3D%u,%s,%u,\"%s\",\"%s\",%u,%u",
 		ocall.id,
 		ocall.direction ? "terminated" : "originated",
 		ocall.status,
 		ocall.phone_number.number,
+		ocall.name,
 		ocall.phone_number.type,
 		ocall.clip_validity);
 =

@@ -628,6 +664,10 @@ static void isi_call_status_ind_cb(const GIsiMessage *=
msg, void *data)
 			isi_call_origin_address_sb_proc(ivc, call, &iter);
 			break;
 =

+		case CALL_ORIGIN_INFO:
+			isi_call_origin_info_sb_proc(ivc, call, &iter);
+			break;
+
 		case CALL_GSM_DETAILED_CAUSE:
 		case CALL_DESTINATION_PRE_ADDRESS:
 		case CALL_DESTINATION_POST_ADDRESS:
-- =

1.7.1


--===============6209267733355629878==--

