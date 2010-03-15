Content-Type: multipart/mixed; boundary="===============4816603169507338414=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [patch 1/6] Add PPP protocol support with HDLC framing
Date: Mon, 15 Mar 2010 15:04:08 -0700
Message-ID: <20100315150408.45104132@kcaccard-MOBL3>
In-Reply-To: <201003112017.50004.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4816603169507338414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Mar 2010 20:17:49 -0600
Denis Kenzior <denkenz@gmail.com> wrote:


> =

> > +			} else {
> > +				/* store last flag character */
> > +				link->buffer[link->index++] =3D data[pos];
> > +				frame =3D ppp_decode(link, link->buffer);
> =

> This function along with ppp_decode do almost exactly the same thing as =

> gsm0710_advanced_extract_frame in gsm0710.c.  They both do HDLC frame =

> decoding, and the only difference I can see is in the fcs table.  Can we =

> combine these somehow?

Possibly - although in theory in addition to the escaping that you do
in the gsm0710 code, we have to support a negotiated accm (which you see
I've not yet implemented here).  We also in theory should support PFC and
ACFC (which the one modem I tested with required, otherwise it refused to
ack my Configure-Request).  I think there may eventually be enough =

differences to keep these separate.


--===============4816603169507338414==--

