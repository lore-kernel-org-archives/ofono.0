Content-Type: multipart/mixed; boundary="===============6644292182235662099=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ublox: network-registration: Check ureg for tech also for
 L2 modems
Date: Wed, 25 Sep 2019 20:56:33 -0500
Message-ID: <4e28a514-f1e5-5af5-cf79-70ea85663555@gmail.com>
In-Reply-To: <20190924161112.32561-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6644292182235662099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 9/24/19 11:11 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> It seems like the CREG reporting from the L2 modems are quite
> buggy. An example for a L210 where CREG reports UTRAN while
> COPS and UREG reports LTE. A manual poll also indicates LTE.
> =

> I also found that the technology mapping was incorrect,
> probably confused with enum packet_bearer.
> =

> A commented log showing where CREG is not trustable:
> =

> UREG indicates LTE
> 21:59:29 : < \r\n+UREG: 7\r\n
> 21:59:29 : < \r\n+CIEV: 9,2\r\n
> 21:59:29 : < \r\n+CGEV: NW MODIFY 1,0,0\r\n
> 21:59:31 : < \r\n+CIEV: 2,2\r\n
> 21:59:39 : < \r\n+CIEV: 2,3\r\n
> 21:59:44 : < \r\n+CIEV: 2,2\r\n
> 22:01:38 : < \r\n+CIEV: 2,3\r\n
> 22:01:43 : < \r\n+CIEV: 2,2\r\n
> =

> A CREG indicating UTRAN with HSDPA and HSUPA
> 22:29:39 : < \r\n+CREG: 5,"0000","00000000",6\r\n
> 22:29:39 : > AT\r
> 22:29:39 : < \r\nOK\r\n
> 22:29:39 : > AT+COPS=3D3,2\r
> 22:29:39 : < \r\n+CIEV: 9,2\r\n
> 22:29:39 : < \r\nOK\r\n
> 22:29:39 : > AT+COPS?\r
> =

> An immediate cops indicating LTE
> 22:29:39 : < \r\n+COPS: 0,2,"24007",7\r\n
> 22:29:39 : < \r\nOK\r\n
> 22:29:39 : > AT+CSQ\r
> 22:29:39 : < \r\n+CIEV: 2,4\r\n
> 22:29:39 : < \r\n+CSQ: 26,4\r\n
> 22:29:39 : < \r\nOK\r\n
> 22:29:39 : > AT+CGATT=3D1\r
> 22:29:39 : < \r\nOK\r\n
> 22:29:39 : > AT+COPS=3D3,0\r
> 22:29:39 : < \r\nOK\r\n
> 22:29:39 : > AT+COPS?\r
> =

> Another cops also indicates LTE
> 22:29:39 : < \r\n+COPS: 0,0,"Tele2",7\r\n <- 7: LTE
> 22:29:39 : < \r\nOK\r\n
> 22:29:39 : > AT+CGREG?\r
> =

> CGREG indicates unknown -> normal on LTE
> 22:29:39 : < \r\n+CGREG: 2,4\r\n
> 22:29:39 : < \r\nOK\r\n
> 22:29:44 : < \r\n+CIEV: 9,2\r\n
> 22:29:46 : < \r\n+CIEV: 2,2\r\n
> 22:56:23 : < \r\n+CIEV: 2,3\r\n
> 22:56:28 : < \r\n+CIEV: 2,2\r\n
> 22:59:40 : < \r\n+CIEV: 2,4\r\n
> =

> Manual poll shows we are running LTE
> at+creg?
> +CREG: 2,5,"2AFC","01DB0206",7
> =

> OK
> ---
>   drivers/ubloxmodem/network-registration.c | 34 +++++++++++++++++++----
>   1 file changed, 28 insertions(+), 6 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============6644292182235662099==--

