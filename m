Content-Type: multipart/mixed; boundary="===============6641229922516275183=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: AW: AW: AW: AW: connmand[186]: Online check failed but running
 dhclient manually fixes this issue
Date: Thu, 10 Aug 2017 12:47:28 +0200
Message-ID: <11ad24fd-f5f9-fa4c-6be5-90ac6a9ff74f@monom.org>
In-Reply-To: <31a9ca3feb2d4b29a3facaa5514cbbae@FE-MBX1014.de.bosch.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6641229922516275183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>    Bus 001 Device 003: ID 1bc7:1201 Telit Wireless Solutions

Here is a compile tested 'fix'. I don't know if this works and\
obviously it doesn't follow the coding guide lines for this
project. If you could test this and report back the outcome
that would be really helpful. Then I can create a proper
patch for Denis.


From de165e84a0d58aabb0dcdd46cd77eba751a3b407 Mon Sep 17 00:00:00 2001
From: Daniel Wagner <wagi@monom.org>
Date: Thu, 10 Aug 2017 12:40:39 +0200
Subject: [PATCH] qmimodem: Do not add IP config for Telit 910 EUG

This modem reports wrong IP configuration back. It's safer not to
report a bogus configuration because the user has no chance to know if
this is broken configuration or not. The user can still fall back to
DHCP. This was also the default behaviour till 475b789f3de9 ("qmi:
retrieve GPRS context parameters").
---
 drivers/qmimodem/gprs-context.c | 5 ++++-
 plugins/udevng.c                | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 9a22b89f1e54..d7c3ceba41e6 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -91,6 +91,7 @@ static void get_settings_cb(struct qmi_result *result, vo=
id *user_data)
 =

 	DBG("");
 =

+	modem =3D ofono_gprs_context_get_modem(gc);
 	if (qmi_result_set_error(result, NULL))
 		goto done;
 =

@@ -106,6 +107,9 @@ static void get_settings_cb(struct qmi_result *result, =
void *user_data)
 	if (qmi_result_get_uint8(result, QMI_WDS_RESULT_IP_FAMILY, &ip_family))
 		DBG("IP family %d", ip_family);
 =

+	if (ofono_modem_get_boolean(modem, "IgnoreIPConfig"))
+		goto done;
+
 	if (qmi_result_get_uint32(result,QMI_WDS_RESULT_IP_ADDRESS, &ip_addr)) {
 		addr.s_addr =3D htonl(ip_addr);
 		straddr =3D inet_ntoa(addr);
@@ -146,7 +150,6 @@ static void get_settings_cb(struct qmi_result *result, =
void *user_data)
 		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
 =

 done:
-	modem =3D ofono_gprs_context_get_modem(gc);
 	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
 =

 	ofono_gprs_context_set_interface(gc, interface);
diff --git a/plugins/udevng.c b/plugins/udevng.c
index aa28bcb8911e..460a6287367e 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -688,6 +688,10 @@ static gboolean setup_telitqmi(struct modem_info *mode=
m)
 =

 	ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
 	ofono_modem_set_boolean(modem->modem, "AlwaysOnline", TRUE);
+
+	if (g_strcmp0(modem->model, "1012") =3D=3D 0)
+		ofono_modem_set_boolean(modem->modem, "IgnoreIPConfig", TRUE);
+
 	ofono_modem_set_driver(modem->modem, "gobi");
 =

 	return TRUE;
-- =

2.9.4

--===============6641229922516275183==--

