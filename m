Content-Type: multipart/mixed; boundary="===============9134426536410098909=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Sat, 15 Jan 2011 02:30:10 +0100
Message-ID: <1295055010.3873.155.camel@aeonflux>
In-Reply-To: <201101141642.01738.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9134426536410098909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > Yes, that is how our previous UIs have done it, and I guess our UX
> > > designers like it in the future too.
> > =

> > I would advise the UI against using the name from the context
> > information and better using the one from the network registration
> > instead.
> =

> Well that would make sense... Therefore the operators don't do it ;-)
> =

> For instance my provider shows as "Elisa" in the network registration but=
 the =

> access points are expected to be shown as "Elisa Internet" and "Elisa MMS=
 WAP" =

> if I recall correctly.
> =

> It only makes sense to have this data in the provisioning plugin. It woul=
d be =

> silly to have to provision just the names in a different component.

just to make this clear, oFono takes care of potential operator renames
and displays them accordingly, but the provision names would stay the
same.

So if Elisa renames themselves into "Gwendula", the context names would
still say "Elisa Internet" etc. Has anybody thought about this part?

Regards

Marcel



--===============9134426536410098909==--

