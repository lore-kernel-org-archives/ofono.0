Content-Type: multipart/mixed; boundary="===============6136463329687809042=="
MIME-Version: 1.0
From: Christian Gagneraud <chris@techworks.ie>
Subject: [help] ofono + connman
Date: Mon, 27 Jun 2011 00:35:11 +0100
Message-ID: <4E07C22F.7070205@techworks.ie>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6136463329687809042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi there,

I'm trying to use ofono with connman on an embedded system.
I'm using the latest connman and ofono releases.

So far I'm able to bring up ppp0 with ofono, but not with connman:
$ connmand --version
0.75
$ ofonod --version
0.50
$ killall ofonod
$ killall connmand
[unplug modem]
$ rm -Rf /var/lib/ofono/*   # Avoid data persistence
$ rm -Rf /var/lib/connman/* # Avoid data persistence
$ ofonod -d -n &
[plug modem, wait a bit]
$ of-tests-enable-modem /huawei0
$ of-tests-online-modem
$ of-tests-set-roaming-allowed
$ of-tests-enable-gprs
Connecting modem /huawei0...
$ of-tests-create-internet-context internet web web
Found context /huawei0/context1
Setting APN to internet
Setting username to web
Setting password to web
$ of-tests-activate-context 0
$ of-tests-process-context-settings
Configuring /huawei0/context1
     Interface is ppp0
     IP address is <ip-addr>
     Gateway is 0.0.0.0
     Nameserver is 10.203.129.68
     Nameserver is 10.203.129.70
$ # ping kernel.org
$ ping -c3 -I ppp0 149.20.4.69
PING 149.20.4.69 (149.20.4.69): 56 data bytes
64 bytes from 149.20.4.69: seq=3D1 ttl=3D57 time=3D1702.332 ms
64 bytes from 149.20.4.69: seq=3D2 ttl=3D57 time=3D693.658 ms
64 bytes from 149.20.4.69: seq=3D0 ttl=3D57 time=3D2717.784 ms

--- 149.20.4.69 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max =3D 693.658/1704.591/2717.784 ms
$ ifconfig ppp0
ppp0      Link encap:UNSPEC  HWaddr =

00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
           inet addr:<addr>  P-t-P:<same-addr>  Mask:255.255.255.255
           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
           RX packets:10 errors:0 dropped:0 overruns:0 frame:0
           TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:500
           RX bytes:840 (840.0 B)  TX bytes:840 (840.0 B)

$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use =

Iface
10.203.129.68   0.0.0.0         255.255.255.255 UH    0      0        0 ppp0
10.203.129.70   0.0.0.0         255.255.255.255 UH    0      0        0 ppp0
192.168.2.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0

Note:
  - all the of-tests-XXX are the python scripts from ofono/tests directory

Now, here are my questions:
1) Is it the right sequence to bring up ppp0 with ofono?

2) To which extend, ofono is suppose to manage the routing table? I was =

expecting to see a default route. As well, something strange to me is =

that my ppp0 inet address is the same as the P-t-P one's and that the =

gateway is 0.0.0.0!
What I'm used to with ppp is to have to do something this:
route add -host <ptp-addr> ppp0
route add default gw <ptp-addr>
But it seems to work as I can ping through ppp0...

3) Now, If I want to use connman to set up ppp0, which of these above =

steps do I need to do? I was expecting to be able to set the APN, user & =

password via connmand, but it seems that this feature has benn removed, =

so I have to tell ofono about these settings.
My problem is that I cannot have a proper PPP network configuration with =

connmand.

Any help would be greatly appreciated.

Chris

--===============6136463329687809042==--

