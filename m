Content-Type: multipart/mixed; boundary="===============7652804114905429544=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 14/27] stkutil: Add Poll Interval response builder support.
Date: Sun, 16 May 2010 16:06:17 +0200
Message-ID: <1274018777-6712-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7652804114905429544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    6 ++++++
 src/stkutil.h |    5 +++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index e45164a..1f32a5b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3201,6 +3201,12 @@ unsigned int stk_pdu_from_response(const struct stk_=
response *response,
 	case STK_COMMAND_TYPE_SEND_SMS:
 	case STK_COMMAND_TYPE_PLAY_TONE:
 		break;
+	case STK_COMMAND_TYPE_POLL_INTERVAL:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_duration, DATAOBJ_FLAG_CR,
+					&response->poll_interval.max_interval,
+					NULL);
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 342f40b..57fde78 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1014,6 +1014,10 @@ struct stk_response_get_input {
 	struct stk_answer_text text;
 };
 =

+struct stk_response_poll_interval {
+	struct stk_duration max_interval;
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1027,6 +1031,7 @@ struct stk_response {
 		struct stk_response_get_inkey get_inkey;
 		struct stk_response_get_input get_input;
 		struct stk_response_generic play_tone;
+		struct stk_response_poll_interval poll_interval;
 		struct stk_response_generic send_sms;
 	};
 =

-- =

1.7.1.86.g0e460.dirty


--===============7652804114905429544==--

