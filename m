Content-Type: multipart/mixed; boundary="===============1329144336393275273=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 2/8] gprs-provision: add new atom type
Date: Tue, 18 Jan 2011 10:09:26 +0200
Message-ID: <1295338172-12773-3-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295338172-12773-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1329144336393275273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 77567c2..873b688 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -127,6 +127,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_NETTIME =3D 21,
 	OFONO_ATOM_TYPE_CTM =3D 22,
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER =3D 23,
+	OFONO_ATOM_TYPE_GPRS_PROVISION =3D 24,
 };
 =

 enum ofono_atom_watch_condition {
@@ -417,4 +418,12 @@ void __ofono_nettime_probe_drivers(struct ofono_modem =
*modem);
 void __ofono_nettime_info_received(struct ofono_modem *modem,
 					struct ofono_network_time *info);
 =

+#include <ofono/gprs-provision.h>
+
+void __ofono_gprs_provision_probe_drivers(struct ofono_modem *modem);
+
+void __ofono_gprs_provision_get_settings(struct ofono_modem *modem,
+						ofono_gprs_provision_cb_t cb,
+						void *user_data);
+
 #include <ofono/cdma-voicecall.h>
-- =

1.7.1


--===============1329144336393275273==--

