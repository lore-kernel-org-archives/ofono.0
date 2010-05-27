Content-Type: multipart/mixed; boundary="===============7758985526630234936=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/20] stkutil: Add Set Up Idle Mode Text response builder
 support
Date: Thu, 27 May 2010 06:59:50 +0200
Message-ID: <1274936399-20710-11-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7758985526630234936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 src/stkutil.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 42bc488..35db34c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4024,6 +4024,8 @@ unsigned int stk_pdu_from_response(const struct stk_r=
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
index 153da65..8c1b0db 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1158,6 +1158,7 @@ struct stk_response {
 		struct stk_response_local_info provide_local_info;
 		struct stk_response_generic set_up_event_list;
 		struct stk_response_timer_mgmt timer_mgmt;
+		struct stk_response_generic set_up_idle_mode_text;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============7758985526630234936==--

