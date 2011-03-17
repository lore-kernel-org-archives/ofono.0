Content-Type: multipart/mixed; boundary="===============0500526745669954543=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 3/4] emulator: add API to set network mode and name
Date: Thu, 17 Mar 2011 17:50:55 +0100
Message-ID: <1300380656-8757-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1300380656-8757-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0500526745669954543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 701decd..509ec71 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -101,6 +101,11 @@ enum ofono_emulator_request_type ofono_emulator_reques=
t_get_type(
 void ofono_emulator_set_indicator(struct ofono_emulator *em,
 					const char *name, int value);
 =

+void ofono_emulator_set_network_name(struct ofono_emulator *em,
+					const char *name);
+
+void ofono_emulator_set_network_mode(struct ofono_emulator *em, int mode);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============0500526745669954543==--

