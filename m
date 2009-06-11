Content-Type: multipart/mixed; boundary="===============6205768697139735949=="
MIME-Version: 1.0
From: Jan Luebbe <jluebbe@lasnet.de>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 16:04:38 +0200
Message-ID: <1244729078.5792.187.camel@polaris>
In-Reply-To: <1244720815.27363.10.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6205768697139735949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-06-11 at 13:46 +0200, Marcel Holtmann wrote:
> Hi Denis,
> =

> > The attributes are really only for informational purposes only.  The
> > user would not base his decision on the mcc/mnc, but on the operator
> > name.  =

> > =

> > So before we start changing the D-Bus APIs, we need to answer these
> > two questions:
> >   - Can a country/administrative domain have both 001 and 01 MNCs such
> > that the use of string for the MNC is actually necessary.
> >   - What does the user find easier to use, a string or a short?
> =

> I wasn't aware of this and so it might be better to just expose these as
> an operator id string. So we might not even split into MCC/MNC at all
> since it is meaning less anyway.

This is probably the way to go...

> That said, we do want some exposure of these values since it is an easy
> way to determine geo location help and switch timezones etc. However I
> am now thinking that me might just add a Country property and do the
> proper translation inside oFono. Since we mostly care about these ones
> most.

While inferring the country from MCC sounds nice, there are some corner
cases where is causes problems:

Digicel Bermuda uses 310/38 (or 310/038?), 310 is the US MCC:
http://dougtoombs.com/2008/07/23/bermuda-the-iphone-and-att-beware-the-data=
-roaming/

Montenegro used MCC 220 (Serbia) before it switched to MCC 297.

Wikipedia has a list:
http://en.wikipedia.org/wiki/Mobile_Network_Code

If you plan to ship such a list with ofono, maybe
http://git.freesmartphone.org/?p=3Dframework.git;a=3Dblob;f=3Detc/freesmart=
phone/ogsmd/networks.tab
can be useful for you. OTOH, Nokia probably has a better list.

Jan


--===============6205768697139735949==--

