Content-Type: multipart/mixed; boundary="===============4023160342536444867=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 18/27] stkutil: Add Set Up Menu response builder support.
Date: Sun, 16 May 2010 16:06:51 +0200
Message-ID: <1274018811-6840-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4023160342536444867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 +
 src/stkutil.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d0c11a6..798e2a9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3208,6 +3208,7 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					NULL);
 		break;
 	case STK_COMMAND_TYPE_REFRESH:
+	case STK_COMMAND_TYPE_SETUP_MENU:
 		break;
 	default:
 		return 0;
diff --git a/src/stkutil.h b/src/stkutil.h
index 99c10bf..96919f3 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1033,6 +1033,7 @@ struct stk_response {
 		struct stk_response_generic play_tone;
 		struct stk_response_poll_interval poll_interval;
 		struct stk_response_generic refresh;
+		struct stk_response_generic set_up_menu;
 		struct stk_response_generic send_sms;
 	};
 =

-- =

1.7.1.86.g0e460.dirty


--===============4023160342536444867==--

