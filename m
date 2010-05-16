Content-Type: multipart/mixed; boundary="===============7934665301668858546=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/27] stkutil: Add Play Tone response builder support.
Date: Sun, 16 May 2010 16:06:01 +0200
Message-ID: <1274018761-6648-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7934665301668858546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 +
 src/stkutil.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a51318f..e45164a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3199,6 +3199,7 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					NULL);
 		break;
 	case STK_COMMAND_TYPE_SEND_SMS:
+	case STK_COMMAND_TYPE_PLAY_TONE:
 		break;
 	default:
 		return 0;
diff --git a/src/stkutil.h b/src/stkutil.h
index a98d677..342f40b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1026,6 +1026,7 @@ struct stk_response {
 		struct stk_response_generic display_text;
 		struct stk_response_get_inkey get_inkey;
 		struct stk_response_get_input get_input;
+		struct stk_response_generic play_tone;
 		struct stk_response_generic send_sms;
 	};
 =

-- =

1.7.1.86.g0e460.dirty


--===============7934665301668858546==--

