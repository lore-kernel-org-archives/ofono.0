Content-Type: multipart/mixed; boundary="===============1091469009964062965=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv5 4/5] call-forwarding: Cache ss TYPE_ALL queries
Date: Thu, 07 Jun 2012 10:21:43 +0300
Message-ID: <1339053704-8749-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1339053704-8749-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1091469009964062965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 3df009b..8cad35e 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1174,6 +1174,8 @@ static gboolean cf_ss_control(int type, const char *s=
c,
 =

 	switch (cf->ss_req->cf_type) {
 	case CALL_FORWARDING_TYPE_ALL:
+		if (cf->ss_req->ss_type =3D=3D SS_CONTROL_TYPE_QUERY)
+			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
 		cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
 		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
 		break;
-- =

1.7.5.4


--===============1091469009964062965==--

