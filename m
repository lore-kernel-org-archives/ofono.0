Content-Type: multipart/mixed; boundary="===============3750670921239477680=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] cdmaconnman: fix the set_property Activate reply
Date: Sun, 24 Jul 2011 08:05:01 +0200
Message-ID: <1311487501-488-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3750670921239477680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index b52f9c1..0c9013b 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -472,7 +472,7 @@ static DBusMessage *cdma_connman_set_property(DBusConne=
ction *conn,
 		else
 			cm->driver->deactivate(cm, deactivate_callback, cm);
 =

-		return dbus_message_new_method_return(msg);
+		return NULL;
 	} else if (!strcmp(property, "Username")) {
 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
 			return __ofono_error_invalid_args(msg);
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============3750670921239477680==--

