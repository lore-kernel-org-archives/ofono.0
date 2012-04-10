Content-Type: multipart/mixed; boundary="===============3193390301667790734=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 12/13] call-forwarding: Cache ss TYPE_ALL modifications
Date: Tue, 10 Apr 2012 15:17:33 +0300
Message-ID: <1334060254-29547-13-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3193390301667790734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 204ecc7..a22fb1f 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1184,6 +1184,7 @@ static gboolean cf_ss_control(int type, const char *s=
c,
 =

 	switch (cf->ss_req->cf_type) {
 	case CALL_FORWARDING_TYPE_ALL:
+		cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
 		cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
 		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
 		break;
-- =

1.7.5.4


--===============3193390301667790734==--

