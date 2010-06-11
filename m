Content-Type: multipart/mixed; boundary="===============0269596701302774811=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/15] stkutil: Add the Timer Expiration envelope builder
Date: Fri, 11 Jun 2010 12:39:52 +0200
Message-ID: <1276252800-27515-7-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0269596701302774811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   13 +++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 9beac31..a945ef3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5042,6 +5042,19 @@ const unsigned char *stk_pdu_from_envelope(const str=
uct stk_envelope *envelope,
 	case STK_ENVELOPE_TYPE_EVENT_DOWNLOAD:
 		ok =3D build_envelope_event_download(&builder, envelope);
 		break;
+	case STK_ENVELOPE_TYPE_TIMER_EXPIRATION:
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids,
+					DATAOBJ_FLAG_CR,
+					envelope,
+					build_dataobj_timer_id,
+					DATAOBJ_FLAG_CR,
+					&envelope->timer_expiration.id,
+					build_dataobj_timer_value,
+					DATAOBJ_FLAG_CR,
+					&envelope->timer_expiration.value,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index ee20642..baeaedb 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1428,6 +1428,11 @@ struct stk_envelope_event_download {
 	};
 };
 =

+struct stk_envelope_timer_expiration {
+	unsigned char id;
+	struct stk_timer_value value;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1439,6 +1444,7 @@ struct stk_envelope {
 		struct stk_envelope_call_control call_control;
 		struct stk_envelope_sms_mo_control sms_mo_control;
 		struct stk_envelope_event_download event_download;
+		struct stk_envelope_timer_expiration timer_expiration;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============0269596701302774811==--

