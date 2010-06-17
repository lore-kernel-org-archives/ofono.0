Content-Type: multipart/mixed; boundary="===============1918380621040889429=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] stkutil: Add More Time terminal response builder
Date: Thu, 17 Jun 2010 15:42:09 +0200
Message-ID: <1276782135-26871-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276782135-26871-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1918380621040889429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 +
 src/stkutil.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 914ac1f..144251a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5504,6 +5504,7 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 					&response->get_input.text,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_MORE_TIME:
 	case STK_COMMAND_TYPE_SEND_SMS:
 	case STK_COMMAND_TYPE_PLAY_TONE:
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 8141383..8f18de8 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1438,6 +1438,7 @@ struct stk_response {
 		struct stk_response_generic display_text;
 		struct stk_response_get_inkey get_inkey;
 		struct stk_response_get_input get_input;
+		struct stk_response_generic more_time;
 		struct stk_response_generic play_tone;
 		struct stk_response_poll_interval poll_interval;
 		struct stk_response_generic refresh;
-- =

1.7.1.86.g0e460.dirty


--===============1918380621040889429==--

