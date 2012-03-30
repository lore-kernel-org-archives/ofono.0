Content-Type: multipart/mixed; boundary="===============4633600904776600557=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ussd: Fix crash with long ussd string
Date: Fri, 30 Mar 2012 01:38:30 -0500
Message-ID: <4F7554E6.6000703@gmail.com>
In-Reply-To: <1333113396-1158-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4633600904776600557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 03/30/2012 08:16 AM, Nicolas Bertrand wrote:
> Some ZTE modem convert USSD string into UCS2 without respecting
> the limitation of 160 bytes. So cut off the string if greater than
> this limit
> ---
>  drivers/atmodem/ussd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
> index 443251a..bdee2d9 100644
> --- a/drivers/atmodem/ussd.c
> +++ b/drivers/atmodem/ussd.c
> @@ -158,7 +158,7 @@ static void cusd_parse(GAtResult *result, struct ofon=
o_ussd *ussd)
>  =

>  	case SMS_CHARSET_8BIT:
>  	case SMS_CHARSET_UCS2:
> -		msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);
> +		msg_ptr =3D decode_hex_own_buf(content, 320, &msg_len, 0, msg);
>  		break;
>  	}
>  =


This isn't really the problem.  From the logs it seems that the ZTE
modem is sending us plain-text data that is hex-encoded in UCS2.

e.g.:

ofonod[1051]: Modem: < \r\n+CUSD:
1,"006D006F0062006900630061007200740065000A0056006F007400720065002000630072=
006500640069007400200065007300740020006500700075006900730065002E000A0050006=
F0075007200200063006F006E00730065007200760065007200200076006F00740072006500=
20006E0075006D00650072006F00200030003600340035003300310032003100310038000A0=
0700065006E00730065007A0020006100200072006500630068006100720067006500720020=
006100760061006E00740020006C0065002000320031002F00300037002F00310032000A003=
1003D005200650063006800610072006700650072000A0032003D004D0065006E0075000A00=
33003D00410069006400650020002000200020",72\r\n

-> 006D, 006F, 0062, 0069, 0063, 0061, 0072, 0074, 0065 ...
    m     o     b    i     c     a     r     t     e    ...

Regards,
-Denis

--===============4633600904776600557==--

