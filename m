Content-Type: multipart/mixed; boundary="===============0637081328753690031=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: GPRS support for Ofono
Date: Wed, 02 Sep 2009 13:40:39 -0700
Message-ID: <1251924039.1266.107.camel@localhost.localdomain>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C96800356B@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0637081328753690031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > > > I am still not seeing the point in what suspended will do for us and
> > > > the UI. And that Maemo 5 exposed such a state in the UI is not an =

> > > > argument to keep doing it. I asked this before, what are we suppose=
 to =

> > > > be doing when we get signaled suspended?
> > >
> > > User, as well as intelligent (connectivity-aware) applications, need =
to
> > > know about this so that they understand why "Internet" is momentarily
> > > broken. It's as simple as that.
> =

> +1

they need to know if they can do something useful with this information.
If not, then this state is just pointless. However the D-Bus API is the
wrong location for this detail.

> > > Oh we could also use the network device carrier flag, and then use
> > > Netlink (and we probably should do that too), but we all know how =

> > > horrible Netlink is from userland.
> > =

> > Using IFF_RUNNING and IFF_LOWER_UP sounds more reasonable then some
> > suspended state.
> =

> IF_OPER_DORMANT seems a more accurate reflection of the state.

Yep. That sounds good. We don't use that in ConnMan right now, but that
can be fixed of course. I still need to figure out what we are suppose
to do when this gets signaled to us.

Regards

Marcel



--===============0637081328753690031==--

