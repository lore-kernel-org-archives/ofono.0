Content-Type: multipart/mixed; boundary="===============6096540053590771475=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 8/8] gprs: fix bearer dbus signal interface
Date: Mon, 13 Aug 2012 15:23:58 +0200
Message-ID: <1344864238-23203-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6096540053590771475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to the documentation the data bearer property should be
located on interface org.ofono.ConnectionManager.
---
 src/gprs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0286e52..e379f7b 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2266,7 +2266,7 @@ void ofono_gprs_bearer_notify(struct ofono_gprs *gprs=
, int bearer)
 	path =3D __ofono_atom_get_path(gprs->atom);
 	value =3D packet_bearer_to_string(bearer);
 	ofono_dbus_signal_property_changed(conn, path,
-					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					OFONO_CONNECTION_MANAGER_INTERFACE,
 					"Bearer", DBUS_TYPE_STRING, &value);
 }
 =

-- =

1.7.7.6


--
Scanned by MailScanner.


--===============6096540053590771475==--

