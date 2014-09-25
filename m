Content-Type: multipart/mixed; boundary="===============6339631868490800039=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to get network interface working
Date: Thu, 25 Sep 2014 10:07:12 -0500
Message-ID: <54242FA0.3000007@gmail.com>
In-Reply-To: <CAH4ZQwuJGbSsHY2d_XxCQODGroH=Uq-bPOxT0inuz4LwfuMwAA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6339631868490800039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 09/25/2014 09:58 AM, Enrico Sau wrote:
> Hi Denis,
> thanx for the quick answer.
> This is the log including AT commands:
>
> ofonod[14630]: Modem: < AT+CGDATA=3D"PPP",1\r
> ofonod[14630]: Modem: < \r\nCONNECT\r\n
> ofonod[14630]: drivers/atmodem/gprs-context.c[176]:at_cgdata_cb() ok 1
> ofonod[14630]: drivers/atmodem/gprs-context.c[141]:setup_ppp()
> ofonod[14630]: Aux: < \r\n
> ofonod[14630]: Aux: < +CRSM: 106,130\r\n\r\nOK\r\n
> ofonod[14630]: Aux: > AT+CRSM=3D192,28613\r
> ofonod[14630]: Aux: < \r\n
> ofonod[14630]: Aux: < +CRSM: 106,130\r\n\r\nOK\r\n
> ofonod[14630]: src/simfs.c[446]:sim_fs_op_read_block() bufoff: 0,
> seekoff: 39, toread: 17
> ofonod[14630]: Aux: > AT+CRSM=3D192,28437\r
> ofonod[14630]: Aux: < \r\n
> ofonod[14630]: Aux: < +CRSM: 106,130\r\n\r\nOK\r\n
> ofonod[14630]: Aux: < \r\n
> ofonod[14630]: Aux: < +CIEV: rssi,1\r\n
> ofonod[14630]: src/network.c[1536]:ofono_netreg_strength_notify()
> strength 20
> ofonod[14630]: drivers/atmodem/gprs-context.c[86]:ppp_connect()
> ofonod[14630]: IP: 109.113.70.48
> ofonod[14630]: DNS: 83.224.70.77, 83.224.70.54
> ofonod[14630]: src/gprs.c[889]:pri_activate_callback() 0x859e348

oFono side looks good to me.

> NetworkManager[876]: <info> (/he910_0): IPv4 static configuration:
> NetworkManager[876]: <info> (/he910_0): device state change: prepare ->
> failed (reason 'ip-config-unavailable') [40 120 5]

Figure out why this happens.  Are you running everything as root?

Regards,
-Denis

--===============6339631868490800039==--

