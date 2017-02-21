Content-Type: multipart/mixed; boundary="===============3141720608039721397=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Confusion about ublox toby-L2 IP configuration
Date: Mon, 20 Feb 2017 19:40:53 -0600
Message-ID: <cde247d3-3e63-a29c-be92-4067d96e69e9@gmail.com>
In-Reply-To: <CADB9fJGeP9CZn2Bt_t0zjEunxZKXvjzT9vaNK6fQop0xAenALw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3141720608039721397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 02/20/2017 09:26 AM, Eric Grunt wrote:
> I originally posted this to the connman list
> and I was asked to take over the topic to ofono list.
> https://lists.01.org/pipermail/connman/2017-January/021440.html
>
> In interaction with ofono 1.18, connman 1.33 configures IPs for ublox
> toby-L2 like this:

Dragos was the one who contributed most of the ublox support.  He might =

be able to help.  I don't have a ublox device to diagnose this problem.

>
> /*
>  +UIPADDR: 1,"usb0:0","10.230.77.23","255.255.255.255","",""
>  +CGCONTRDP: 1,0,"event.vodafone.de
> ","10.230.77.232.255.255.255.255","10.230.77.232","139.7.30.125","139.7.3=
0.126","0.0.0.0","0.0.0.0",0
> */
>

drivers/ubloxmodem/gprs-context.c uses CGCONTRDP parameters, and then =

runs a +UIPADDR afterwards.  Have you traced the logic in that file to =

see what is happening?  It explicitly mentions Toby L2 & various =

behaviors on different firmware.

Have you tried newer firmware?

> wwan0     Link encap:Ethernet  HWaddr b6:90:aa:61:a0:79
>           inet addr:10.230.77.232  Bcast:10.230.77.232  Mask:255.255.255.=
255
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:6 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:384 (384.0 B)  TX bytes:908 (908.0 B)
>
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use
> Iface
> 0.0.0.0         10.230.77.232   0.0.0.0         UG    0      0        0
> wwan0
> 10.230.77.232   0.0.0.0         255.255.255.255 UH    0      0        0
> wwan0
> 139.7.30.125    10.230.77.232   255.255.255.255 UGH   0      0        0
> wwan0
> 139.7.30.126    10.230.77.232   255.255.255.255 UGH   0      0        0
> wwan0
>
> So it basically configures itself as gateway for everything
> and also writes 139.7.30.125 and 139.7.30.126 to the routing table,
> alltough those are supposed to be used for dns resolution.
> With the configuration above, neither pinging the ublox router
> (192.168.1.1)  nor the outside internet (8.8.8.8) is working (100% packet
> loss)

Routing table info is being handled by connman.  Can you tell me the =

output of test/monitor-ofono when you activate the context?  E.g. what =

are the contents of the ConnectionContext.Settings ?

Also, an AT command trace would be helpful.  See HACKING, 'OFONO_AT_DEBUG'.

Regards,
-Denis

--===============3141720608039721397==--

