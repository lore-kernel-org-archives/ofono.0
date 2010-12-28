Content-Type: multipart/mixed; boundary="===============4697199447892685800=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: RE: [RFC PATCH 1/5 v2] cell-info: Atom for ECID info of neighb cells
Date: Tue, 28 Dec 2010 14:12:21 +0200
Message-ID: <1293538341.2803.7.camel@apaila-ThinkPad-T410>
In-Reply-To: <1A42CE6F5F474C41B63392A5F80372B231CD1334@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4697199447892685800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jun,

On Tue, 2010-12-28 at 18:00 +0800, ext Wei, Jun wrote:
> Hi Antti,
> =

> >+static GSList *g_drivers =3D NULL;
> >+
> >+static GDBusMethodTable ci_methods[] =3D {
> >+	{ "GetProperties",	"",	"a{sv}aa{sv}",	ci_get_cells },
> >+	{ }
> +};
> +
> =

> Do we need to add 'G_DBUS_METHOD_FLAG_ASYNC' after ci_get_cells? =


Yes, we need. Already noticed it myself while testing :). I'll post the
next version of the patch soon which contains all sort of fixes plus
refactoring. =


> =

> >+static DBusMessage *ci_get_cells(DBusConnection *conn, DBusMessage *msg,
> >+					void *data)
> >+{
> >+	struct ofono_cell_info *ci =3D data;
> >+	DBG("");
> >+
> >+	ci->pending =3D dbus_message_ref(msg);
> >+	ci->driver->query(ci, ofono_cell_info_query_cb, ci->driver_data);
> =

> The 3rd parameter should be 'ci' instead of 'ci->driver_data', right?

Well, the first parameter is already 'ci', so maybe repetition is not
needed. The third parameter is kind of useless here anyway.

Thanks for the comments.

Best Regards,
  Antti


--===============4697199447892685800==--

