Content-Type: multipart/mixed; boundary="===============6966722457951714589=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: [PATCH] sim: use mask for check of sim file status
Date: Fri, 05 Nov 2010 16:03:27 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188135388C01@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4CD411E1.502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6966722457951714589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I've tested your changes and all is ok :)

Regards,
Guillaume

-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: Friday, November 05, 2010 3:17 PM
To: ofono(a)ofono.org
Cc: Lucas, GuillaumeX
Subject: Re: [PATCH] sim: use mask for check of sim file status

Hi Guillaume,

On 11/05/2010 08:05 AM, Lucas, GuillaumeX wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
> =

> Is' the first bit of the sim file status who indicates if a file
> is valid or not. So a mask must be used to check this.
> ---
>  src/sim.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Good catch on these.  Patch has been applied, thanks.  I also applied a
couple of extra fixes that add more sanity checking to BDN & FDN.
Please check that my fixes didn't break anything else :)

Regards,
-Denis
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============6966722457951714589==--

