Content-Type: multipart/mixed; boundary="===============9203629682349275431=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: [PATCH] reopen data device once if open data device failed
Date: Wed, 11 May 2011 05:49:29 +0000
Message-ID: <0E7E5CACD8E9F248AA009C292CC772A057B610@ALA-MBA.corp.ad.wrs.com>
In-Reply-To: <4DCA0662.6090101@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9203629682349275431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >> I think this is wrong as well. We should remove that context no
> matter
> >> if online of offline, but off course you do not wanna create a new
> GPRS
> >> context if you are actually offline, right?
> >>
> >
> > If the device is offline, the GPRS context atom has been released
> when set
> > the device to offline. That's another issue has been fixed by Martin
> (Need
> > set data->gc to NULL, because it has been release if device is
> offline).
> >
> > It will create a new GPRS context when the device is switch to
> online(in
> > huawei_post_online()), so don't create it here if it is offline.
> >
> >
> =

> I suggest you migrate the huawei modem driver to create the gprs atom
> in
> post_sim state instead of post_online.  It will solve many of the
> issues
> you're trying to solve.
> =


Thanks your suggestion.

Yes, It can help that we don't need to care whether gprs atom and gprs cont=
ext atom =

be repeatedly created. But if do this at post_sim state, it will beak the r=
ule
that only enable the atom when it is available. At post_sim state GPRS is s=
till unavailable.
In addition, all other plug-ins do this at post_online, only do this in Hua=
wei plug-in,
it may impact the consistency of the codes.

Best regards
Caiwen





--===============9203629682349275431==--

