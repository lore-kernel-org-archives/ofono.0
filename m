Content-Type: multipart/mixed; boundary="===============8229060430440485830=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] udev: fixes for detection of non-USB modems
Date: Tue, 12 Sep 2017 12:28:59 -0500
Message-ID: <bf5623a6-fdd7-a5e7-2f75-47db6eddaacb@gmail.com>
In-Reply-To: <20170912081120.29364-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8229060430440485830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/12/2017 03:11 AM, Jonas Bonn wrote:
> This patch fixes up some fallout from the merging of the udev and udevng
> modules.
> =

> i)  The 'serial' modems in question are not necessarily serial modems at
> all; for example, the N900 ISI modems appear as network devices and don't
> have a devnode.  This patch relaxes the requirement that a devnode exist.
> =

> ii)  The modem driver was being set to 'legacy', which is a remnant of
> an earlier approach to merging these modules.  The driver needs to be
> properly set to the value of the OFONO_DRIVER property in order for the
> setup function to be found.
> =

> iii)  The serial modem's private data was being added to the modem
> structure incorrectly...
> =

> In particular point iii) above shows that there is essentially nobody
> using these devices which makes modifications in this area tricky.
> ---
>   plugins/udevng.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis


--===============8229060430440485830==--

