Content-Type: multipart/mixed; boundary="===============7305263510624463254=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 3/9] src: add atom type for gnss
Date: Tue, 08 Mar 2011 13:00:45 +0200
Message-ID: <1299582051-32701-4-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1299582051-32701-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7305263510624463254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 995a1a5..2c6899e 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -131,6 +131,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_EMULATOR_DUN,
 	OFONO_ATOM_TYPE_EMULATOR_HFP,
 	OFONO_ATOM_TYPE_LOCATION_REPORTING,
+	OFONO_ATOM_TYPE_GNSS,
 };
 =

 enum ofono_atom_watch_condition {
@@ -466,3 +467,4 @@ void __ofono_gprs_provision_free_settings(
 				int count);
 =

 #include <ofono/emulator.h>
+#include <ofono/gnss.h>
-- =

1.7.0.4


--===============7305263510624463254==--

