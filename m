Content-Type: multipart/mixed; boundary="===============8791761017567479018=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] stkutil: Add SMS-PP Data Download envelope builder
Date: Thu, 03 Jun 2010 10:32:52 -0500
Message-ID: <201006031032.52536.denkenz@gmail.com>
In-Reply-To: <AANLkTinJEYXi-lWywNEcwo8xufnysHxJEGQL1e4hgeDU@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8791761017567479018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > - When SMS is delivered, it is delivered in tpdu form, e.g. sc_address +
> > deliver pdu.  To obtain the sc_address, we need to decode the deliver
> > tpdu anyway.
> > - Before we know this is an SMS-PP download, we must check the dcs / pi=
d.
> >  In order to check those, we must again decode the tpdu.
> > - SMS sc_address can actually be non-numeric.  In that case the SMS-PP
> > download should simply be dropped.
> =

> This means we have to decode the PDU, but re-encoding it is still an
> overhead having access to the TPDU.

Fair enough, I don't really feel strongly either way.  However, encoding is =

quite fast and we have to re-encode the sc_address in a different format an=
yway =

because of the weird sc_addr encoding rules.

> =

> > - Consistency with Send SMS proactive command.
> =

> Ok, makes sense.

One thing that comes to mind is that we might have to modify sms_encode() w=
ith =

the capability to skip encoding the sc_address field.  Otherwise our pdu wi=
ll =

have some extra crap in the beginning.

> =

> >> +
> >> +/* Returns TRUE on success */
> >> +ofono_bool_t stk_pdu_from_envelope(const struct stk_envelope *envelop=
e,
> >> +                                     unsigned char *pdu, unsigned int
> >> size, +                                     unsigned char **out_pdu,
> >> +                                     unsigned int *out_size);
> >
> > This part just looks ugly.  Can't we hide the details of char buf[512]
> > somewhere inside stk_pdu_from_envelope?
> =

> By that do you mean using a static buffer?  I'll send a patch for
> that.  I prefer a static buffer for the PDUs but thought you had
> argued against it :)

Don't recall :)  I think in this case it is ok, or you can always make the =

function re-entrant safe by making the buf argument in/out.

e.g.

char buf[512];
char *out =3D buf;

func(foo, bar, &out);

Regards,
-Denis

--===============8791761017567479018==--

