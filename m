Content-Type: multipart/mixed; boundary="===============6773118668753583893=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: AW: AW: connmand[186]: Online check failed but running dhclient
 manually fixes this issue
Date: Wed, 26 Jul 2017 16:45:08 +0200
Message-ID: <c01ba3df-7c71-3d6b-d1ba-598592614f75@kerlink.fr>
In-Reply-To: <82fa93d5-49e5-7725-40c9-c4dfd4540c75@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6773118668753583893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 07/26/2017 12:59 PM, Daniel Wagner wrote:
> [added ofono mailing list]
>
> Summery: The qmi modem returns since 475b789f3de9 ("qmi: retrieve GPRS
> context parameters") the IP configuration which is sometimes incorrect.
> If ConnMan gets the IP configuration it doesn't do any DHCP and applies
> the not working IP configuration.
>
> On 07/26/2017 10:11 AM, Eswaran Vinothkumar (BEG/PJ-IOT-EL) wrote:
>> On 07/21/2017 09:31 AM, Daniel Wagner wrote:
>>> The first thing I noticed, is that we do not extract the DNS settings
>>> correctly. oFono sends 10.105.16.254 and 10.105.144.254. I starred at
>>> the oFono code base and also at ConnMan and I don't see what's going
>>> wrong.
>>>
>>> Jul 21 05:47:02 alen-iot-gateway ofonod[176]:
>>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb()
>>> Jul 21 05:47:02 alen-iot-gateway ofonod[176]:
>>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() APN:
>>> internetd.gdsp Jul 21 05:47:02 alen-iot-gateway ofonod[176]:
>>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() PDP
>>> type 0 Jul 21 05:47:02 alen-iot-gateway ofonod[176]:
>>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() IP
>>> addr: 10.249.97.226 Jul 21 05:47:02 alen-iot-gateway ofonod[176]:
>>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb()
>>> Gateway: 10.249.97.225 Jul 21 05:47:02 alen-iot-gateway ofonod[176]:
>>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb()
>>> Gateway netmask: 255.255.255.252 Jul 21 05:47:02 alen-iot-gateway
>>> ofonod[176]:
>>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb()
>>> Primary DNS: 10.105.16.254 Jul 21 05:47:02 alen-iot-gateway
>>> ofonod[176]:
>>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb()
>>> Secondary DNS: 10.105.144.254
>>>
>>>
>>> Jul 21 05:47:02 alen-iot-gateway connmand[175]:
>>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Interface
>>> wwan0 Jul 21 05:47:02 alen-iot-gateway connmand[175]:
>>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() index 6 Jul 21
>>> 05:47:02 alen-iot-gateway connmand[175]:
>>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Method static
>>> Jul 21 05:47:02 alen-iot-gateway connmand[175]:
>>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Address
>>> 10.249.97.226 Jul 21 05:47:02 alen-iot-gateway connmand[175]:
>>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Netmask
>>> 255.255.255.252 Jul 21 05:47:02 alen-iot-gateway connmand[175]:
>>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Gateway
>>> 10.249.97.225 Jul 21 05:47:02 alen-iot-gateway connmand[175]:
>>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Nameservers
>>> 10.105.144.254 10.105.144.254
>>>
>>> Could you add some printfs to the extract_nameservers() in
>>> plugins/ofono.c? And you might also want to run
>>> ofono/test/monitor-ofono so that you can see what oFono sends to
>>> ConnMan.
>>>
>>>
>>> Address:   10.249.97.226         00001010.11111001.01100001.111000 10
>>> Netmask:   255.255.255.252 =3D 30  11111111.11111111.11111111.111111 00
>>> Wildcard:  0.0.0.3               00000000.00000000.00000000.000000 11
>>> =3D>
>>> Network:   10.249.97.224/30      00001010.11111001.01100001.111000 00 (=
Class A)
>>> Broadcast: 10.249.97.227         00001010.11111001.01100001.111000 11
>>> HostMin:   10.249.97.225         00001010.11111001.01100001.111000 01
>>> HostMax:   10.249.97.226         00001010.11111001.01100001.111000 10
>>> Hosts/Net: 2                     (Private Internet)
>>>
>>> Looking through the log, it looks like ConnMan does all the math
>>> correctly.
>>>
>>> One thing which looks inconsistent in your first report is:
>>>
>>> ofono_start_gsm.sh[192]:     Interface is wwan0
>>> ofono_start_gsm.sh[192]:     IP address is 10.249.29.20
>>> ofono_start_gsm.sh[192]:     Gateway is 10.249.29.21
>>> ofono_start_gsm.sh[192]:     Nameserver is 10.105.144.254
>>>
>>>
>>> Destination                   Gateway           Genmask           Flags=
    Metric   Ref    Use         Iface
>>> 0.0.0.0                       10.166.199.10     0.0.0.0           UG   =
    0            0        0           wwan0
>>> 10.105.144.254                10.166.199.10     255.255.255.255   UGH  =
    0            0        0           wwan0
>>> 10.166.199.8                  0.0.0.0           255.255.255.252   U    =
    0            0        0           wwan0
>>> 10.166.199.10                 0.0.0.0           255.255.255.255   UH   =
    0            0        0           wwan0
>>>
>>> The gateway should be 10.249.29.21 and not 10.166.199.10.
>>> The next three lines are adding a host routing for the DNS server and
>>> maybe timeserver. At least the first line is the DNS server but again
>>> the gateway is wrong.
>>>
>>> dhclient gets set a complete different gateway:
>>>
>>> Destination       Gateway           Genmask                    Flags   =
 Metric   Ref    Use         Iface
>>> 0.0.0.0           10.166.250.1      0.0.0.0                    UG      =
 0            0        0           wwan0
>>> 10.166.250.0      0.0.0.0           255.255.255.240            U       =
   0            0        0           wwan0
>>> 192.168.1.0       0.0.0.0           255.255.255.0              U       =
   0            0        0           eth0
>>> 192.168.1.255     0.0.0.0           255.255.255.255            UH      =
  0            0        0           eth0
>>>
>>> 10.166.250.1 with a different netmask!
>>>
>>> First thing I would do is to verify what the oFono modem is doing. If
>>> that one extracts the wrong information and passes that to ConnMan it
>>> would explain your problem. The code in oFono is pretty new
>>>
>>> 475b789f3de9 ("qmi: retrieve GPRS context parameters")
>> Just my 2 cents on this topic.
>> On my setup, I use another QMI modem: MC7304 with  ofono 1.20 + a bunch =
of patches done internally and connman 1.34.
>>
>> I also had problem with this patch (475b789f3de9 ("qmi: retrieve GPRS co=
ntext parameters")).
>> I have reverted it or to be more precise I commented all calls to functi=
ons ofono_gprs_context_set_ipv4* functions.
>> I have done that 3 months ago so I am not completely sure about the why:
>> Here is what I wrote in my patch:
>>
>> The goal is to force connman to use DHCP.
>> When connman don't do that, MC7304 fails to ping.
>> This behavior has been seen by libqmi guys:
>> https://lists.freedesktop.org/archives/libqmi-devel/2016-June/001617.html
>>
>> Maybe you have the same problem with your TELIT modem.
>> I can send my patch if you want but it is not the best way to handle the=
 problem.
> Thanks for your report. So we have at least two independent reports for
> this problem.
>
> Just for the record which ISP are you using? The above is Vodafone.
I am using an Orange SIM card (french operator) and a MC7304 modem. =

Software is:
ofono 1.20 + personal patches
connman 1.34

Information returned by Ofono in get_settings_cb (and not transmitted to =

Connman due to my patch) says:
Jul 26 13:40:37 klk-lpbs-0504B4 daemon.debug ofonod[938]: =

../git/drivers/qmimodem/gprs-context.c:get_settings_cb() APN: =

orange.m2m.spec
Jul 26 13:40:37 klk-lpbs-0504B4 daemon.debug ofonod[938]: =

../git/drivers/qmimodem/gprs-context.c:get_settings_cb() PDP type 0
Jul 26 13:40:37 klk-lpbs-0504B4 daemon.debug ofonod[938]: =

../git/drivers/qmimodem/gprs-context.c:get_settings_cb() IP addr: =

10.169.160.216
Jul 26 13:40:37 klk-lpbs-0504B4 daemon.debug ofonod[938]: =

../git/drivers/qmimodem/gprs-context.c:get_settings_cb() Gateway: =

10.169.160.217
Jul 26 13:40:37 klk-lpbs-0504B4 daemon.debug ofonod[938]: =

../git/drivers/qmimodem/gprs-context.c:get_settings_cb() Gateway =

netmask: 255.255.255.240
Jul 26 13:40:37 klk-lpbs-0504B4 daemon.debug ofonod[938]: =

../git/drivers/qmimodem/gprs-context.c:get_settings_cb() Primary DNS: =

192.168.10.110
Jul 26 13:40:37 klk-lpbs-0504B4 daemon.debug ofonod[938]: =

../git/drivers/qmimodem/gprs-context.c:get_settings_cb() Secondary DNS: =

194.51.3.56

After connman make its DHCP request, I have:
root(a)klk-lpbs-0504B4:~ # route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref Use Iface
default         192.168.4.4     0.0.0.0         UG    0 0        0 eth0
10.169.160.208  *               255.255.255.240 U     0 0        0 wwan3
10.169.160.217  *               255.255.255.255 UH    0 0        0 wwan3
192.168.4.0     *               255.255.254.0   U     0 0        0 eth0
192.168.4.4     *               255.255.255.255 UH    0 0        0 eth0
192.168.10.110  10.169.160.217  255.255.255.255 UGH   0 0        0 wwan3
194.51.3.56     10.169.160.217  255.255.255.255 UGH   0 0        0 wwan3
root(a)klk-lpbs-0504B4:~ # ifconfig wwan3
wwan3     Link encap:Ethernet  HWaddr B6:2A:D2:26:FB:BC
           inet addr:10.169.160.216  Bcast:10.169.160.223 =

Mask:255.255.255.240
           UP BROADCAST RUNNING MULTICAST  MTU:1430  Metric:1
           RX packets:11 errors:0 dropped:0 overruns:0 frame:0
           TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:1340 (1.3 KiB)  TX bytes:1955 (1.9 KiB)

So information returned by get_settings_cb looks good in my case. But I =

am still not able to ping if Ofono give this information to Connman (in =

this case connection is said to be up without calling DHCP).

Please find complete log of connection (with Ofono and Connman debug) in =

attachment.

Christophe Ronco

>
>> Christophe Ronco
>>
>> I have also fixed the issue by creating a patch for Connman to run DHCP =
even when network returns static/fixed IP. Its'a not the way to do, but it=
=E2=80=99s a quick fix like yours.
> If we could find some sort of rule when to ignore the returned values
> from oFono than we can fallback to DHCP.
>
> Thanks,
> Daniel
>


--===============6773118668753583893==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="log_extract.tar.gz"

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
--===============6773118668753583893==--

