Content-Type: multipart/mixed; boundary="===============0144028346311387129=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 3/7] history-agent: Make compile
Date: Thu, 19 Apr 2012 11:20:52 +0300
Message-ID: <1334823656-3366-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334823656-3366-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0144028346311387129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle OFONO_HISTORY_SMS_STATUS_SUBMIT_CANCELLED case too.
---
 plugins/history-agent.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/history-agent.c b/plugins/history-agent.c
index 6979195..040df13 100644
--- a/plugins/history-agent.c
+++ b/plugins/history-agent.c
@@ -639,6 +639,9 @@ static void history_sms_send_status(struct ofono_histor=
y_context *context,
 	case OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED:
 		status_str =3D "submit-failed";
 		break;
+	case OFONO_HISTORY_SMS_STATUS_SUBMIT_CANCELLED:
+		status_str =3D "submit-cancelled";
+		break;
 	case OFONO_HISTORY_SMS_STATUS_DELIVERED:
 		status_str =3D "delivered";
 		break;
-- =

1.7.5.4


--===============0144028346311387129==--

