Content-Type: multipart/mixed; boundary="===============0752225397752147418=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/15] stkutil: Add the Timer Expiration envelope builder
Date: Fri, 11 Jun 2010 12:39:54 +0200
Message-ID: <1276252800-27515-9-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0752225397752147418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a945ef3..2efd25a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5055,6 +5055,16 @@ const unsigned char *stk_pdu_from_envelope(const str=
uct stk_envelope *envelope,
 					&envelope->timer_expiration.value,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_USSD_DOWNLOAD:
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids,
+					DATAOBJ_FLAG_CR,
+					envelope,
+					build_dataobj_ussd_string,
+					DATAOBJ_FLAG_CR,
+					&envelope->ussd_data_download.string,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index baeaedb..74ec600 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1433,6 +1433,10 @@ struct stk_envelope_timer_expiration {
 	struct stk_timer_value value;
 };
 =

+struct stk_envelope_ussd_data_download {
+	struct stk_ussd_string string;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1445,6 +1449,7 @@ struct stk_envelope {
 		struct stk_envelope_sms_mo_control sms_mo_control;
 		struct stk_envelope_event_download event_download;
 		struct stk_envelope_timer_expiration timer_expiration;
+		struct stk_envelope_ussd_data_download ussd_data_download;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============0752225397752147418==--

