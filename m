Content-Type: multipart/mixed; boundary="===============0840084524172651380=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] dbus: fix appending on dict for types other than string
Date: Tue, 04 Jan 2011 09:57:54 -0800
Message-ID: <1294163874.5852.102.camel@aeonflux>
In-Reply-To: <4D235E8D.8030404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0840084524172651380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>  =

> >>  		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> >>  						&(val_array[i + 0]));
> >> -		dbus_message_iter_append_basic(&entry, type,
> >> -						&(val_array[i + 1]));
> >> +		if (type =3D=3D DBUS_TYPE_STRING) {
> >> +			dbus_message_iter_append_basic(&entry, type,
> >> +							&(val_array[i + 1]));
> >> +		} else {
> >> +			dbus_message_iter_append_basic(&entry, type,
> >> +							val_array[i + 1]);
> >> +		}
> > =

> > this does looks a bit hackish. Can you put it into context please. It
> > might be that our call chain is wrong.
> > =

> =

> We only ever needed (and thus ever added) support for string:string
> dicts.  E.g. ones that could be g_strfreev-ed.  No other dicts were
> supported by this function.

so it is the g_strfreev part that makes this hackish. Fine by me then,
but we might need to comment on why string arrays in this case are
special.

Regards

Marcel



--===============0840084524172651380==--

