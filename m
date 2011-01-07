Content-Type: multipart/mixed; boundary="===============0050987882494723526=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: RE: [PATCH 3/5 v2] Cell-info: Atom for obtaining ECID info of cells
Date: Fri, 07 Jan 2011 08:46:22 +0200
Message-ID: <1294382782.2602.13.camel@apaila-ThinkPad-T410>
In-Reply-To: <1A42CE6F5F474C41B63392A5F80372B231D84E3F@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0050987882494723526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jun,

On Thu, 2011-01-06 at 20:35 +0800, ext Wei, Jun wrote:
> Hi Antti, =

> =

> >-----Original Message-----
> >Subject: [PATCH 3/5 v2] Cell-info: Atom for obtaining ECID info of cells
> >
> >+static int append_utra_neigh_cell_data(DBusMessageIter *iter,
> >+		struct cell_measured_results *cmr)
> >+{
> >
> >
> >+
> >+		if (cmr->rscp !=3D OFONO_CI_FIELD_RSCP_UNDEFINED)
> >+			ofono_dbus_dict_append(iter,
> >+					"CPICH-RSCP",
> >+					DBUS_TYPE_INT16,
> >+					&cmr->rscp);
> >+
> =

> The type for RSCP should be "DBUS_TYPE_BYTE"


RSCP may obtain negative values whereas DBUS_TYPE_BYTE is a
type code marking an 8-bit _unsigned_ integer.

-Antti


--===============0050987882494723526==--

