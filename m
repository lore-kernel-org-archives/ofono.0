Content-Type: multipart/mixed; boundary="===============3748218601250850718=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC ssn PATCH 1/4] ssn: include ssn codes in public API
Date: Fri, 08 Oct 2010 18:36:37 +0300
Message-ID: <1286552200-18282-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286552200-18282-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3748218601250850718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Include +CSSI and +CSSU codes in <include/ssn.h> and prefix them with
OFONO_.

Added CSSU code 10, OFONO_SS_MT_OTHER_CALL_FORWARDED, which is sent to
mobile if call was forwarded while mobile was engaged with other
call(s).
---
 include/ssn.h      |   29 ++++++++++++++++++++++++++++-
 src/call-barring.c |    4 ++--
 src/common.h       |   26 --------------------------
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/include/ssn.h b/include/ssn.h
index d640cad..4e6d65c 100644
--- a/include/ssn.h
+++ b/include/ssn.h
@@ -36,8 +36,35 @@ struct ofono_ssn_driver {
 	void (*remove)(struct ofono_ssn *ssn);
 };
 =

-/* SSN notifications (CSSI and CSSU).  */
+/* TS 27.007 Supplementary service notifications +CSSN (CSSI and CSSU) */
+enum ofono_ssn_cssi {
+	OFONO_SS_MO_UNCONDITIONAL_FORWARDING	=3D 0,
+	OFONO_SS_MO_CONDITIONAL_FORWARDING	=3D 1,
+	OFONO_SS_MO_CALL_FORWARDED		=3D 2,
+	OFONO_SS_MO_CALL_WAITING		=3D 3,
+	OFONO_SS_MO_CUG_CALL			=3D 4,
+	OFONO_SS_MO_OUTGOING_BARRING		=3D 5,
+	OFONO_SS_MO_INCOMING_BARRING		=3D 6,
+	OFONO_SS_MO_CLIR_SUPPRESSION_REJECTED	=3D 7,
+	OFONO_SS_MO_CALL_DEFLECTED		=3D 8,
+};
+
 void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code, int index);
+
+enum ofono_ssn_cssu {
+	OFONO_SS_MT_CALL_FORWARDED		=3D 0,
+	OFONO_SS_MT_CUG_CALL			=3D 1,
+	OFONO_SS_MT_VOICECALL_ON_HOLD		=3D 2,
+	OFONO_SS_MT_VOICECALL_RETRIEVED		=3D 3,
+	OFONO_SS_MT_MULTIPARTY_VOICECALL	=3D 4,
+	OFONO_SS_MT_VOICECALL_HOLD_RELEASED	=3D 5,
+	OFONO_SS_MT_FORWARD_CHECK_SS_MESSAGE	=3D 6,
+	OFONO_SS_MT_VOICECALL_IN_TRANSFER	=3D 7,
+	OFONO_SS_MT_VOICECALL_TRANSFERRED	=3D 8,
+	OFONO_SS_MT_CALL_DEFLECTED		=3D 9,
+	OFONO_SS_MT_OTHER_CALL_FORWARDED        =3D 10,
+};
+
 void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code, int index,
 				const struct ofono_phone_number *number);
 =

diff --git a/src/call-barring.c b/src/call-barring.c
index f89602e..7a17479 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -1131,11 +1131,11 @@ static void ssn_watch(struct ofono_atom *atom,
 	cb->ssn =3D __ofono_atom_get_data(atom);
 =

 	cb->incoming_bar_watch =3D
-		__ofono_ssn_mo_watch_add(cb->ssn, SS_MO_INCOMING_BARRING,
+		__ofono_ssn_mo_watch_add(cb->ssn, OFONO_SS_MO_INCOMING_BARRING,
 				call_barring_incoming_enabled_notify, cb, NULL);
 =

 	cb->outgoing_bar_watch =3D
-		__ofono_ssn_mo_watch_add(cb->ssn, SS_MO_OUTGOING_BARRING,
+		__ofono_ssn_mo_watch_add(cb->ssn, OFONO_SS_MO_OUTGOING_BARRING,
 				call_barring_outgoing_enabled_notify, cb, NULL);
 }
 =

diff --git a/src/common.h b/src/common.h
index c43e46d..7a148b5 100644
--- a/src/common.h
+++ b/src/common.h
@@ -89,32 +89,6 @@ enum ss_control_type {
 	SS_CONTROL_TYPE_ERASURE,
 };
 =

-/* TS 27.007 Supplementary service notifications +CSSN */
-enum ss_cssi {
-	SS_MO_UNCONDITIONAL_FORWARDING	=3D 0,
-	SS_MO_CONDITIONAL_FORWARDING	=3D 1,
-	SS_MO_CALL_FORWARDED		=3D 2,
-	SS_MO_CALL_WAITING		=3D 3,
-	SS_MO_CUG_CALL			=3D 4,
-	SS_MO_OUTGOING_BARRING		=3D 5,
-	SS_MO_INCOMING_BARRING		=3D 6,
-	SS_MO_CLIR_SUPPRESSION_REJECTED	=3D 7,
-	SS_MO_CALL_DEFLECTED		=3D 8,
-};
-
-enum ss_cssu {
-	SS_MT_CALL_FORWARDED		=3D 0,
-	SS_MT_CUG_CALL			=3D 1,
-	SS_MT_VOICECALL_ON_HOLD		=3D 2,
-	SS_MT_VOICECALL_RETRIEVED	=3D 3,
-	SS_MT_MULTIPARTY_VOICECALL	=3D 4,
-	SS_MT_VOICECALL_HOLD_RELEASED	=3D 5,
-	SS_MT_FORWARD_CHECK_SS_MESSAGE	=3D 6,
-	SS_MT_VOICECALL_IN_TRANSFER	=3D 7,
-	SS_MT_VOICECALL_TRANSFERRED	=3D 8,
-	SS_MT_CALL_DEFLECTED		=3D 9,
-};
-
 enum pin_type {
 	PIN_TYPE_NONE,
 	PIN_TYPE_PIN,
-- =

1.7.0.4


--===============3748218601250850718==--

