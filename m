Content-Type: multipart/mixed; boundary="===============4399038770598023173=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: [PATCH] Add air interface flash validation in CDMA voice call
Date: Fri, 19 Aug 2011 05:46:58 +0000
Message-ID: <0E7E5CACD8E9F248AA009C292CC772A075C80B@ALA-MBA.corp.ad.wrs.com>
In-Reply-To: <4E4D6173.7030302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4399038770598023173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +	/* flash string is empty, it is allowed */
> > +	if (str =3D=3D NULL)
> > +		return TRUE;
> =

> NULL strings are not valid here, they can't be sent over D-Bus.  Please
> omit this check.
> =


I will remove it.

> >  	if (vc->driver->send_flash =3D=3D NULL)
> >  		return __ofono_error_not_implemented(msg);
> >
> > +	if (vc->status =3D=3D CDMA_CALL_STATUS_DISCONNECTED)
> > +		return __ofono_error_failed(msg);
> > +
> =

> Just to double check, can a flash be sent during
> dialing/alerting/incoming stage?
> =


During dialing state, the flash should be ignored.

There is no alerting state used in CDMA voice call. It doesn't distinguish
alerting state and connected state.

There are two situations for incoming stage:
 (1) only one ringing call, the flash should be ignored
 (2) there is a waiting call. send flash will switch the calls.

To make it clearer, I will specified the valid states.

Please have a look the previous two patches relative call waiting and call
status notify. It is required to check call waiting status here. It depends=
 on
those patches.

Thanks!

Caiwen

--===============4399038770598023173==--

