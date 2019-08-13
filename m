Content-Type: multipart/mixed; boundary="===============0071511886316583283=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Unsalble cellular connection
Date: Tue, 13 Aug 2019 17:00:25 +0200
Message-ID: <e698981e-c1c9-d782-7af1-ea1af4d89dfc@norrbonn.se>
In-Reply-To: <CAA=hcWSVcULFW4jo5q9RsxW4igozgM99oJN6KoZ8UaSLdLhD7g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0071511886316583283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CC: ofono mailing list.

Please don't drop the mailing list from the conversation.


On 13/08/2019 13:51, JH wrote:
> Hi Jonas,
> =

> On 8/13/19, Jonas Bonn <jonas@norrbonn.se> wrote:
>> Hi JH,
>>> Aug 01 08:09:39 connmand[181]: wwan0 {add} route 0.0.0.0 gw
>>> 10.114.23.146 scope 0 <UNIVERSE>
>>> Aug 01 08:09:45 connmand[181]: Online check failed for 0xa71cf8 Telstra
> =

>> Online check failed... was the network connection ever working?
> =

> Yes, it usually in good LTE connection when power up, then it dropped
> connection in about 1 - 2 hours.
> =

>>> Aug 01 09:34:11 connmand[181]: Time request for server 10.114.23.146
>>> failed (101/Network is unreachable)
> =

>> Is this attempt to check the time server causing the modem to discover t=
hat the connection
>> isn't working?  Who sets the network interface DOWN here... the QMI Linu=
x driver?  Why
>>   doesn't the modem signal something on the QMI communication channel wh=
en this
>> happens... maybe it does but the message is just being silently ignored?
> =

> $ ping 10.114.23.146
> --- 10.114.23.146 ping statistics ---
> 5 packets transmitted, 0 packets received, 100% packet loss
> =

> Cannot reache that IP address??

That address is the gateway address for that link... there's unlikely a =

timeserver running there.  Why does connman think there's a timeserver =

there?

> =

>> There's very little traffic on the link... is the PDP context silently e=
xpiring due to inactivity?
>   > What happens if you ping something every minute or so when the link
> is active?
> =

> That because all traffic went to WiFi, the application is sending a
> message to Cloud every minitue, should that be better than to ping?

So you have no traffic over the LTE link?  How do you know that it goes =

down after 1-2 hours... maybe it went down after 5 minutes?

Cloud messages are as good as a ping... a packet's a packet.


> =

>>> Aug 01 09:34:11 connmand[181]: wwan0 {del} address 10.114.23.145/30 lab=
el wwan0
>>> Aug 01 09:34:11 connmand[181]: Skipping disconnect of
>>> /ubloxqmi_0/context1, network is connecting.
> =

>> Here I think ofono and connman just get out of sync because connman seem=
s to know that
>> the network is down while ofono doesn't...
> =

> Does that alude it is not the ofono caused link down?

The link is configured by connman, not ofono.  ofono just publishes the =

address details so that connman can set it up.

> =

>> Sure... there's not much to go on in the logs you've posted, just an
>> assertion that the LTE connection was silently dropped.  It would be
>> better if you could show the behaviour with more complete debug output:
>>
>> ofonod -d
>>
>> The issue could be (perhaps) that there's a QMI message that ofono
>> doesn't handle and is silently ignoring... dumping the QMI communication
>> might useful:
>>
>> OFONO_QMI_DEBUG=3D1 ofonod -d
> =

> Before running following commands, the LTE connection dropped, after
> running following commands, LTE connection came back, it is wired that
> the LTE is more stable than running by system service where
> ExecStart=3D/usr/sbin/ofonod -u", LTE connection has not been dropped
> for more than 6 hours, I'll run it over night and let you know if the
> connection will be dropped or not. Why running OFONO_QMI_DEBUG=3D1
> ofonod -d makes it more stable? Can I say that LTE drop off is caused
> by the ofono?



> =

