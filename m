Content-Type: multipart/mixed; boundary="===============2497780131351988284=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [ss-notify FYI 1/6] ssn: include ssn codes in public API
Date: Fri, 28 Jan 2011 19:38:14 +0200
Message-ID: <1296236300-19189-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1296236300-19189-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2497780131351988284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Include +CSSI and +CSSU codes in <include/ssn.h> and prefix them with
OFONO_.
---
 include/ssn.h |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/include/ssn.h b/include/ssn.h
index d640cad..9466a80 100644
--- a/include/ssn.h
+++ b/include/ssn.h
@@ -36,8 +36,34 @@ struct ofono_ssn_driver {
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
+};
+
 void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code, int index);
+
 void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code, int index,
 				const struct ofono_phone_number *number);
 =

-- =

1.7.1


--===============2497780131351988284==--

