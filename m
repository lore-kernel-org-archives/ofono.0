Content-Type: multipart/mixed; boundary="===============0110903903494443833=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 8/8] Add emulator interface for phonesim
Date: Tue, 13 Apr 2010 22:18:19 +0800
Message-ID: <1271168299-4862-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1271168299-4862-8-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0110903903494443833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index ca12cf2..15dabca 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -56,6 +56,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/emulator.h>
 =

 #include <drivers/atmodem/vendor.h>
 =

@@ -287,6 +288,8 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 		ofono_voicecall_create(modem, 0, "calypsomodem", data->chat);
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+
+	ofono_emulator_create(modem, 0, "atemulator", data->chat);
 }
 =

 static void phonesim_post_sim(struct ofono_modem *modem)
-- =

1.6.6.1


--===============0110903903494443833==--

