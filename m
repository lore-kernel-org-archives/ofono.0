Content-Type: multipart/mixed; boundary="===============7697251585823726554=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 3/5] history: API change for status report notify
Date: Thu, 17 Jun 2010 16:14:56 +0300
Message-ID: <1276780498-7573-4-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1276780498-7573-3-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7697251585823726554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/history.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/history.h b/include/history.h
index 300a4fb..17445f0 100644
--- a/include/history.h
+++ b/include/history.h
@@ -33,6 +33,8 @@ enum ofono_history_sms_status {
 	OFONO_HISTORY_SMS_STATUS_PENDING,
 	OFONO_HISTORY_SMS_STATUS_SUBMITTED,
 	OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED,
+	OFONO_HISTORY_SMS_STATUS_DELIVERED,
+	OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED,
 };
 =

 struct ofono_history_context {
-- =

1.6.0.4



--===============7697251585823726554==--

