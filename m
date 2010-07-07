Content-Type: multipart/mixed; boundary="===============6578938358323345418=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 07/23] introduce DECLARE_SMS_ADDR_STR()
Date: Wed, 07 Jul 2010 16:28:17 -0700
Message-ID: <1278545297.2327.133.camel@localhost.localdomain>
In-Reply-To: <4C350593.8000302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6578938358323345418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-07-07 at 15:54 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > +enum { SMS_ADDR_STR_SIZE =3D 25 };
> > +#define DECLARE_SMS_ADDR_STR(a) char a[SMS_ADDR_STR_SIZE]
> > +
> >  gboolean sms_decode_address_field(const unsigned char *pdu, int len,
> >  					int *offset, gboolean sc,
> >  					struct sms_address *out);
> =

> Sounds fine to me, but can we get rid of the enum declaration? simply
> char a[25] seems to be enough.  Might want to add a comment explaining
> why it is 25.  Namely that sms address is encoded into 12 bytes, stored
> in hex format and space for a null.

Ack, will do.





--===============6578938358323345418==--

