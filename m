Content-Type: multipart/mixed; boundary="===============3832798252168976985=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 19/20] stkutil: Add Launch Browser response builder support
Date: Thu, 27 May 2010 06:59:58 +0200
Message-ID: <1274936399-20710-19-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3832798252168976985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 +
 src/stkutil.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index affbcae..b6dab66 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4057,6 +4057,7 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 		break;
 	case STK_COMMAND_TYPE_SEND_DTMF:
 	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
+	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
 		break;
 	default:
 		return 0;
diff --git a/src/stkutil.h b/src/stkutil.h
index cd9ef46..cc5801c 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1166,6 +1166,7 @@ struct stk_response {
 		struct stk_response_run_at_command run_at_command;
 		struct stk_response_generic send_dtmf;
 		struct stk_response_generic language_notification;
+		struct stk_response_generic launch_browser;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============3832798252168976985==--

