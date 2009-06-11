Content-Type: multipart/mixed; boundary="===============1516828219340070451=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 13:46:55 +0200
Message-ID: <1244720815.27363.10.camel@violet>
In-Reply-To: <9b1cac640906101041g48ca9b8dv1b9f50d0c843381d@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1516828219340070451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> I understand perfectly.  But remember, oFono does not expose the user
> to such details.  Manual registration is accomplished by using
> Register() method (with no arguments) of the NetworkOperator
> interface.  The internal storage representation is never exposed.
> Thus it doesn't matter whether internally it is a string or short,
> etc.
> =

> The attributes are really only for informational purposes only.  The
> user would not base his decision on the mcc/mnc, but on the operator
> name.  =

> =

> So before we start changing the D-Bus APIs, we need to answer these
> two questions:
>   - Can a country/administrative domain have both 001 and 01 MNCs such
> that the use of string for the MNC is actually necessary.
>   - What does the user find easier to use, a string or a short?

I wasn't aware of this and so it might be better to just expose these as
an operator id string. So we might not even split into MCC/MNC at all
since it is meaning less anyway.

That said, we do want some exposure of these values since it is an easy
way to determine geo location help and switch timezones etc. However I
am now thinking that me might just add a Country property and do the
proper translation inside oFono. Since we mostly care about these ones
most.

Regards

Marcel



--===============1516828219340070451==--

