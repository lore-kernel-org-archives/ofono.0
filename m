Content-Type: multipart/mixed; boundary="===============6782590699578977668=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/5] include: Add set/get data APIs to emulator
Date: Tue, 05 Feb 2013 17:26:57 +0100
Message-ID: <1360081620-19458-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1360081620-19458-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6782590699578977668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/emulator.h b/include/emulator.h
index 5cd894b..6dc1938 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -74,6 +74,11 @@ void ofono_emulator_register(struct ofono_emulator *em, =
int fd);
 =

 void ofono_emulator_remove(struct ofono_emulator *em);
 =

+void ofono_emulator_set_data(struct ofono_emulator *em, void *data,
+						ofono_destroy_func destroy);
+
+void *ofono_emulator_get_data(struct ofono_emulator *em);
+
 void ofono_emulator_send_final(struct ofono_emulator *em,
 				const struct ofono_error *final);
 void ofono_emulator_send_unsolicited(struct ofono_emulator *em,
-- =

1.7.9.5


--===============6782590699578977668==--

