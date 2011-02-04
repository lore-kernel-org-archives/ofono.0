Content-Type: multipart/mixed; boundary="===============3537699065426109159=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/7] history: add cancelled status
Date: Fri, 04 Feb 2011 13:02:38 -0200
Message-ID: <1296831764-6554-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296831764-6554-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3537699065426109159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from Yang Gu <gyagp0@gmail.com>
---
 include/history.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/history.h b/include/history.h
index c1c4aa1..756097e 100644
--- a/include/history.h
+++ b/include/history.h
@@ -35,6 +35,7 @@ enum ofono_history_sms_status {
 	OFONO_HISTORY_SMS_STATUS_PENDING,
 	OFONO_HISTORY_SMS_STATUS_SUBMITTED,
 	OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED,
+	OFONO_HISTORY_SMS_STATUS_SUBMIT_CANCELLED,
 	OFONO_HISTORY_SMS_STATUS_DELIVERED,
 	OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED,
 };
-- =

1.7.4


--===============3537699065426109159==--

