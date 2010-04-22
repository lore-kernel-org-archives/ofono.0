Content-Type: multipart/mixed; boundary="===============5453719261317640273=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] ppp: implement MRU option
Date: Thu, 22 Apr 2010 13:51:17 -0700
Message-ID: <20100422135117.6f1f6090@kcaccard-MOBL3>
In-Reply-To: <201004221551.26311.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5453719261317640273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Apr 2010 15:51:26 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Kristen,
> =

> > On Thu, 22 Apr 2010 15:16:58 -0500
> > =

> > Denis Kenzior <denkenz@gmail.com> wrote:
> > > Hi Kristen,
> > >
> > > > @@ -80,7 +88,7 @@ static gboolean ppp_net_callback(GIOChannel *chan=
nel,
> > > >  GIOCondition cond,
> > > >
> > > >  	if (cond & G_IO_IN) {
> > > >  		/* leave space to add PPP protocol field */
> > > > -		status =3D g_io_channel_read_chars(channel, buf + 2, MAX_PACKET,
> > > > +		status =3D g_io_channel_read_chars(channel, buf + 2, net->mtu,
> > > >  				&bytes_read, &error);
> > > >  		if (bytes_read > 0) {
> > > >  			ppp->proto =3D htons(PPP_IP_PROTO);
> > >
> > > So I actually have a concern here.  Quoting RFC 1332 Section 2.1:
> > > "Exactly one IP packet is encapsulated in the Information field of PPP
> > >    Data Link Layer frames where the Protocol field indicates type hex
> > >    0021 (Internet Protocol)."
> > >
> > > However, you're not changing the physical MTU of the TUN/TAP interfac=
e,
> > > so in effect you are mangling the packets that are larger than net->m=
tu. =

> > > These packets will most likely simply be discarded leading to lots of
> > > fun.
> > =

> > We can add an ioctl to change the MTU during ppp_net_set_mtu(), which
> > should hopefully resolve this.
> > =

> =

> Yep, my thinking as well.  Can you send a patch?
> =

> Thanks,
> -Denis

yes, will do.

--===============5453719261317640273==--

