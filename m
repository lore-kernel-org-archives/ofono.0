Content-Type: multipart/mixed; boundary="===============8890179238010684366=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 03/12] src: add atom type for gnss
Date: Thu, 24 Mar 2011 15:46:27 +0200
Message-ID: <1300974396-15801-4-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1300974396-15801-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8890179238010684366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index b9ca314..81570fe 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -132,6 +132,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_EMULATOR_DUN,
 	OFONO_ATOM_TYPE_EMULATOR_HFP,
 	OFONO_ATOM_TYPE_LOCATION_REPORTING,
+	OFONO_ATOM_TYPE_GNSS,
 };
 =

 enum ofono_atom_watch_condition {
@@ -454,3 +455,4 @@ void __ofono_gprs_provision_free_settings(
 				int count);
 =

 #include <ofono/emulator.h>
+#include <ofono/gnss.h>
-- =

1.7.0.4


--===============8890179238010684366==--

