Content-Type: multipart/mixed; boundary="===============1603340690452366894=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS support for Ofono
Date: Tue, 01 Sep 2009 17:50:25 -0500
Message-ID: <200909011750.26044.denkenz@gmail.com>
In-Reply-To: <1251844960.1266.53.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1603340690452366894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > Service		org.ofono
> > Interface	org.ofono.DataConnectionManager
>
> I think this should be GPRSManager or something to clearly separate
> between GRPS connections and actual data connection,

Two reasons for this:
	- Purpose of DataConnectionManager is easier to understand for people new =
to =

GSM.  Whereas GPRSManager really doesn't tell them anything.  Everywhere el=
se =

we tend to use more easily understood terminology than what is used in the =

specifications.

	- GPRS is not easily Carmel-cased.  E.g. we'd have to name it GprsManager.

> > 		object RemoveContext()
> >
> > 			Removes a primary context.  All secondary contexts, if
> > 			any, associated with the primary context are also
> > 			removed.
>
> I assume this is void RemoveContext(object context)

You're absolutely correct.

> > Properties	array{object} PrimaryContexts [readonly]
> >
> > 			List of all primary contexts objects.
>
> Calling this just Contexts seems to more reasonable. See comment about
> interface name below.

That sounds fine to me.

> > Primary Data Context hierarchy
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Service		org.ofono
> > Interface	org.ofono.PrimaryDataContext
>
> I would prefer if we just call this GRPSContext and explain that this is
> for the primary context. The confusion between primary context and
> secondary context is some GSM specific non-sense.

Should we just simply name this 'Context' and name the secondary pdp contex=
t =

'SubContext'?

> > 		array{string} DomainNameServers [readonly, optional]
> >
> > 			Holds the list of domain name servers for this
> > 			context.
>
> What about the gateway value. In theory we can just route it to the
> interface, but if the device fakes a real Ethernet interface and the
> gateway is in a different subnet we need a proper host route first.

Yes, this one needs to be added.  Good catch.

Regards,
-Denis

--===============1603340690452366894==--

