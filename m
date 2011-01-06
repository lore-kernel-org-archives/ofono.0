Content-Type: multipart/mixed; boundary="===============5052362085463941220=="
MIME-Version: 1.0
From: Wei, Jun <jun.wei@intel.com>
Subject: RE: [PATCH 3/5 v2] Cell-info: Atom for obtaining ECID info of cells
Date: Thu, 06 Jan 2011 20:35:36 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B231D84E3F@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1294151819-3300-4-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5052362085463941220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti, =


>-----Original Message-----
>Subject: [PATCH 3/5 v2] Cell-info: Atom for obtaining ECID info of cells
>
>+static int append_utra_neigh_cell_data(DBusMessageIter *iter,
>+		struct cell_measured_results *cmr)
>+{
>
>
>+
>+		if (cmr->rscp !=3D OFONO_CI_FIELD_RSCP_UNDEFINED)
>+			ofono_dbus_dict_append(iter,
>+					"CPICH-RSCP",
>+					DBUS_TYPE_INT16,
>+					&cmr->rscp);
>+

The type for RSCP should be "DBUS_TYPE_BYTE"



Regards,

Wei, Jun
Jun.wei(a)intel.com


--===============5052362085463941220==--

