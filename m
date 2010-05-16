Content-Type: multipart/mixed; boundary="===============4172743548971934004=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 24/27] stkutil: Add Polling Off response builder support.
Date: Sun, 16 May 2010 16:07:56 +0200
Message-ID: <1274018876-7032-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4172743548971934004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 src/stkutil.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 4e813ec..30c9425 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3264,6 +3264,8 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					 cc_requested_action,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_POLLING_OFF:
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 9674f8b..9dd3b75 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1049,6 +1049,7 @@ struct stk_response {
 		struct stk_response_select_item select_item;
 		struct stk_response_generic send_sms;
 		struct stk_response_set_up_call set_up_call;
+		struct stk_response_generic polling_off;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============4172743548971934004==--

