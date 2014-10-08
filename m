Content-Type: multipart/mixed; boundary="===============5342277143503870693=="
MIME-Version: 1.0
From: Sergio Checa Blanco <sergio.checa@oss.bmw-carit.de>
Subject: [PATCH] atmodem: Restore multiparty call after reconnection
Date: Wed, 08 Oct 2014 11:53:48 +0200
Message-ID: <1412762028-17784-1-git-send-email-sergio.checa@oss.bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5342277143503870693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergio Checa Blanco <sergio.checa@bmw-carit.de>

When the HFP profile is disconnected while a multiparty call is
ongoing, and it is reconnected again, oFono requests the list of
current calls to the device with AT+CLCC. In the case of a multiparty
call, the response to CLCC is being taken as multiple simple calls.

The attribute mpty parsed in function at_util_parse_clcc is never
used nor stored, so there is no way to recompose the information
about multi-party calls after a reconnection.

This patch stores this attribute coming in the +CLCC response to be
checked later on when the CallAdded signal is broadcasted. By doing
this the information about the multi-party character of a call is
not lost on the way from the +CLCC response to the emitted D-Bus
signal.
---
 drivers/atmodem/atutil.c | 1 +
 include/types.h          | 1 +
 src/voicecall.c          | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 1487348..08626b1 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -164,6 +164,7 @@ GSList *at_util_parse_clcc(GAtResult *result, unsigned =
int *ret_mpty_ids)
 		call->direction =3D dir;
 		call->status =3D status;
 		call->type =3D type;
+		call->multiparty =3D mpty;
 		strncpy(call->phone_number.number, str,
 				OFONO_MAX_PHONE_NUMBER_LENGTH);
 		call->phone_number.type =3D number_type;
diff --git a/include/types.h b/include/types.h
index 9a7dfd9..16755ce 100644
--- a/include/types.h
+++ b/include/types.h
@@ -91,6 +91,7 @@ struct ofono_call {
 	int type;
 	int direction;
 	int status;
+	ofono_bool_t multiparty;
 	struct ofono_phone_number phone_number;
 	struct ofono_phone_number called_number;
 	char name[OFONO_MAX_CALLER_NAME_LENGTH + 1];
diff --git a/src/voicecall.c b/src/voicecall.c
index d11a4cd..8bf0631 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2343,6 +2343,11 @@ void ofono_voicecall_notify(struct ofono_voicecall *=
vc,
 =

 	vc->call_list =3D g_slist_insert_sorted(vc->call_list, v, call_compare);
 =

+	if (call->multiparty) {
+		vc->multiparty_list =3D g_slist_insert_sorted(
+			vc->multiparty_list, v, call_compare);
+	}
+
 	voicecalls_emit_call_added(vc, v);
 =

 	return;
-- =

2.1.1


--===============5342277143503870693==--

