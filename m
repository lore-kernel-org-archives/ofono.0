Content-Type: multipart/mixed; boundary="===============3264985762701150777=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: using ofono location service with PLS8-E failed
Date: Thu, 27 Sep 2018 10:13:54 -0500
Message-ID: <331b978d-ef2d-5c29-bb37-0bd05e236e64@gmail.com>
In-Reply-To: <9903b312-562f-fb87-34c6-b0b3d27cd138@phytec.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3264985762701150777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi J=C3=B6rg,

On 09/27/2018 08:57 AM, J=C3=B6rg Rebenstorf wrote:
> =

> I tried to use the org.ofono.LocationReporting service to get NMEA data.
> =


<snip>

> =

> Is there some working example available how to use the location service
> (with this modem) or any recommendations what to check for?
> =

> Is it possible that ...
> AT^SGPSC=3D"NMEA/Output","on"
> ... is simply missing in the AT command sequence?
> =


This driver was added in commit c0c7c92a8.  The commit comment states =

that it was only tested on the Gemalto PHS8-E.  It could very well be =

that the PLS8-E requires a different kind of magic.

I don't have either device, so can't really test this scenario.  Perhaps =

Vincent (original author) or Giacinto might have more information.

Regards,
-Denis

--===============3264985762701150777==--

