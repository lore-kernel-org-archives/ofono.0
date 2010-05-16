Content-Type: multipart/mixed; boundary="===============3818937431129420043=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/27] stkutil: Add Send Short Message response builder
 support.
Date: Sun, 16 May 2010 16:05:39 +0200
Message-ID: <1274018739-6584-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3818937431129420043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 src/stkutil.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c3c30ab..a51318f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3198,6 +3198,8 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					&response->get_input.text,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_SEND_SMS:
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 4e46cd5..a98d677 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1026,6 +1026,7 @@ struct stk_response {
 		struct stk_response_generic display_text;
 		struct stk_response_get_inkey get_inkey;
 		struct stk_response_get_input get_input;
+		struct stk_response_generic send_sms;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============3818937431129420043==--

