Content-Type: multipart/mixed; boundary="===============0853816907281305576=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 16/27] stkutil: Add Refresh response builder support.
Date: Sun, 16 May 2010 16:06:34 +0200
Message-ID: <1274018794-6776-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0853816907281305576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 src/stkutil.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 1f32a5b..9d9cfa6 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3207,6 +3207,8 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					&response->poll_interval.max_interval,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_PLAY_REFRESH:
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 57fde78..99c10bf 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1032,6 +1032,7 @@ struct stk_response {
 		struct stk_response_get_input get_input;
 		struct stk_response_generic play_tone;
 		struct stk_response_poll_interval poll_interval;
+		struct stk_response_generic refresh;
 		struct stk_response_generic send_sms;
 	};
 =

-- =

1.7.1.86.g0e460.dirty


--===============0853816907281305576==--

