Content-Type: multipart/mixed; boundary="===============6510256265150251557=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 7/8] call-settings: Return specific errors for SS query
Date: Wed, 22 Aug 2012 18:18:22 +0200
Message-ID: <1345652303-12866-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345652303-12866-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6510256265150251557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Trace is modified as clir query is not necessarily done after a clir
setting via SS.
---
 src/call-settings.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index 4bfb561..51f96bf 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -726,9 +726,10 @@ static void clir_ss_query_callback(const struct ofono_=
error *error,
 	const char *value;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("setting clir via SS failed");
+		DBG("clir query via SS failed with error: %s",
+					telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+				__ofono_error_from_error(error, cs->pending));
 =

 		return;
 	}
-- =

1.7.9.5


--===============6510256265150251557==--

