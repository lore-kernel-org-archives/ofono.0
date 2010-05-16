Content-Type: multipart/mixed; boundary="===============5590312771600753288=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/27] stkutil: Add Get Input response builder.
Date: Sun, 16 May 2010 16:05:21 +0200
Message-ID: <1274018721-6520-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5590312771600753288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    6 ++++++
 src/stkutil.h |    5 +++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 29a1760..c3c30ab 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3192,6 +3192,12 @@ unsigned int stk_pdu_from_response(const struct stk_=
response *response,
 					&response->get_inkey.duration,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_GET_INPUT:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_text, DATAOBJ_FLAG_CR,
+					&response->get_input.text,
+					NULL);
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 9603dd7..4e46cd5 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1010,6 +1010,10 @@ struct stk_response_get_inkey {
 	struct stk_duration duration;
 };
 =

+struct stk_response_get_input {
+	struct stk_answer_text text;
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1021,6 +1025,7 @@ struct stk_response {
 	union {
 		struct stk_response_generic display_text;
 		struct stk_response_get_inkey get_inkey;
+		struct stk_response_get_input get_input;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============5590312771600753288==--

