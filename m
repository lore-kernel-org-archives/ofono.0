Content-Type: multipart/mixed; boundary="===============0716120835322553011=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/3] message-waiting: API to retrieve voicemail number
Date: Mon, 20 Jun 2011 17:12:42 +0200
Message-ID: <1308582763-3605-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1308582763-3605-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0716120835322553011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/message-waiting.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index ad534d9..bce881b 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -605,6 +605,12 @@ static void mw_cphs_mbdn_changed(int id, void *userdat=
a)
 			mw_cphs_mbdn_read_cb, mw);
 }
 =

+const struct ofono_phone_number *ofono_message_waiting_get_voicemail_numbe=
r(
+					struct ofono_message_waiting *mw)
+{
+	return &mw->mailbox_number[0];
+}
+
 static void mw_mbi_read_cb(int ok, int total_length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
-- =

1.7.1


--===============0716120835322553011==--

