Content-Type: multipart/mixed; boundary="===============6102553979507643130=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 03/16] include: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:05 +0200
Message-ID: <1294829538-3893-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6102553979507643130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 12768f6..f541eaf 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -65,7 +65,7 @@ extern "C" {
 					DBUS_TYPE_VARIANT_AS_STRING \
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
 =

-DBusConnection *ofono_dbus_get_connection();
+DBusConnection *ofono_dbus_get_connection(void);
 =

 void ofono_dbus_dict_append(DBusMessageIter *dict, const char *key, int ty=
pe,
 				void *value);
-- =

1.7.0.4


--===============6102553979507643130==--

