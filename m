Content-Type: multipart/mixed; boundary="===============5999635117456588261=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RERESEND] [PATCH 2/2] Update the network documentation
Date: Thu, 25 Nov 2010 09:57:23 +0200
Message-ID: <201011250957.23896.remi.denis-courmont@nokia.com>
In-Reply-To: <4CEC35E3.8010601@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5999635117456588261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 23 November 2010 23:45:07 ext Denis Kenzior, you wrote:
> On 11/23/2010 01:20 PM, Aki Niemi wrote:
> > Hi,
> > =

> > 2010/11/23 Denis Kenzior <denkenz@gmail.com>:
> >> In fact we were planning to report the current bearer on the
> >> ConnectionManager interface once we figured out the vendor commands th=
at
> >> can actually report this information.
> > =

> > Do you mean HSDPA/HSUPA channel allocations, or the tech reported by
> > CGREG? Because these can differ. For example, a Finnish operator's
> > cells will not indicate HS*PA support, but HSDPA channel will
> > nevertheless get allocated when data is moving. This is why for
> > instance the N900 will show a 3G icon when idle, but switch to 3.5G
> > when actively receiving data.
> =

> I mean the actual bearer being used.  The 27.007 equivalent would be
> +CPSB, not what is reported by +CGREG.

I think we need both. I assume we should have two properties in the =

ConnectionManager, one for each.

But then it is questionable why the NetworkRegistration should exhibit =

anything other than 'gsm', 'umts' and 'lte' (and whatever-CDMA).

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============5999635117456588261==--

