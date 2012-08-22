Content-Type: multipart/mixed; boundary="===============8603218834818210108=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/8] call-forwarding: return specific errors for SS query
Date: Wed, 22 Aug 2012 18:18:18 +0200
Message-ID: <1345652303-12866-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345652303-12866-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8603218834818210108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Trace is modified as a CF query is not necessarily done after a CF setting
via SS.
---
 src/call-forwarding.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 5acbd67..91e34c6 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -981,9 +981,10 @@ static void ss_set_query_cf_callback(const struct ofon=
o_error *error, int total,
 	DBusMessage *reply;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		ofono_error("Setting succeeded, but query failed");
+		ofono_error("Query failed with error: %s",
+						telephony_error_to_str(error));
 		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
-		reply =3D __ofono_error_failed(cf->pending);
+		reply =3D __ofono_error_from_error(error, cf->pending);
 		__ofono_dbus_pending_reply(&cf->pending, reply);
 		return;
 	}
-- =

1.7.9.5


--===============8603218834818210108==--

