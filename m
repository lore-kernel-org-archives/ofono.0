Content-Type: multipart/mixed; boundary="===============2819131203017162808=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/16] stkutil: Add Language Notification response builder
 support.
Date: Sun, 23 May 2010 12:16:33 +0200
Message-ID: <1274609793-7136-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2819131203017162808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 +
 src/stkutil.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2d0e366..5810151 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3776,6 +3776,7 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					NULL);
 		break;
 	case STK_COMMAND_TYPE_SEND_DTMF:
+	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
 		break;
 	default:
 		return 0;
diff --git a/src/stkutil.h b/src/stkutil.h
index e82d5f9..46cc1d6 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1118,6 +1118,7 @@ struct stk_response {
 		struct stk_response_generic set_up_idle_mode_text;
 		struct stk_response_run_at_command run_at_command;
 		struct stk_response_generic send_dtmf;
+		struct stk_response_generic language_notification;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============2819131203017162808==--

