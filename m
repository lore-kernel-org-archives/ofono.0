Content-Type: multipart/mixed; boundary="===============8932573530094547995=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 2/9] include: add ofono_modem_get_emergency_mode api
Date: Thu, 31 Mar 2011 09:18:25 -0700
Message-ID: <1301588312-6932-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8932573530094547995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/modem.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index a92eb88..5a34370 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -53,6 +53,8 @@ ofono_bool_t ofono_modem_get_powered(struct ofono_modem *=
modem);
 =

 ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem);
 =

+ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem);
+
 void ofono_modem_set_name(struct ofono_modem *modem, const char *name);
 =

 int ofono_modem_set_string(struct ofono_modem *modem,
-- =

1.7.0.4


--===============8932573530094547995==--

