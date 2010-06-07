Content-Type: multipart/mixed; boundary="===============8366914267550490683=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 14/20] stkutil: Add the MO Short Message Control envelope
 builder
Date: Mon, 07 Jun 2010 12:08:36 +0200
Message-ID: <1275905322-14768-14-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8366914267550490683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   16 ++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b9a152a..9930d0b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4441,6 +4441,22 @@ const unsigned char *stk_pdu_from_envelope(const str=
uct stk_envelope *envelope,
 					&envelope->call_control.bc_repeat,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_MO_SMS_CONTROL:
+		/*
+		 * Comprehension Required according to the specs but not
+		 * enabled in conformance tests in 3GPP 31.124.
+		 */
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids, 0,
+					envelope,
+					build_dataobj_address, 0,
+					&envelope->sms_mo_control.sc_address,
+					build_dataobj_address, 0,
+					&envelope->sms_mo_control.dest_address,
+					build_dataobj_location_info, 0,
+					&envelope->sms_mo_control.location,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 33a0f91..a57af48 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1217,6 +1217,12 @@ struct stk_envelope_call_control {
 	} bc_repeat;
 };
 =

+struct stk_envelope_sms_mo_control {
+	struct stk_address sc_address;
+	struct stk_address dest_address;
+	struct stk_location_info location;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1226,6 +1232,7 @@ struct stk_envelope {
 		struct stk_envelope_cbs_pp_download cbs_pp_download;
 		struct stk_envelope_menu_selection menu_selection;
 		struct stk_envelope_call_control call_control;
+		struct stk_envelope_sms_mo_control sms_mo_control;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============8366914267550490683==--

