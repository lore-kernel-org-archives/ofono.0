Content-Type: multipart/mixed; boundary="===============0010338814908293091=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/20] stkutil: Add Polling Off response builder support
Date: Thu, 27 May 2010 06:59:42 +0200
Message-ID: <1274936399-20710-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0010338814908293091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 src/stkutil.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c9b9511..1f477db 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3532,6 +3532,8 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 	case STK_COMMAND_TYPE_SETUP_CALL:
 		ok =3D build_set_up_call(&builder, response);
 		break;
+	case STK_COMMAND_TYPE_POLLING_OFF:
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 3245a90..82384c4 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1096,6 +1096,7 @@ struct stk_response {
 		struct stk_response_select_item select_item;
 		struct stk_response_generic send_sms;
 		struct stk_response_set_up_call set_up_call;
+		struct stk_response_generic polling_off;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============0010338814908293091==--

