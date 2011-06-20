Content-Type: multipart/mixed; boundary="===============7832264680498132757=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/3] message-waiting: add API to retrieve voicemail number
Date: Mon, 20 Jun 2011 17:12:41 +0200
Message-ID: <1308582763-3605-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1308582763-3605-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7832264680498132757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/message-waiting.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/message-waiting.h b/include/message-waiting.h
index b40993e..adb7ef2 100644
--- a/include/message-waiting.h
+++ b/include/message-waiting.h
@@ -33,6 +33,8 @@ struct ofono_message_waiting;
 struct ofono_message_waiting *ofono_message_waiting_create(struct ofono_mo=
dem *modem);
 void ofono_message_waiting_register(struct ofono_message_waiting *mw);
 void ofono_message_waiting_remove(struct ofono_message_waiting *mw);
+const struct ofono_phone_number *ofono_message_waiting_get_voicemail_numbe=
r(
+					struct ofono_message_waiting *mw);
 =

 #ifdef __cplusplus
 }
-- =

1.7.1


--===============7832264680498132757==--

