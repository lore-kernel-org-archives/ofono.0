Content-Type: multipart/mixed; boundary="===============0214179641781062864=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/16] stkutil: Add Set Up Event List response builder support.
Date: Sun, 23 May 2010 12:14:48 +0200
Message-ID: <1274609688-6422-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0214179641781062864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 src/stkutil.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2b38c5c..406f5d2 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3701,6 +3701,8 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 	case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
 		ok =3D build_local_info(&builder, response);
 		break;
+	case STK_COMMAND_TYPE_SETUP_EVENT_LIST:
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index c377dce..566ae79 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1103,6 +1103,7 @@ struct stk_response {
 		struct stk_response_set_up_call set_up_call;
 		struct stk_response_generic polling_off;
 		struct stk_response_local_info provide_local_info;
+		struct stk_response_generic set_up_event_list;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============0214179641781062864==--

