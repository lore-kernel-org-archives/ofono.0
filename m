Content-Type: multipart/mixed; boundary="===============4748400235102944369=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 2/5] ofono.h: add gprs-provision
Date: Wed, 26 Jan 2011 14:34:12 +0200
Message-ID: <1296045255-29890-3-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1296045255-29890-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4748400235102944369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index e48dbf6..056c7f1 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -420,3 +420,12 @@ void __ofono_nettime_info_received(struct ofono_modem =
*modem,
 =

 #include <ofono/cdma-voicecall.h>
 #include <ofono/sim-auth.h>
+
+#include <ofono/gprs-provision.h>
+void __ofono_gprs_provision_get_settings(const char *mcc, const char *mnc,
+			struct ofono_gprs_provision_data **settings,
+			int *count);
+void __ofono_gprs_provision_free_settings(
+				struct ofono_gprs_provision_data *settings,
+				int count);
+
-- =

1.7.1


--===============4748400235102944369==--

