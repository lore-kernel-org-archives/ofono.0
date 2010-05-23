Content-Type: multipart/mixed; boundary="===============8394307312899185963=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/16] stkutil: Add Set Up Idle Mode Text response builder
 support.
Date: Sun, 23 May 2010 12:15:41 +0200
Message-ID: <1274609741-6745-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8394307312899185963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 src/stkutil.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 8dfea49..dd8381d 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3744,6 +3744,8 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					&response->timer_mgmt.value,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 2288216..62d0ecf 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1111,6 +1111,7 @@ struct stk_response {
 		struct stk_response_local_info provide_local_info;
 		struct stk_response_generic set_up_event_list;
 		struct stk_response_timer_mgmt timer_mgmt;
+		struct stk_response_generic set_up_idle_mode_text;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============8394307312899185963==--

