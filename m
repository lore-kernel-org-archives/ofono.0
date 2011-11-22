Content-Type: multipart/mixed; boundary="===============9047525408641041128=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 01/32] modem: Add modem type to ofono_modem_driver
Date: Tue, 22 Nov 2011 18:09:30 +0100
Message-ID: <1321981801-5452-2-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9047525408641041128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 include/modem.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index 3fea2de..c34703b 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -30,6 +30,12 @@ extern "C" {
 =

 struct ofono_modem;
 =

+enum ofono_modem_type {
+	OFONO_MODEM_TYPE_HARDWARE,
+	OFONO_MODEM_TYPE_HFP,
+	OFONO_MODEM_TYPE_SAP,
+};
+
 void ofono_modem_add_interface(struct ofono_modem *modem,
 				const char *interface);
 void ofono_modem_remove_interface(struct ofono_modem *modem,
@@ -75,6 +81,7 @@ typedef void (*ofono_modem_online_cb_t)(const struct ofon=
o_error *error,
 =

 struct ofono_modem_driver {
 	const char *name;
+	enum ofono_modem_type modem_type;
 =

 	/* Detect existence of device and initialize any device-specific data
 	 * structures */
-- =

1.7.8.rc1.14.g248db


--===============9047525408641041128==--

