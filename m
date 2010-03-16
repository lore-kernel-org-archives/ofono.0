Content-Type: multipart/mixed; boundary="===============2470748457618075691=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/4] Fix the structure of stk_subaddress
Date: Tue, 16 Mar 2010 18:01:37 +0800
Message-ID: <1268733700-30154-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2470748457618075691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index b59c9f0..b408f38 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -286,7 +286,7 @@ struct stk_address {
  */
 struct stk_subaddress {
 	unsigned char len;
-	unsigned char *subaddr[23];
+	unsigned char subaddr[23];
 };
 =

 /*
-- =

1.6.3.3


--===============2470748457618075691==--

