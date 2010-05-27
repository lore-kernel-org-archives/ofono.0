Content-Type: multipart/mixed; boundary="===============6984664913606973309=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 17/20] stkutil: Add Language Notification response builder
 support
Date: Thu, 27 May 2010 06:59:56 +0200
Message-ID: <1274936399-20710-17-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6984664913606973309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 +
 src/stkutil.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f27a777..affbcae 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4056,6 +4056,7 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					NULL);
 		break;
 	case STK_COMMAND_TYPE_SEND_DTMF:
+	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
 		break;
 	default:
 		return 0;
diff --git a/src/stkutil.h b/src/stkutil.h
index 4a7a82d..cd9ef46 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1165,6 +1165,7 @@ struct stk_response {
 		struct stk_response_generic set_up_idle_mode_text;
 		struct stk_response_run_at_command run_at_command;
 		struct stk_response_generic send_dtmf;
+		struct stk_response_generic language_notification;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============6984664913606973309==--

