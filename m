Content-Type: multipart/mixed; boundary="===============5579197311489263335=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Thu, 01 Aug 2019 20:16:55 +0200
Message-ID: <CAKSBH7HcH-0KMEF5M+b7FmB1ysy_L=HGYuV0GZ89y56v6tgo0Q@mail.gmail.com>
In-Reply-To: <CAA=hcWTCuYH9YxGa_mFc7N75XE66bbf0FXY+2ZtngmhOrOYM1g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5579197311489263335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi jupiter,

On Thu, Aug 1, 2019 at 1:01 PM JH <jupiter.hce@gmail.com> wrote:
>
> Hi,
>
> I have a device connect to 4G LTE, it was in good connection status on
> start up, after a couple of hours, it dropped LTE connection, the
> ofono did not show any errors, but connman had lots of error messages
> at following, could any one help to explain what could be the problem?
> Could it be ofono issue or connman issue? The device has small flash
> size which don't have enough space to debug tools.
>
> # journalctl -u ofono
> -- Logs begin at Fri 2019-07-05 05:07:42 UTC, end at Thu 2019-08-01 10:42=
:49 UT-
> Aug 01 07:49:47 systemd[1]: Starting Telephony service...
> Aug 01 07:49:48 ofonod[188]: oFono version 1.24
> Aug 01 07:49:48 systemd[1]: Started Telephony service.
> Aug 01 07:49:53 ofonod[188]: Interface org.ofono.AllowedAccessPoints not t
> Aug 01 07:49:57 ofonod[188]: LTE attach IP type: 0
> Aug 01 08:09:39 ofonod[188]: LTE attach IP type: 0
>
> # journalctl -u connman
> .........
> Aug 01 08:09:39 connmand[181]: Skipping disconnect of
> /ubloxqmi_0/context1, network is connecting.
> Aug 01 08:09:39 connmand[181]: ipconfig state 2 ipconfig method 1
> Aug 01 08:09:39 connmand[181]: wwan0 {RX} 45 packets 7963 bytes
> Aug 01 08:09:39 connmand[181]: wwan0 {TX} 56 packets 4730 bytes
> Aug 01 08:09:39 connmand[181]: wwan0 {update} flags 69841 <UP,RUNNING,LOW=
ER_UP>
> Aug 01 08:09:39 connmand[181]: wwan0 {newlink} index 4 address
> 00:00:00:00:00:00 mtu 1500
> Aug 01 08:09:39 connmand[181]: wwan0 {newlink} index 4 operstate 0 <UNKNO=
WN>
> Aug 01 08:09:39 connmand[181]: ipconfig state 3 ipconfig method 1
> Aug 01 08:09:39 connmand[181]: wwan0 {add} address 10.114.23.145/30
> label wwan0 family 2
> Aug 01 08:09:39 connmand[181]: wwan0 {add} route 10.114.23.144 gw
> 0.0.0.0 scope 253 <LINK>
> Aug 01 08:09:39 connmand[181]: wwan0 {add} route 10.114.23.146 gw
> 0.0.0.0 scope 253 <LINK>
> Aug 01 08:09:39 connmand[181]: wwan0 {add} route 10.4.58.204 gw
> 10.114.23.146 scope 0 <UNIVERSE>
> Aug 01 08:09:39 connmand[181]: wwan0 {add} route 0.0.0.0 gw
> 10.114.23.146 scope 0 <UNIVERSE>
> Aug 01 08:09:45 connmand[181]: Online check failed for 0xa71cf8 Telstra
> Aug 01 09:34:10 connmand[181]: wwan0 {RX} 140 packets 15185 bytes
> Aug 01 09:34:10 connmand[181]: wwan0 {TX} 158 packets 12440 bytes
> Aug 01 09:34:10 connmand[181]: wwan0 {update} flags 4240 <DOWN>
> Aug 01 09:34:11 connmand[181]: wwan0 {newlink} index 4 address
> 00:00:00:00:00:00 mtu 1500
> Aug 01 09:34:11 connmand[181]: wwan0 {newlink} index 4 operstate 2 <DOWN>
> Aug 01 09:34:11 connmand[181]: Time request for server 10.114.23.146
> failed (101/Network is unreachable)
> Aug 01 09:34:11 connmand[181]: wwan0 {del} address 10.114.23.145/30 label=
 wwan0
> Aug 01 09:34:11 connmand[181]: Skipping disconnect of
> /ubloxqmi_0/context1, network is connecting.
> Aug 01 09:34:11 connmand[181]: ipconfig state 2 ipconfig method 1
> Aug 01 09:34:11 connmand[181]: Failed to change property:
> /ubloxqmi_0/context1 org.ofono.ConnectionContext.Active:
> org.ofono.Error.Failed Operation failed
> Aug 01 09:34:11 connmand[181]: ipconfig state 7 ipconfig method 1
> Aug 01 09:34:11 connmand[181]: Skipping disconnect of
> /ubloxqmi_0/context1, network is connecting.
> Aug 01 09:34:11 connmand[181]: ipconfig state 2 ipconfig method 1
> Aug 01 09:34:11 connmand[181]: Failed to change property:
> /ubloxqmi_0/context1 org.ofono.ConnectionContext.Active:
> org.ofono.Error.Failed Operation failed
> Aug 01 09:34:11 connmand[181]: ipconfig state 7 ipconfig method 1
> Aug 01 09:34:11 connmand[181]: Skipping disconnect of
> /ubloxqmi_0/context1, network is connecting.
> Aug 01 09:34:11 connmand[181]: ipconfig state 2 ipconfig method 1
> Aug 01 09:34:11 connmand[181]: Failed to change property:
> /ubloxqmi_0/context1 org.ofono.ConnectionContext.Active:
> org.ofono.Error.Failed Operation failed

most likely the network dropped the context without signaling.
What kind of modem is it? And would you know also the chipset?

>
> -------
>
> Thank you.
>
> Kind regards,
>
> - jupiter
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

Best regards,
Giacinto

--===============5579197311489263335==--

