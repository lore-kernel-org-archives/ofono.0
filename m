Content-Type: multipart/mixed; boundary="===============7936591184509709108=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 15/20] stkutil: Add Send DTMF response builder support
Date: Thu, 27 May 2010 06:59:54 +0200
Message-ID: <1274936399-20710-15-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7936591184509709108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 src/stkutil.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 5a53fc6..f27a777 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4055,6 +4055,8 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					response->run_at_command.at_response,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_SEND_DTMF:
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index ac462e0..4a7a82d 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1164,6 +1164,7 @@ struct stk_response {
 		struct stk_response_timer_mgmt timer_mgmt;
 		struct stk_response_generic set_up_idle_mode_text;
 		struct stk_response_run_at_command run_at_command;
+		struct stk_response_generic send_dtmf;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============7936591184509709108==--

