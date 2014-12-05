Content-Type: multipart/mixed; boundary="===============0246821296847011773=="
MIME-Version: 1.0
From: Mylene Josserand <mylene.josserand@openwide.fr>
Subject: Re: [help] connect 2 APN at the same time (PPP and QMI)
Date: Fri, 05 Dec 2014 13:38:09 +0100
Message-ID: <1677713536.28890660.1417783089563.JavaMail.root@openwide.fr>
In-Reply-To: <5480923E.6020006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0246821296847011773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

 =

> Pretty much.  When we pass the chat to the gprs_context driver we set
> the slave chat.  This is needed in order to monitor certain events
> which
> come in via AT commands when the PPP link is active.  In effect we
> require 2 AT command ports.


ok, thank you for the explanation.


> On some hardware there was only a single functional PPP port, so the
> driver might need to be modified to handle that case, but it sounds
> like
> you don't have this issue.


Yes, I have 2 AT command ports but I understand that it must be handled dif=
ferently with only one AT port.


> =

> Cool, feel free to send a patch for this.
> =

> IP settings are notified to oFono by the gprs_context driver.  If
> there
> are IP settings given, then most likely they should be obtained via
> DHCP.  Running test/list-contexts should tell you all the information
> once both contexts are active.


Yes, I already used this test and sent some "dbus-send" command lines to ge=
t informations.
I get an IP address according to ofono :

[ /modem_0 ]
    [ /modem_0/context1 ]
        Username =3D =

        AuthenticationMethod =3D chap
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { Interface=3Dwwan0 Method=3Ddhcp }
        IPv6.Settings =3D { }
        Active =3D 1
        AccessPointName =3D APN1
        Password =3D =

        Type =3D internet

    [ /modem_0/context2 ]
        Username =3D =

        AuthenticationMethod =3D chap
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { Interface=3Dppp0 Netmask=3D255.255.255.255 Method=3D=
static DomainNameServers=3D0.0.0.0,0.0.0.0, Address=3D30.1.63.4 }
        IPv6.Settings =3D { }
        Active =3D 1
        AccessPointName =3D APN2
        Password =3D =

        Type =3D internet


but with ifconfig, I did not get the IP address on the PPP0 interface (in t=
his example) :

ppp0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-=
00-00-00  =

          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:500 =

          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wwan0     Link encap:Ethernet  HWaddr 16:12:29:6F:55:C7  =

          inet addr:217.200.57.222  Bcast:217.200.57.223  Mask:255.255.255.=
252
          inet6 addr: fe80::1412:29ff:fe6f:55c7/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:15 errors:0 dropped:0 overruns:0 frame:0
          TX packets:39 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 =

          RX bytes:1726 (1.6 KiB)  TX bytes:8044 (7.8 KiB)

I run more tests and I tried to exchange the APN names and my problem is no=
t linked to APNs, it is linked to the context2. Whatever APN and whatever i=
nterfaces (PPP or QMI) is selected in context 2, it did not get an IP addre=
ss. So PPP or QMI connections are ok, APN1 or APN2 are ok, this seems to be=
 a context 2 problem. =


I looked deeper in connman's code (which I think is the problem). And, in d=
ebug mode, for the 2nd context, the "context_changed" function is called tw=
ice with no "Settings" and no "Active" parameters read.

For context 1 :

connmand[1537]: plugins/ofono.c:context_changed() context_path /modem_0/con=
text1
connmand[1537]: plugins/ofono.c:context_changed() /modem_0 Settings
connmand[1537]: plugins/ofono.c:extract_ipv4_settings() Interface wwan0
connmand[1537]: plugins/ofono.c:extract_ipv4_settings() index 35
connmand[1537]: plugins/ofono.c:extract_ipv4_settings() Method dhcp
connmand[1537]: plugins/ofono.c:context_changed() context_path /modem_0/con=
text1
connmand[1537]: plugins/ofono.c:context_changed() /modem_0 Active 1
connmand[1537]: plugins/ofono.c:set_connected() /modem_0

whereas, for context 2 :

connmand[1341]: plugins/ofono.c:context_changed() context_path /modem_0/con=
text2
connmand[1341]: plugins/ofono.c:context_changed() context_path /modem_0/con=
text2


I am going to read/add debug in connman's code (plugin/ofono.c), I will pos=
t again if I find something.


Best regards,

Myl=C3=A8ne

--===============0246821296847011773==--