> # systemctl stop ofono
> # OFONO_QMI_DEBUG=3D1 ofonod -d
> # ip addr
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>      inet 127.0.0.1/8 scope host lo
>         valid_lft forever preferred_lft forever
>      inet6 ::1/128 scope host
>         valid_lft forever preferred_lft forever
> 2: sit0(a)NONE: <NOARP> mtu 1480 qdisc noop qlen 1000
>      link/sit 0.0.0.0 brd 0.0.0.0
> 3: mlan0: <BROADCAST,MULTICAST,UP,LOWER_UP8000> mtu 1500 qdisc mq qlen 10=
00
>      link/ether d4:ca:6e:64:e3:61 brd ff:ff:ff:ff:ff:ff
>      inet 192.168.0.101/24 brd 192.168.0.255 scope global mlan0
>         valid_lft forever preferred_lft forever
>      inet6 fe80::d6ca:6eff:fe64:e361/64 scope link
>         valid_lft forever preferred_lft forever
> 4: wwan0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc pfifo_=
fast q0
>      link/[65534]
>      inet 10.114.34.107/29 brd 10.114.34.111 scope global wwan0
>         valid_lft forever preferred_lft forever
> =

> The LTE connection came up with IP address:
> =

> wwan0     Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-0=
0-00-0
>            inet addr:10.114.34.107  P-t-P:10.114.34.107  Mask:255.255.255=
.248
>            UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
>            RX packets:253 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:348 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:28788 (28.1 KiB)  TX bytes:37777 (36.8 KiB)
> =

> =

> There is not much about the dump message:
> =

> # journalctl -u ofono
> -- Logs begin at Fri 2019-07-05 05:07:43 UTC, end at Tue 2019-08-13 09:15=
:10 UT-
> Aug 11 12:07:12 systemd[1]: Starting Telephony service...
> Aug 11 12:07:13 ofonod[189]: oFono version 1.24
> Aug 11 12:07:14 systemd[1]: Started Telephony service.
> Aug 11 12:07:19 ofonod[189]: Interface org.ofono.AllowedAccessPoints not t
> Aug 11 12:07:21 ofonod[189]: LTE attach IP type: 0
> Aug 12 06:30:19 ofonod[189]: LTE attach IP type: 0
> Aug 12 06:32:24 ofonod[189]: LTE attach IP type: 0
> Aug 12 06:33:28 ofonod[189]: LTE attach IP type: 0
> Aug 12 06:56:03 ofonod[189]: LTE attach IP type: 0
> Aug 12 06:56:06 ofonod[189]: LTE attach IP type: 0
> Aug 12 06:56:10 ofonod[189]: LTE attach IP type: 0
> Aug 13 08:49:09 ofonod[189]: Terminating
> Aug 13 08:49:09 systemd[1]: Stopping Telephony service...
> Aug 13 08:49:09 ofonod[189]: Exit
> Aug 13 08:49:09 systemd[1]: Stopped Telephony service.
> Aug 13 08:56:22 systemd[1]: Starting Telephony service...
> Aug 13 08:56:22 ofonod[3315]: oFono version 1.24
> Aug 13 08:56:22 ofonod[3315]: Unable to hop onto D-Bus: Name already in ue
> Aug 13 08:56:22 ofonod[3315]: Exit
> Aug 13 08:56:22 systemd[1]: Started Telephony service.
> Aug 13 08:57:29 systemd[1]: /lib/systemd/system/ofono.service:8: Executab"
> Aug 13 09:00:30 systemd[1]: Starting Telephony service...
> Aug 13 09:00:30 systemd[1]: Started Telephony service.
> =

>>>> # ofono/test/list-contexts
>>>> [ /ubloxqmi_0 ]
>>>>       [ /ubloxqmi_0/context1 ]
>>>>           Name =3D Internet
>>>>           Type =3D internet
>>>>           AuthenticationMethod =3D chap
>>>>           Settings =3D { Method=3Dstatic Gateway=3D10.116.103.22
>>>> Netmask=3D255.255.255.25}
>>
>> No Address?  No Interface?  Running ofono with debug output will
>> probably shed some light on what's going on here.
> =

> I think that could be because I only ran it once, if I ran
> list-contexts 4 times consecutively, every time it displayed different
> results included address and interface, is it the normal behaviour of
> list-contexts?

