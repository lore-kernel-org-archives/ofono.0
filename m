Content-Type: multipart/mixed; boundary="===============1215233223373746196=="
MIME-Version: 1.0
From: Wei, Jun <jun.wei@intel.com>
Subject: RE: [RFC PATCH 1/5 v2] cell-info: Atom for ECID info of neighb cells
Date: Tue, 28 Dec 2010 18:00:22 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B231CD1334@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1293010539-9524-2-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1215233223373746196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

>+static GSList *g_drivers =3D NULL;
>+
>+static GDBusMethodTable ci_methods[] =3D {
>+	{ "GetProperties",	"",	"a{sv}aa{sv}",	ci_get_cells },
>+	{ }
+};
+

Do we need to add 'G_DBUS_METHOD_FLAG_ASYNC' after ci_get_cells? =



>+static DBusMessage *ci_get_cells(DBusConnection *conn, DBusMessage *msg,
>+					void *data)
>+{
>+	struct ofono_cell_info *ci =3D data;
>+	DBG("");
>+
>+	ci->pending =3D dbus_message_ref(msg);
>+	ci->driver->query(ci, ofono_cell_info_query_cb, ci->driver_data);

The 3rd parameter should be 'ci' instead of 'ci->driver_data', right?



Regards,
Wei, Jun =E9=9F=A6=E5=B3=BB
Email: jun.wei(a)intel.com

--===============1215233223373746196==--

