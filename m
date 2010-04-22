Content-Type: multipart/mixed; boundary="===============7432949441361444839=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: implement MRU option
Date: Thu, 22 Apr 2010 15:51:26 -0500
Message-ID: <201004221551.26311.denkenz@gmail.com>
In-Reply-To: <20100422134007.0c9b2cf6@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7432949441361444839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> On Thu, 22 Apr 2010 15:16:58 -0500
> =

> Denis Kenzior <denkenz@gmail.com> wrote:
> > Hi Kristen,
> >
> > > @@ -80,7 +88,7 @@ static gboolean ppp_net_callback(GIOChannel *channe=
l,
> > >  GIOCondition cond,
> > >
> > >  	if (cond & G_IO_IN) {
> > >  		/* leave space to add PPP protocol field */
> > > -		status =3D g_io_channel_read_chars(channel, buf + 2, MAX_PACKET,
> > > +		status =3D g_io_channel_read_chars(channel, buf + 2, net->mtu,
> > >  				&bytes_read, &error);
> > >  		if (bytes_read > 0) {
> > >  			ppp->proto =3D htons(PPP_IP_PROTO);
> >
> > So I actually have a concern here.  Quoting RFC 1332 Section 2.1:
> > "Exactly one IP packet is encapsulated in the Information field of PPP
> >    Data Link Layer frames where the Protocol field indicates type hex
> >    0021 (Internet Protocol)."
> >
> > However, you're not changing the physical MTU of the TUN/TAP interface,
> > so in effect you are mangling the packets that are larger than net->mtu=
. =

> > These packets will most likely simply be discarded leading to lots of
> > fun.
> =

> We can add an ioctl to change the MTU during ppp_net_set_mtu(), which
> should hopefully resolve this.
> =


Yep, my thinking as well.  Can you send a patch?

Thanks,
-Denis

--===============7432949441361444839==--

