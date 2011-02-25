Content-Type: multipart/mixed; boundary="===============1844439821435424975=="
MIME-Version: 1.0
From: Antoine Reversat <a.reversat@gmail.com>
Subject: [PATCH 2/2] Add CNAP support for isimodem
Date: Fri, 25 Feb 2011 12:10:24 -0500
Message-ID: <1298653824-25127-2-git-send-email-a.reversat@gmail.com>
In-Reply-To: <AANLkTi=cm_SVQ6b9p89DBP37LUFhXpxnkz4ci997ET4k@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1844439821435424975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |   39 ++++++++++++++++++++++++++++++++++++++-
 src/voicecall.c              |    5 +++--
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 0ad4dfb..37b0eb3 100644
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

@@ -242,6 +244,31 @@ static void isi_call_destination_address_sb_proc(struc=
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
+	if (!g_isi_sb_iter_get_byte(sb, &id, 6))
+		return;
+	if (!g_isi_sb_iter_get_byte(sb, &len, 7))
+		return;
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
@@ -399,13 +426,18 @@ static struct ofono_call isi_call_as_ofono_call(const=
 struct isi_call *call)
 	ocall.status =3D isi_call_status_to_clcc(call);
 =

 	memcpy(number->number, call->address, sizeof(number->number));
+	memcpy(ocall.name, call->name, sizeof(ocall.name));
 =

 	number->type =3D 0x80 | call->addr_type;
 	ocall.clip_validity =3D call->presentation & 3;
+    ocall.cnap_validity =3D call->name_presentation & 3;
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

@@ -516,11 +548,12 @@ static void isi_call_notify(struct ofono_voicecall *o=
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

@@ -625,6 +658,10 @@ static void isi_call_status_ind_cb(const GIsiMessage *=
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
diff --git a/src/voicecall.c b/src/voicecall.c
index d6e8539..ec001c0 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1951,8 +1951,9 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
 	struct ofono_call *newcall;
 =

 	DBG("Got a voicecall event, status: %d, id: %u, number: %s"
-			" called_number: %s", call->status, call->id,
-			call->phone_number.number, call->called_number.number);
+			" called_number: %s, called_name %s", call->status,
+			call->id, call->phone_number.number,
+			call->called_number.number, call->name);
 =

 	l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(call->id),
 				call_compare_by_id);
-- =

1.7.1


--===============1844439821435424975==--

