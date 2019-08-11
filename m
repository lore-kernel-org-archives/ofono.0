Content-Type: multipart/mixed; boundary="===============0536740519511264139=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Sun, 11 Aug 2019 21:57:01 +1000
Message-ID: <CAA=hcWSK7P6DP=pjCg7pdUDC=Cz9=PNWJ7_u02ZJrw8u8UG3Nw@mail.gmail.com>
In-Reply-To: <CAA=hcWRNYQMPm2FJFmGNEvzFeUV2SC+rLvp+miB78qTY6LXwcQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0536740519511264139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

More observation about the network connection, the device has two
network interfaces, WiFi mlan0 and LTE wwan0, I think that problem is
likely in connman, not in ofono as in some stage, the wifi IP address
lost as well, but it came back.

Why connmand contently calling to add and to del both mlan0 and wwan0
in route table? How does the connman manage the route, dhcp to refresh
interface IP address?

Aug 11 08:01:43 connmand[204]: mlan0 {add} route 0.0.0.0 gw
192.168.0.1 scope 0 <UNIVERSE>
Aug 11 08:01:44 connmand[204]: wwan0 {del} route 212.227.81.55 gw
10.116.108.45 scope 0 <UNIVERSE>
Aug 11 08:01:44 connmand[204]: mlan0 {del} route 0.0.0.0 gw
192.168.0.1 scope 0 <UNIVERSE>
Aug 11 08:01:44 connmand[204]: wwan0 {add} route 0.0.0.0 gw
10.116.108.45 scope 0 <UNIVERSE>
Aug 11 08:01:44 connmand[204]: wwan0 {add} route 212.227.81.55 gw
10.116.108.45 scope 0 <UNIVERSE>
Aug 11 08:01:45 connmand[204]: wwan0 {del} route 212.227.81.55 gw
10.116.108.45 scope 0 <UNIVERSE>
Aug 11 08:02:48 connmand[204]: wwan0 {RX} 1365 packets 142181 bytes
Aug 11 08:02:49 connmand[204]: wwan0 {TX} 1672 packets 221297 bytes
Aug 11 08:02:49 connmand[204]: wwan0 {update} flags 4240 <DOWN>
Aug 11 08:02:49 connmand[204]: wwan0 {newlink} index 4 address
00:00:00:00:00:00 mtu 1500
Aug 11 08:02:49 connmand[204]: wwan0 {newlink} index 4 operstate 2 <DOWN>
Aug 11 08:02:49 connmand[204]: (null) {del} address 10.116.108.44/29 label =
wwan0
Aug 11 08:02:49 connmand[204]: wwan0 {dellink} index 4 operstate 2 <DOWN>
Aug 11 08:02:49 connmand[204]: (null) {RX} 1365 packets 142181 bytes
Aug 11 08:02:49 connmand[204]: (null) {TX} 1672 packets 221297 bytes
Aug 11 08:02:49 connmand[204]: (null) {remove} index 4
Aug 11 08:02:49 connmand[204]: Remove interface (null) [ cellular ]
Aug 11 08:02:49 connmand[204]: Removing default gateway route failed
(No such device)

Thank you.

Kind regards,

- jh


On 8/9/19, JH <jupiter.hce@gmail.com> wrote:
> Hi Giacinto,
>
> I tried to run openwrt on my embedded system, it got netifd daemon to
> manage the LTE modem, and started udhcpc -p /var/run/udhcpc-wwan0.pid
> -s /lib/netifd, that problem has gone away.
>
> Now I am really worried, if the problem of lost LTE network IP address
> only happened in connman not in openwrt, it will unlikely be the carry
> network and modem issues, could it be because that openwrt used udhcpc
> to refresh the IP address? How does the connman manage the dhcp for
> LTE IP address?
>
> Thank you.
>
> Kind regards,
>
> - jh
>
> On 8/9/19, Giacinto Cifelli <gciofono@gmail.com> wrote:
>>> > Ask uBlox how to capture a protocol stack trace, and if it is feasible
>>> > for your application, do it and have it analyzed by uBlox.
>>> >
>>> > Are you on GSM, on LTE catM or on LTE NB-IOT when this happens? On
>>> > which network operator and country?
>>>
>>> It is LTE Cat-M1, the operator is Telstra in Australia. I will be very
>>> interested in finding out what is going on.
>>
>> you need stack traces.
>> Most likely the chipset you are using is the MDM9205, so the trace will
>> be
>> QXDM.
>>
>>>
>>> Thank you.
>>>
>>> Kind regards,
>>>
>>> - jupiter
>>
>> BR,
>> Giacinto
>>
>

--===============0536740519511264139==--

