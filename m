Content-Type: multipart/mixed; boundary="===============0580523606533287932=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [PATCH v4 2/2] stemodem: Update gprs-context to use rtnl to
 create/remove interfaces.
Date: Fri, 12 Nov 2010 15:30:41 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C105791945C0C6B8@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <1289453825.3266.38.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0580523606533287932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.
 =

> Can you please not try to squeeze such change in the same patch. Just
> have a separate one that does this change.
...
> The more I looked through the rest of this patch, the more I thought
> you need to split this patch into a cleanup and caif_rtnl usage patch.

Yes, I have broken this into three patches.
It's a bit hard to find the exactly what to put where, and
tear apart what is already squashed. But have a look and
see what you think.

> =

> So I realized now that you are using ifindex as input for
> caif_rtnl_delete_interface, now I am questioning why there is a result
> parameter in the callback for caif_rtnl_create_interface.

OK, agree - done.

> Why are we having this in the first place. CAIF network interfaces are
> point-to-point, right? In that case you should just leave this NULL.

Yes - agree. PtP link should not report GW.

> Please use '\0' instead of just 0. You might need to fix this at other
> places as well.

OK, done at least here..

> > +static void rtnl_callback(int result, gpointer user_data,
> > +		char *ifname, int ifindex)
> > +{
> > +	struct conn_info *conn =3D user_data;
> > +
> > +	strncpy(conn->interface, ifname, sizeof(conn->interface));
> > +	conn->ifindex =3D ifindex;
> > +
> > +	if (result =3D=3D 0)
> > +		conn->created =3D TRUE;
> > +	else {
> > +		conn->created =3D FALSE;
> > +		DBG("Could not create CAIF Interface");
> > +	}
> > +}
> =

> So here is the think. This makes no sense. Either you get an error and
> ifname and index are not valid or you succeed.
> =

> So this should be something like
> =

> 	if (ifname < 0) {
> 		connman_error(...)
> 		return;
> 	}
OK, I've done something similar.


Regards,
Sjur





--===============0580523606533287932==--

