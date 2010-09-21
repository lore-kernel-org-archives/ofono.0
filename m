Content-Type: multipart/mixed; boundary="===============2463193371469206103=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/5] stk: Support send ss response
Date: Tue, 21 Sep 2010 18:21:16 +0800
Message-ID: <1285064479-12907-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1285064479-12907-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2463193371469206103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index cdd6b4e..d35094b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5449,6 +5449,8 @@ const unsigned char *stk_pdu_from_response(const stru=
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


--===============2463193371469206103==--

