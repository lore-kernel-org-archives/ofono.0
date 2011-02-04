Content-Type: multipart/mixed; boundary="===============2623649314420674006=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 2/8] examples: handle cancelled history status
Date: Fri, 04 Feb 2011 17:40:32 -0200
Message-ID: <1296848438-5584-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296848438-5584-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2623649314420674006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 examples/history.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/examples/history.c b/examples/history.c
index 0a1e8d7..21668ec 100644
--- a/examples/history.c
+++ b/examples/history.c
@@ -172,6 +172,11 @@ static void example_history_sms_send_status(
 		ofono_debug("Sending SMS %s failed", ofono_uuid_to_str(uuid));
 		ofono_debug("Failure Time: %s", buf);
 		break;
+	case OFONO_HISTORY_SMS_STATUS_SUBMIT_CANCELLED:
+		ofono_debug("Submission of SMS %s was canceled",
+					ofono_uuid_to_str(uuid));
+		ofono_debug("Cancel time: %s", buf);
+		break;
 	case OFONO_HISTORY_SMS_STATUS_DELIVERED:
 		ofono_debug("SMS delivered, msg_id: %s, time: %s",
 					ofono_uuid_to_str(uuid), buf);
-- =

1.7.4


--===============2623649314420674006==--

