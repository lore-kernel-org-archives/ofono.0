Content-Type: multipart/mixed; boundary="===============1936698075147224356=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/16] stkutil: Add Send DTMF response builder support.
Date: Sun, 23 May 2010 12:16:16 +0200
Message-ID: <1274609776-7009-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1936698075147224356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 src/stkutil.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 71fe9f9..2d0e366 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3775,6 +3775,8 @@ unsigned int stk_pdu_from_response(const struct stk_r=
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
index 29cbb9a..e82d5f9 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1117,6 +1117,7 @@ struct stk_response {
 		struct stk_response_timer_mgmt timer_mgmt;
 		struct stk_response_generic set_up_idle_mode_text;
 		struct stk_response_run_at_command run_at_command;
+		struct stk_response_generic send_dtmf;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============1936698075147224356==--

