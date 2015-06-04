Content-Type: multipart/mixed; boundary="===============3979603517636023549=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems provisioning APN from SIMs
Date: Thu, 04 Jun 2015 17:16:14 -0500
Message-ID: <5570CE2E.4020305@gmail.com>
In-Reply-To: <5570CA31.6070002@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3979603517636023549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

 > As I come to investigate this, I find I am concerned about using the
> Service Provider Name as I can't see any registry for those names, it's
> free text for display purposes, so I assume it is at least possible it
> might change without warning,
> whereas there does seem to be a registry for MCC/MNC (e.g.
> http://www.mcc-mnc.com/)

In theory MCC/MNC should be unique even for MVNOs.  But some have not =

followed that properly.  SPN is free-form, but it probably doesn't =

change all that often.  The provisioning database would have to be =

updated frequently.

If you know you will only need a subset of particular providers, it =

might be easier to develop your own provisioning db.

>
> I am thinking it may be preferable to use the registered IIN number from
> the ICCID - http://www.controlf.net/iccid/
>
> This seems a more controlled way of providing the uniqueness needed to
> me and presumably it's easy enough to read the ICCID out, if it's not
> already being read out.
>

I don't recall that any provisioning (proprietary or otherwise) database =

used ICCID as an identifier.  Not saying it won't work, so feel free to =

investigate what is possible.

Regards,
-Denis


--===============3979603517636023549==--

