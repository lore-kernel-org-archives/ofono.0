Content-Type: multipart/mixed; boundary="===============6050343340159639461=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stkutil: mask the DCS value to keep only the intersting
 bits
Date: Wed, 17 Nov 2010 08:13:49 -0600
Message-ID: <4CE3E31D.9050800@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D401881353DCF1D@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6050343340159639461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 11/15/2010 08:17 AM, Lucas, GuillaumeX wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
> =

> For SIM tool kit only the bits 2 and 3 are interesting
> for the DCS value. The others ones sould be masked. The
> masking is necessary because some SIM car set the
> upper bits to 1.
> ---
>  src/stkutil.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index cdd66bd..a54dd02 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -78,7 +78,7 @@ static char *decode_text(unsigned char dcs, int len, co=
nst unsigned char *data)
>  {
>  	char *utf8;
>  =

> -	switch (dcs) {
> +	switch (dcs & 0x06) {

Do you mean to bitwise and with 0xc here?  Otherwise you break the UCS2
case.  Also do any SIMs use the '1111' Coding Bits Entry entry from
23.038 Section 4?  If so, then we need to use sms_dcs_decode to retrieve
the character set.

>  	case 0x00:
>  	{
>  		long written;

Regards,
-Denis

--===============6050343340159639461==--

