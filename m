Content-Type: multipart/mixed; boundary="===============2480111591765860120=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] stk: Remove deprecated structure
Date: Wed, 29 Jun 2011 14:59:54 +0200
Message-ID: <1309352394-14037-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2480111591765860120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index bc795d4..f2e8668 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1477,14 +1477,6 @@ struct stk_channel {
 	enum stk_channel_status status;
 };
 =

-struct stk_channel_data {
-	struct stk_common_byte_array data;
-	union {
-		unsigned short rx_remaining;
-		unsigned short tx_avail;
-	};
-};
-
 struct stk_response_get_inkey {
 	struct stk_answer_text text;
 	struct stk_duration duration;
-- =

1.7.1


--===============2480111591765860120==--

