Content-Type: multipart/mixed; boundary="===============3594820995781035767=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/6] stkutil: change uint32_t to guint32
Date: Wed, 25 Aug 2010 04:00:21 -0700
Message-ID: <1282734025-3375-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1282734025-3375-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3594820995781035767==
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

1.7.2.1


--===============3594820995781035767==--

