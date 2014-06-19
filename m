Content-Type: multipart/mixed; boundary="===============6134870511493825769=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: Re: [PATCH 1/3] gatchat: implement PAP authentication
Date: Thu, 19 Jun 2014 11:41:15 +0200
Message-ID: <20140619094115.GC33006@rincewind.trouble.is>
In-Reply-To: <53A210C0.9020501@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6134870511493825769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2014-06-18 17:20:48 (-0500), Denis Kenzior <denkenz@gmail.com> wrote:
> On 06/17/2014 04:57 PM, Philip Paeps wrote:
> > +	/*
> > +	 * RFC 1334 2.2.1:
> > +	 * The Identifier field MUST be changed each time an
> > +	 * Authenticate-Request packet is issued.
> > +	 */
> > +	authreq =3D (struct pap_header *)&pap->authreq->info;
> > +	authreq->identifier =3D g_random_int() % G_MAXUINT8;
> =

> Is this sufficient to fulfill the requirement stated in the comment?  It
> would be highly unlikely, but the identifier might still be repeated,
> no?  Would it be easier to simply use a counter?

This should be sufficient.  The RFC says it must be changed each time we
send a packet.  It doesn't say anything about never repeating values.
On the other hand, both CMU pppd and BSD ppp use a counter.  I have
changed this in my updated patch.

Philip

-- =

Philip Paeps
Senior Reality Engineer
Ministry of Information

--===============6134870511493825769==--

