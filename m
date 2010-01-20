Content-Type: multipart/mixed; boundary="===============2375331935133432638=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] add quirk for cid and lac handling for Huawei
Date: Wed, 20 Jan 2010 10:26:23 -0600
Message-ID: <201001201026.23764.denkenz@gmail.com>
In-Reply-To: <4B54B6B1.3080306@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2375331935133432638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

> Attached is my attempt at that. The actual quirk is in
> drivers/atmodem/atutil.c, which means I needed to change the
> at_util_parse_reg*() definitions. Let me know if my approach seems wrong
> -- this was the first time I've even looked at ofono code, and I can't
> claim to understand it fully.

I'm actually fine with this approach.  Patch has been applied.  I did a tri=
vial =

style fix afterward to keep the line length less than 80 characters.

> =

> The huawei plugin seems to use OFONO_VENDOR_QUALCOMM_MSM for sms...
> Should that be updated so OFONO_VENDOR_HUAWEI (which I added) hits the
> same quirk(s) or do Huawei and Qualcomm really have something in common?

Huawei uses Qualcomm chips in their devices and thus share the same 'quirks=
'.  =

I expect the vendor.h quirks to get refined over time anyway, so for now it=
 is =

fine to leave it the way it is.

Thanks,
-Denis

--===============2375331935133432638==--

