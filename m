Content-Type: multipart/mixed; boundary="===============2374791051533144306=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/7] include: Add flag for drivers that watch SIM state
Date: Fri, 13 Nov 2015 13:25:05 +0100
Message-ID: <1447417510-9368-3-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1447417510-9368-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2374791051533144306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add flag for drivers that handle modems that cannot access the SIM when
in offline state. These drivers watch the SIM state to create/destroy
certain atoms.
---
 include/modem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/modem.h b/include/modem.h
index e40b23e..54ce862 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -115,6 +115,10 @@ int ofono_modem_set_boolean(struct ofono_modem *modem,
 ofono_bool_t ofono_modem_get_boolean(struct ofono_modem *modem,
 					const char *key);
 =

+void ofono_modem_set_driver_watches_sim(struct ofono_modem *modem,
+					ofono_bool_t value);
+ofono_bool_t ofono_modem_get_driver_watches_sim(struct ofono_modem *modem);
+
 int ofono_modem_driver_register(const struct ofono_modem_driver *);
 void ofono_modem_driver_unregister(const struct ofono_modem_driver *);
 =

-- =

2.5.0


--===============2374791051533144306==--

