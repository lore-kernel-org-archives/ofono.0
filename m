Content-Type: multipart/mixed; boundary="===============7139208087605419356=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 1/2] message-waiting: API to retrieve voicemail number
Date: Tue, 21 Jun 2011 18:48:33 +0200
Message-ID: <1308674914-13037-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1308674914-13037-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7139208087605419356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/message-waiting.c |    7 +++++++
 src/ofono.h           |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index ad534d9..7e8c3f4 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -605,6 +605,13 @@ static void mw_cphs_mbdn_changed(int id, void *userdat=
a)
 			mw_cphs_mbdn_read_cb, mw);
 }
 =

+const struct ofono_phone_number *__ofono_message_waiting_get_mbdn(
+					struct ofono_message_waiting *mw,
+					unsigned int index)
+{
+	return &mw->mailbox_number[index];
+}
+
 static void mw_mbi_read_cb(int ok, int total_length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
diff --git a/src/ofono.h b/src/ofono.h
index 33eaf93..6524806 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -447,6 +447,10 @@ struct sms;
 void __ofono_message_waiting_mwi(struct ofono_message_waiting *mw,
 				struct sms *sms, gboolean *out_discard);
 =

+const struct ofono_phone_number *__ofono_message_waiting_get_mbdn(
+					struct ofono_message_waiting *mw,
+					unsigned int index);
+
 #include <ofono/nettime.h>
 =

 void __ofono_nettime_probe_drivers(struct ofono_modem *modem);
-- =

1.7.1


--===============7139208087605419356==--

