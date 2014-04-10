Content-Type: multipart/mixed; boundary="===============4716636916495033761=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/4] Add subscriber number for handsfree
Date: Thu, 10 Apr 2014 10:07:17 -0500
Message-ID: <5346B3A5.3000907@gmail.com>
In-Reply-To: <1396945307-12195-1-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4716636916495033761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 04/08/2014 03:21 AM, Andrew Earl wrote:
> Hi Denis,
> =

> Here are the changes to add the subscriber number to the handsfree
> API.
> =

> Thanks,
> =

> Andrew
> =

> =

> Andrew Earl (4):
>   doc: Add subscriber number to handsfree-api
>   include: Add subscriber number to handsfree API
>   hfp: Add subscriber number to handsfree properties
>   hfp: Add CNUM query to handsfree interface for subscriber number
> =

>  doc/handsfree-api.txt        |   4 ++
>  drivers/hfpmodem/handsfree.c |  88 ++++++++++++++++++++++++++++++
>  include/handsfree.h          |   6 +++
>  src/handsfree.c              | 124 +++++++++++++++++++++++++++++++++++++=
++++--
>  4 files changed, 219 insertions(+), 3 deletions(-)
> =


I went ahead and applied all four patches.  I did reflow a couple of
functions and tweaked variable names after patch 3 & patch 4.  Please
let me know if I broke something.

Regards,
-Denis

--===============4716636916495033761==--

