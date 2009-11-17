Content-Type: multipart/mixed; boundary="===============1441497639828069487=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 1/5] ignore the NULL dict entry
Date: Tue, 17 Nov 2009 23:49:09 +0800
Message-ID: <1258472953-2922-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1441497639828069487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index b74481f..942294e 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -134,6 +134,9 @@ static void append_dict_variant(DBusMessageIter *iter, =
int type, void *val)
 						typesig, &array);
 =

 	for (i =3D 0; val_array[i]; i +=3D 2) {
+		if (val_array[i + 1] =3D=3D NULL)
+			continue;
+
 		dbus_message_iter_open_container(&array, DBUS_TYPE_DICT_ENTRY,
 							NULL, &entry);
 =

-- =

1.6.1.3


--===============1441497639828069487==--

