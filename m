Content-Type: multipart/mixed; boundary="===============6903069174523840194=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/7] message: add cancelled state
Date: Fri, 04 Feb 2011 13:02:40 -0200
Message-ID: <1296831764-6554-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296831764-6554-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6903069174523840194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from Yang Gu <gyagp0@gmail.com>
---
 src/message.c |    2 ++
 src/message.h |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/message.c b/src/message.c
index eb85adf..668a693 100644
--- a/src/message.c
+++ b/src/message.c
@@ -46,6 +46,8 @@ static const char *message_state_to_string(enum message_s=
tate s)
 		return "sent";
 	case MESSAGE_STATE_FAILED:
 		return "failed";
+	case MESSAGE_STATE_CANCELLED:
+		return "cancelled";
 	}
 =

 	return NULL;
diff --git a/src/message.h b/src/message.h
index 14e66c3..ad30798 100644
--- a/src/message.h
+++ b/src/message.h
@@ -24,7 +24,8 @@
 enum message_state {
 	MESSAGE_STATE_PENDING,
 	MESSAGE_STATE_SENT,
-	MESSAGE_STATE_FAILED
+	MESSAGE_STATE_FAILED,
+	MESSAGE_STATE_CANCELLED,
 };
 =

 struct ofono_atom;
-- =

1.7.4


--===============6903069174523840194==--

