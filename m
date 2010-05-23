Content-Type: multipart/mixed; boundary="===============7708006928599942788=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 15/16] stkutil: Add Launch Browser response builder support.
Date: Sun, 23 May 2010 12:16:55 +0200
Message-ID: <1274609815-7281-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7708006928599942788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 +
 src/stkutil.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 5810151..be463be 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3777,6 +3777,7 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 		break;
 	case STK_COMMAND_TYPE_SEND_DTMF:
 	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
+	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
 		break;
 	default:
 		return 0;
diff --git a/src/stkutil.h b/src/stkutil.h
index 46cc1d6..f28b431 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1119,6 +1119,7 @@ struct stk_response {
 		struct stk_response_run_at_command run_at_command;
 		struct stk_response_generic send_dtmf;
 		struct stk_response_generic language_notification;
+		struct stk_response_generic launch_browser;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============7708006928599942788==--

