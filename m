Content-Type: multipart/mixed; boundary="===============7941934816432762333=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/7] stkutil: change uint32_t to guint32
Date: Thu, 05 Aug 2010 14:32:35 -0700
Message-ID: <1281043960-9616-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1281043960-9616-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7941934816432762333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This helps avoid needing to include any extra header files if
stkutil.h is included in sim.c
---
 src/stkutil.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index ea9294c..44d167a 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -852,7 +852,7 @@ struct stk_card_reader_id {
 struct stk_other_address {
 	union {
 		/* Network Byte Order */
-		uint32_t ipv4;
+		guint32 ipv4;
 		unsigned char ipv6[16];
 	} addr;
 	enum stk_address_type type;
-- =

1.7.1.1


--===============7941934816432762333==--

