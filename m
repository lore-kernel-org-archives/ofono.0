Content-Type: multipart/mixed; boundary="===============2499381124107658534=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 02/12] call-forwarding: Inline get_query_next_cf_cond()
Date: Tue, 13 Mar 2012 15:46:23 +0200
Message-ID: <1331646393-5249-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2499381124107658534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 0857362..8b6659a 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -595,7 +595,7 @@ static void get_query_cf_callback(const struct ofono_er=
ror *error, int total,
 	get_query_next_cf_cond(cf);
 }
 =

-static void get_query_next_cf_cond(struct ofono_call_forwarding *cf)
+static inline void get_query_next_cf_cond(struct ofono_call_forwarding *cf)
 {
 	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
 				get_query_cf_callback, cf);
-- =

1.7.5.4


--===============2499381124107658534==--

