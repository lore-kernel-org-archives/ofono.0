Content-Type: multipart/mixed; boundary="===============8035888205745012969=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v3 2/4] stk: Support send ss response
Date: Mon, 18 Oct 2010 16:00:29 +0800
Message-ID: <1287388831-27269-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1287388831-27269-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8035888205745012969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 82da079..cdd66bd 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5455,6 +5455,8 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 					&response->select_item.item_id,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_SEND_SS:
+		break;
 	case STK_COMMAND_TYPE_SETUP_CALL:
 		ok =3D build_setup_call(&builder, response);
 		break;
-- =

1.7.2.3


--===============8035888205745012969==--

