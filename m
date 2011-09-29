Content-Type: multipart/mixed; boundary="===============3972875749414465092=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 3/6] sap: also accept err = 0 in enable()
Date: Thu, 29 Sep 2011 14:54:23 -0300
Message-ID: <1317318866-9027-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317318866-9027-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3972875749414465092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 102abc9..be2724c 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -154,7 +154,7 @@ static void sap_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	data->sap_driver =3D sap_hw_driver;
 =

 	err =3D data->sap_driver->enable(data->hw_modem, modem, fd);
-	if (err =3D=3D -EINPROGRESS) {
+	if (!err || err =3D=3D -EINPROGRESS) {
 		dbus_message_unref(reply);
 		return;
 	}
-- =

1.7.6.2


--===============3972875749414465092==--

