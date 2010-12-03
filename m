Content-Type: multipart/mixed; boundary="===============6581188425021453177=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 2/5] modem: add ofono_modem_reset() to modem.h
Date: Fri, 03 Dec 2010 16:52:54 -0200
Message-ID: <1291402377-9211-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291402377-9211-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6581188425021453177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/modem.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index 7b13ee0..a92eb88 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -46,6 +46,8 @@ int ofono_modem_register(struct ofono_modem *modem);
 ofono_bool_t ofono_modem_is_registered(struct ofono_modem *modem);
 void ofono_modem_remove(struct ofono_modem *modem);
 =

+void ofono_modem_reset(struct ofono_modem *modem);
+
 void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed);
 ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem);
 =

-- =

1.7.3.2


--===============6581188425021453177==--

