Content-Type: multipart/mixed; boundary="===============1616855705885219776=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: use mask for check of sim file status
Date: Fri, 05 Nov 2010 09:17:05 -0500
Message-ID: <4CD411E1.502@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D40188135388B53@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1616855705885219776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

--===============1616855705885219776==--

