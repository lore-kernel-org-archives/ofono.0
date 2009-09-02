Content-Type: multipart/mixed; boundary="===============4909167916039533463=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: GPRS support for Ofono
Date: Wed, 02 Sep 2009 10:51:33 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C96800356B@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1251896518.1266.100.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4909167916039533463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > > I am still not seeing the point in what suspended will do for us and
> > > the UI. And that Maemo 5 exposed such a state in the UI is not an =

> > > argument to keep doing it. I asked this before, what are we suppose t=
o =

> > > be doing when we get signaled suspended?
> >
> > User, as well as intelligent (connectivity-aware) applications, need to
> > know about this so that they understand why "Internet" is momentarily
> > broken. It's as simple as that.

+1

> > Oh we could also use the network device carrier flag, and then use
> > Netlink (and we probably should do that too), but we all know how =

> > horrible Netlink is from userland.
> =

> Using IFF_RUNNING and IFF_LOWER_UP sounds more reasonable then some
> suspended state.

IF_OPER_DORMANT seems a more accurate reflection of the state.

Cheers,
Waldo

--===============4909167916039533463==--

