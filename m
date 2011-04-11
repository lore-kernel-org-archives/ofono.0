Content-Type: multipart/mixed; boundary="===============0029573502726130033=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 08/20] include: add set preferred ue mode api
Date: Mon, 11 Apr 2011 13:20:06 +0300
Message-ID: <1302517218-2147-9-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0029573502726130033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/modem.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index 5a34370..e416f50 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -51,6 +51,8 @@ void ofono_modem_reset(struct ofono_modem *modem);
 void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed);
 ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem);
 =

+void ofono_modem_set_preferred_ue_mode(struct ofono_modem *modem, int mode=
);
+
 ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem);
 =

 ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem);
-- =

1.7.0.4


--===============0029573502726130033==--

