Content-Type: multipart/mixed; boundary="===============1751825874841336967=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to get network interface working
Date: Thu, 25 Sep 2014 09:23:37 -0500
Message-ID: <54242569.5020509@gmail.com>
In-Reply-To: <CAH4ZQwuQegM1GDOKRW=awg6WK1X64R3SjcEi9GZ0en3-Oq1VCA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1751825874841336967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 09/25/2014 09:25 AM, Enrico Sau wrote:
> Dear all,
> I'm using oFono 1.15 on Ubuntu 14.4 with telit UE910 modem.
> OFono is able to detect the modem but for some reason The network
> interface never gets an IP resulting in an immediate detach from the
> network.
> Here is the syslog:
>
> ofonod[2841]:
> drivers/atmodem/gprs-context.c[247]:at_gprs_activate_primary() cid 1
> ofonod[2841]: drivers/atmodem/gprs-context.c[200]:at_cgdcont_cb() ok 1
> ofonod[2841]: drivers/atmodem/gprs-context.c[176]:at_cgdata_cb() ok 1
> ofonod[2841]: drivers/atmodem/gprs-context.c[141]:setup_ppp()
> ofonod[2841]: drivers/atmodem/gprs-context.c[86]:ppp_connect()
> ofonod[2841]: IP: 37.182.26.98
> ofonod[2841]: DNS: 83.224.70.54, 83.224.70.77
> ofonod[2841]: src/gprs.c[889]:pri_activate_callback() 0x8609670

Everything looks fine on the oFono end...

You can add AT command debugging to see what might be going wrong.  See =

HACKING for details.

> NetworkManager[937]: <info> (/he910_0): IPv4 static configuration:
> NetworkManager[937]: <info> (/he910_0): device state change: prepare ->
> failed (reason 'ip-config-unavailable') [40 120 5]
> NetworkManager[937]: <warn> Activation (/he910_0) failed for connection
> '/222016503456238/context1'
> NetworkManager[937]:    SCPlugin-Ifupdown: devices added (path:
> /sys/devices/virtual/net/ppp0, iface: ppp0)
> NetworkManager[937]:    SCPlugin-Ifupdown: device added (path:
> /sys/devices/virtual/net/ppp0, iface: ppp0): no ifupdown configuration
> found.
> NetworkManager[937]: <warn> /sys/devices/virtual/net/ppp0: couldn't
> determine device driver; ignoring...
> NetworkManager[937]: <info> (/he910_0): device state change: failed ->
> disconnected (reason 'none') [120 30 0]
> NetworkManager[937]: <info> (/he910_0): deactivating device (reason
> 'none') [0]

Sounds like NetworkManager is confused...

> ofonod[2841]: src/gprs.c[1286]:pri_set_property() deactivate_primary
> ofonod[2841]:
> drivers/atmodem/gprs-context.c[339]:at_gprs_deactivate_primary() cid 1
> NetworkManager[937]:    SCPlugin-Ifupdown: devices removed (path:
> /sys/devices/virtual/net/ppp0, iface: ppp0)
> ofonod[2841]: plugins/udevng.c[976]:remove_device()
> /sys/devices/virtual/net/ppp0
> ofonod[2841]: drivers/atmodem/gprs-context.c[109]:ppp_disconnect() Reason=
: 6
>

Regards,
-Denis


--===============1751825874841336967==--

