Content-Type: multipart/mixed; boundary="===============0449700098849439927=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 5/8] call-barring: Return specific errors for SS query
Date: Wed, 22 Aug 2012 18:18:20 +0200
Message-ID: <1345652303-12866-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345652303-12866-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0449700098849439927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Trace is modified as a CB query is not necessarily done after a CB setting
via SS.
---
 src/call-barring.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 53847fb..68533c2 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -284,14 +284,13 @@ static void cb_ss_query_next_lock_callback(const stru=
ct ofono_error *error,
 	struct ofono_call_barring *cb =3D data;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		if (cb->ss_req_type !=3D SS_CONTROL_TYPE_QUERY)
-			ofono_error("Enabling/disabling Call Barring via SS "
-					"successful, but query was not");
+		ofono_error("Query failed with error: %s",
+						telephony_error_to_str(error));
 =

 		cb->flags &=3D ~CALL_BARRING_FLAG_CACHED;
 =

 		__ofono_dbus_pending_reply(&cb->pending,
-					__ofono_error_failed(cb->pending));
+				__ofono_error_from_error(error, cb->pending));
 		return;
 	}
 =

-- =

1.7.9.5


--===============0449700098849439927==--

