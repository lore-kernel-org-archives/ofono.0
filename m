Content-Type: multipart/mixed; boundary="===============2200348085264084300=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: cdma-connman: how to save credentials
Date: Mon, 08 Aug 2011 10:19:12 +0200
Message-ID: <4E3F9C00.30606@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2200348085264084300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Marcel,

As suggested by Marcel over ConnMan mailing list, I would like to save =

CDMA modem credentials like it is done for GSM modem contexts.
However, for GSM modem we use IMSI to save the contexts. So I could use =

CDMA Modem Serial to save but if we put different SIM into the same =

modem, we will load wrong credentials.

If this solution is good for you anyway, should I:

         1) modifiy the query_serial_cb() like this:

static void query_serial_cb(const struct ofono_error *error,
                  const char *serial, void *user)
  {
      struct ofono_devinfo *info =3D user;
+    struct ofono_atom *cdma_atom;
+    struct ofono_cdma_connman *cm;
      DBusConnection *conn =3D ofono_dbus_get_connection();
      const char *path =3D __ofono_atom_get_path(info->atom);

      if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
          return;

+    cdma_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(info->ato=
m),
+                        OFONO_ATOM_TYPE_CDMA_CONNMAN);
+
+    if (cdma_atom !=3D NULL) {
+        cm =3D __ofono_atom_get_data(cdma_atom);
+        ofono_cdma_connman_load_credentials(cm, serial);    // similar =

to gprs_load_settings()
+    }
+

     info->serial =3D g_strdup(serial);

     ofono_dbus_signal_property_changed(conn, path,
                         OFONO_MODEM_INTERFACE,
                         "Serial", DBUS_TYPE_STRING,
&info->serial);
}

     or 2) Implement a devinfo API to return serial, like the IMSI is =

returned by SIM atom?
             Thus, I would have gprs-like implementation.

Thanks for your help.

Kind regards,
Guillaume

--===============2200348085264084300==--

