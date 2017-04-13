Content-Type: multipart/mixed; boundary="===============4516443651071600999=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH v3 2/3] gemalto: Change offline mode, keep USIM available
Date: Thu, 13 Apr 2017 10:05:46 +0200
Message-ID: <1492070747-7252-3-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <1492070747-7252-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4516443651071600999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gemalto has two airplane mode:
CFUN=3D0 disables USIM
CFUN=3D4 keeps USIM connected
---
 plugins/gemalto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 846e263..ab0da8f 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -165,7 +165,7 @@ static void gemalto_set_online(struct ofono_modem *mode=
m, ofono_bool_t online,
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D0";
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-- =

1.9.1


--===============4516443651071600999==--

