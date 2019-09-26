Content-Type: multipart/mixed; boundary="===============1464360491122162671=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: fix to populate activated gprs context ip
 settings
Date: Thu, 26 Sep 2019 16:37:28 -0500
Message-ID: <9d4e6f59-6546-832a-38e9-3ad071807cfc@gmail.com>
In-Reply-To: <9BCC1739A7EADA4790E1FFF4123FB3268BB655BE@BGSMSX101.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1464360491122162671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 9/26/19 6:50 AM, Borwankar, Antara wrote:
> Hi Dennis,
> =

> I am facing this issue because for xmm7mode we get default cid as 0.
> In at_cgdcont_read_cb when cids =3D l_uintset_new(activated_cid); is call=
ed
> It will create  a set with size zero hence the check in at_cgdcont_parse =
is failing.

Ah the infamous cid 0...

So the intent of that code was to create a uintset large enough to hold =

the last activated cid, which I guess was always > 0 for the modems tried.

With cid 0, I think what should be done is to always create the uinset =

using the new_from_range function.  So either always create one using =

new_from_range(0, 255) or if cid =3D=3D 0, use new_from_range(0, 0);

> Do you think this fix is fine?
> Should I put handling for cid 0 under vendor flag check.
> =


No, cid 0 is essentially standardized now.  It would be nice to be able =

to check whether cid 0 is supported or not up front though.

Regards,
-Denis

--===============1464360491122162671==--