Sounds broken...???

> =

> # /usr/lib/ofono/test/list-contexts
> [ /ubloxqmi_0 ]
>      [ /ubloxqmi_0/context1 ]
>          AuthenticationMethod =3D chap
>          Active =3D 1
>          Protocol =3D ip
>          Username =3D
>          Name =3D Internet
>          Type =3D internet
>          IPv6.Settings =3D { }
>          Password =3D
>          AccessPointName =3D telstra.m2m
>          Settings =3D { Gateway=3D10.114.34.108 Method=3Dstatic
> Interface=3Dwwan0 Do UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500
> Metric:1
>            RX packets:253 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:348 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:28788 (28.1 KiB)  TX bytes:37777 (36.8 KiB)
> main}
> =

> # /usr/lib/ofono/test/list-contexts
> [ /ubloxqmi_0 ]
>      [ /ubloxqmi_0/context1 ]
>          AccessPointName =3D telstra.m2m
>          Protocol =3D ip
>          IPv6.Settings =3D { }
>          Active =3D 1
>          Name =3D Internet
>          Type =3D internet
>          Settings =3D { Method=3Dstatic Gateway=3D10.114.34.108 Netmask=
=3D255.255.255.24}
>          Password =3D
>          AuthenticationMethod =3D chap
>          Username =3D
> =

> # /usr/lib/ofono/test/list-contexts
> [ /ubloxqmi_0 ]
>      [ /ubloxqmi_0/context1 ]
>          Type =3D internet
>          AccessPointName =3D telstra.m2m
>          Settings =3D { Netmask=3D255.255.255.248 Interface=3Dwwan0 Addre=
ss=3D10.114.34.}
>          Name =3D Internet
>          Username =3D
>          Password =3D
>          Protocol =3D ip
>          Active =3D 1
>          IPv6.Settings =3D { }
>          AuthenticationMethod =3D chap
> =

>> static is correct.  ofono configures the local network interface
>> appropriately for the established context.
>>
>> Given that ofono isn't reporting either an address nor interface above,
>> I wonder what the network interface has been configured to.  What do 'ip
>> link' and 'ip addr' show?
> =

> Since it is running in good status, debug may not make sense, but I
> include here anyway:
> =

> # ip link
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: sit0(a)NONE: <NOARP> mtu 1480 qdisc noop qlen 1000
>      link/sit 0.0.0.0 brd 0.0.0.0
> 3: mlan0: <BROADCAST,MULTICAST,UP,LOWER_UP8000> mtu 1500 qdisc mq qlen 10=
00
>      link/ether d4:ca:6e:64:e3:61 brd ff:ff:ff:ff:ff:ff
> 4: wwan0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc pfifo_=
fast q0
>      link/[65534]
> =

> # ip addr
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>      inet 127.0.0.1/8 scope host lo
>         valid_lft forever preferred_lft forever
>      inet6 ::1/128 scope host
>         valid_lft forever preferred_lft forever
> 2: sit0(a)NONE: <NOARP> mtu 1480 qdisc noop qlen 1000
>      link/sit 0.0.0.0 brd 0.0.0.0
> 3: mlan0: <BROADCAST,MULTICAST,UP,LOWER_UP8000> mtu 1500 qdisc mq qlen 10=
00
>      link/ether d4:ca:6e:64:e3:61 brd ff:ff:ff:ff:ff:ff
>      inet 192.168.0.101/24 brd 192.168.0.255 scope global mlan0
>         valid_lft forever preferred_lft forever
>      inet6 fe80::d6ca:6eff:fe64:e361/64 scope link
>         valid_lft forever preferred_lft forever
> 4: wwan0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc pfifo_=
fast q0
>      link/[65534]
>      inet 10.114.34.107/29 brd 10.114.34.111 scope global wwan0
>         valid_lft forever preferred_lft forever
> =

> I'll send you debug information when it is in bad connection status.
> =

> Thank you all for you kind help.
> =

> Kind regards,
> =

> - jupiter
> =


/Jonas

--===============0071511886316583283==--

