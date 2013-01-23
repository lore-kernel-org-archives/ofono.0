Content-Type: multipart/mixed; boundary="===============5164996226316106704=="
MIME-Version: 1.0
From: Kling, Andreas <Andreas.Kling@peiker.de>
Subject: AW: [PATCH 05/10] hfp_hf_bluez5: Handle NewConnection from BlueZ
Date: Wed, 23 Jan 2013 13:03:34 +0100
Message-ID: <sig.9735c4f085.B3F251FD87EC894A88C2221EEEBDF54807096F7F55@Exchange>
In-Reply-To: <1358891005-24688-6-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5164996226316106704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>Parse the essential arguments in the message, in this case only the
>file descriptor, and register the modem if it is not already
>registered. This is necessary because in some cases, we may receive a
>NewConnection call, and the SDP process is still taking place.
>---
> plugins/hfp_hf_bluez5.c | 47 ++++++++++++++++++++++++++++++++++++++++++++=
---
> 1 file changed, 44 insertions(+), 3 deletions(-)
>
>diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
>index 74ca570..39853e3 100644
>--- a/plugins/hfp_hf_bluez5.c
>+++ b/plugins/hfp_hf_bluez5.c
>@@ -24,6 +24,8 @@
> #endif
>
> #include <errno.h>
>+#include <unistd.h>
>+
> #include <glib.h>
>
> #include <gdbus.h>
>@@ -124,11 +126,50 @@ static struct ofono_modem_driver hfp_driver =3D {
> static DBusMessage *profile_new_connection(DBusConnection *conn,
>                                        DBusMessage *msg, void *user_data)
> {
>+       struct ofono_modem *modem;
>+       DBusMessageIter iter;
>+       GDBusProxy *proxy;
>+       DBusMessageIter entry;
>+       const char *device, *alias;
>+       int fd;
>+
>        DBG("Profile handler NewConnection");
>
>-       return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
>-                                       ".NotImplemented",
>-                                       "Implementation not provided");
>+       if (dbus_message_iter_init(msg, &entry) =3D=3D FALSE)
>+               goto error;
>+
>+       if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_OBJECT_P=
ATH)
>+               goto error;
>+
>+       dbus_message_iter_get_basic(&entry, &device);
>+
>+       proxy =3D g_hash_table_lookup(devices_proxies, device);
>+       if (proxy =3D=3D NULL)
>+               goto error;
>+
>+       if (g_dbus_proxy_get_property(proxy, "Alias", &iter) =3D=3D FALSE)
>+               alias =3D "unknown";
>+       else
>+               dbus_message_iter_get_basic(&iter, &alias);
>+
>+       dbus_message_iter_next(&entry);
>+       if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
>+               goto error;
>+
>+       dbus_message_iter_get_basic(&entry, &fd);
>+       if (fd < 0)
>+               goto error;
>+
>+       modem =3D modem_register(device, alias);
>+       if (modem =3D=3D NULL)
>+               goto error;
>+
>+       return NULL;
>+
>+error:
>+       close(fd);
>+       return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
>+                                       "Invalid arguments in method call"=
);
> }
>
> static DBusMessage *profile_release(DBusConnection *conn,
>--
>1.8.1.1

fd is closed always on error, even if uninitialized

I assume returning NULL is ok here if nothing went wrong?
I'm not familiar with plain dbus API, just using glib gdbus, there I would =
expect to create an answer to the call.

kind regards

andy

--===============5164996226316106704==--

