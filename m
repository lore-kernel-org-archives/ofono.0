Content-Type: multipart/mixed; boundary="===============0619201575137654079=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: [PATCH] voicecall: allow sending DTMF tones while call is in alerting
 state
Date: Thu, 08 Oct 2009 19:59:53 +0300
Message-ID: <1255021194-31138-2-git-send-email-ppessi@gmail.com>
In-Reply-To: <1255021194-31138-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0619201575137654079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

2nd stage dialing may be done before call gets connected.
---
 src/voicecall.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 1be907a..bd5358c 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -138,7 +138,7 @@ static const char *call_status_to_string(int status)
 	case CALL_STATUS_DIALING:
 		return "dialing";
 	case CALL_STATUS_ALERTING:
-	return "alerting";
+		return "alerting";
 	case CALL_STATUS_INCOMING:
 		return "incoming";
 	case CALL_STATUS_WAITING:
@@ -561,6 +561,10 @@ static gboolean voicecalls_have_connected(struct ofono=
_voicecall *vc)
 =

 		if (v->call->status =3D=3D CALL_STATUS_ACTIVE)
 			return TRUE;
+
+		/* Connected for 2nd stage dialing */
+		if (v->call->status =3D=3D CALL_STATUS_ALERTING)
+			return TRUE;
 	}
 =

 	return FALSE;
-- =

1.6.0.4


--===============0619201575137654079==--

