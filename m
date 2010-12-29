Content-Type: multipart/mixed; boundary="===============4332498661337490896=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/4] call-settings: fix getting CNAP property
Date: Wed, 29 Dec 2010 00:40:59 -0200
Message-ID: <1293590462-3516-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4332498661337490896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-settings.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index b6c3924..aea4991 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -870,7 +870,7 @@ static DBusMessage *generate_get_properties_reply(struc=
t ofono_call_settings *cs
 	ofono_dbus_dict_append(&dict, "CallingLinePresentation",
 				DBUS_TYPE_STRING, &str);
 =

-	str =3D cnap_status_to_string(cs->clip);
+	str =3D cnap_status_to_string(cs->cnap);
 	ofono_dbus_dict_append(&dict, "CallingNamePresentation",
 				DBUS_TYPE_STRING, &str);
 =

-- =

1.7.3.4


--===============4332498661337490896==--

