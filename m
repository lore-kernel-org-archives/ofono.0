Content-Type: multipart/mixed; boundary="===============4556045544448122647=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 01/11] added Send USSD string maximum length
Date: Wed, 01 Sep 2010 04:00:26 -0700
Message-ID: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4556045544448122647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/types.h b/include/types.h
index 6098cba..e25ff02 100644
--- a/include/types.h
+++ b/include/types.h
@@ -77,6 +77,8 @@ struct ofono_error {
 };
 =

 #define OFONO_MAX_PHONE_NUMBER_LENGTH 20
+#define OFONO_MAX_USSD_LENGTH 160
+
 =

 struct ofono_phone_number {
 	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
-- =

1.7.0.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============4556045544448122647==--

