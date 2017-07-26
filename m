Content-Type: multipart/mixed; boundary="===============6026161158916548355=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: AW: AW: connmand[186]: Online check failed but running dhclient
 manually fixes this issue
Date: Wed, 26 Jul 2017 12:59:27 +0200
Message-ID: <82fa93d5-49e5-7725-40c9-c4dfd4540c75@monom.org>
In-Reply-To: <431f1ef2cfd74bc88161f8c8ba47f24d@FE-MBX1014.de.bosch.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6026161158916548355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[added ofono mailing list]

Summery: The qmi modem returns since 475b789f3de9 ("qmi: retrieve GPRS
context parameters") the IP configuration which is sometimes incorrect.
If ConnMan gets the IP configuration it doesn't do any DHCP and applies
the not working IP configuration.

On 07/26/2017 10:11 AM, Eswaran Vinothkumar (BEG/PJ-IOT-EL) wrote:
> On 07/21/2017 09:31 AM, Daniel Wagner wrote:
>> The first thing I noticed, is that we do not extract the DNS settings =

>> correctly. oFono sends 10.105.16.254 and 10.105.144.254. I starred at =

>> the oFono code base and also at ConnMan and I don't see what's going =

>> wrong.
>>
>> Jul 21 05:47:02 alen-iot-gateway ofonod[176]: =

>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb()
>> Jul 21 05:47:02 alen-iot-gateway ofonod[176]: =

>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() APN: =

>> internetd.gdsp Jul 21 05:47:02 alen-iot-gateway ofonod[176]: =

>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() PDP =

>> type 0 Jul 21 05:47:02 alen-iot-gateway ofonod[176]: =

>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() IP =

>> addr: 10.249.97.226 Jul 21 05:47:02 alen-iot-gateway ofonod[176]: =

>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() =

>> Gateway: 10.249.97.225 Jul 21 05:47:02 alen-iot-gateway ofonod[176]: =

>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() =

>> Gateway netmask: 255.255.255.252 Jul 21 05:47:02 alen-iot-gateway =

>> ofonod[176]: =

>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() =

>> Primary DNS: 10.105.16.254 Jul 21 05:47:02 alen-iot-gateway =

>> ofonod[176]: =

>> ../ofono-1.20/drivers/qmimodem/gprs-context.c:get_settings_cb() =

>> Secondary DNS: 10.105.144.254
>>
>>
>> Jul 21 05:47:02 alen-iot-gateway connmand[175]: =

>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Interface =

>> wwan0 Jul 21 05:47:02 alen-iot-gateway connmand[175]: =

>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() index 6 Jul 21 =

>> 05:47:02 alen-iot-gateway connmand[175]: =

>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Method static =

>> Jul 21 05:47:02 alen-iot-gateway connmand[175]: =

>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Address =

>> 10.249.97.226 Jul 21 05:47:02 alen-iot-gateway connmand[175]: =

>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Netmask =

>> 255.255.255.252 Jul 21 05:47:02 alen-iot-gateway connmand[175]: =

>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Gateway =

>> 10.249.97.225 Jul 21 05:47:02 alen-iot-gateway connmand[175]: =

>> ../connman-1.34/plugins/ofono.c:extract_ipv4_settings() Nameservers =

>> 10.105.144.254 10.105.144.254
>>
>> Could you add some printfs to the extract_nameservers() in =

>> plugins/ofono.c? And you might also want to run =

>> ofono/test/monitor-ofono so that you can see what oFono sends to =

>> ConnMan.
>>
>>
>> Address:   10.249.97.226         00001010.11111001.01100001.111000 10
>> Netmask:   255.255.255.252 =3D 30  11111111.11111111.11111111.111111 00
>> Wildcard:  0.0.0.3               00000000.00000000.00000000.000000 11
>> =3D>
>> Network:   10.249.97.224/30      00001010.11111001.01100001.111000 00 (C=
lass A)
>> Broadcast: 10.249.97.227         00001010.11111001.01100001.111000 11
>> HostMin:   10.249.97.225         00001010.11111001.01100001.111000 01
>> HostMax:   10.249.97.226         00001010.11111001.01100001.111000 10
>> Hosts/Net: 2                     (Private Internet)
>>
>> Looking through the log, it looks like ConnMan does all the math =

>> correctly.
>>
>> One thing which looks inconsistent in your first report is:
>>
>> ofono_start_gsm.sh[192]:     Interface is wwan0
>> ofono_start_gsm.sh[192]:     IP address is 10.249.29.20
>> ofono_start_gsm.sh[192]:     Gateway is 10.249.29.21
>> ofono_start_gsm.sh[192]:     Nameserver is 10.105.144.254
>>
>>
>> Destination                   Gateway           Genmask           Flags =
   Metric   Ref    Use         Iface
>> 0.0.0.0                       10.166.199.10     0.0.0.0           UG    =
   0            0        0           wwan0
>> 10.105.144.254                10.166.199.10     255.255.255.255   UGH   =
   0            0        0           wwan0
>> 10.166.199.8                  0.0.0.0           255.255.255.252   U     =
   0            0        0           wwan0
>> 10.166.199.10                 0.0.0.0           255.255.255.255   UH    =
   0            0        0           wwan0
>>
>> The gateway should be 10.249.29.21 and not 10.166.199.10.
>> The next three lines are adding a host routing for the DNS server and =

>> maybe timeserver. At least the first line is the DNS server but again =

>> the gateway is wrong.
>>
>> dhclient gets set a complete different gateway:
>>
>> Destination       Gateway           Genmask                    Flags    =
Metric   Ref    Use         Iface
>> 0.0.0.0           10.166.250.1      0.0.0.0                    UG       =
0            0        0           wwan0
>> 10.166.250.0      0.0.0.0           255.255.255.240            U        =
  0            0        0           wwan0
>> 192.168.1.0       0.0.0.0           255.255.255.0              U        =
  0            0        0           eth0
>> 192.168.1.255     0.0.0.0           255.255.255.255            UH       =
 0            0        0           eth0
>>
>> 10.166.250.1 with a different netmask!
>>
>> First thing I would do is to verify what the oFono modem is doing. If =

>> that one extracts the wrong information and passes that to ConnMan it =

>> would explain your problem. The code in oFono is pretty new
>>
>> 475b789f3de9 ("qmi: retrieve GPRS context parameters")
> Just my 2 cents on this topic.
> On my setup, I use another QMI modem: MC7304 with  ofono 1.20 + a bunch o=
f patches done internally and connman 1.34.
> =

> I also had problem with this patch (475b789f3de9 ("qmi: retrieve GPRS con=
text parameters")).
> I have reverted it or to be more precise I commented all calls to functio=
ns ofono_gprs_context_set_ipv4* functions.
> I have done that 3 months ago so I am not completely sure about the why:
> Here is what I wrote in my patch:
> =

> The goal is to force connman to use DHCP.
> When connman don't do that, MC7304 fails to ping.
> This behavior has been seen by libqmi guys:
> https://lists.freedesktop.org/archives/libqmi-devel/2016-June/001617.html
> =

> Maybe you have the same problem with your TELIT modem.
> I can send my patch if you want but it is not the best way to handle the =
problem.

Thanks for your report. So we have at least two independent reports for
this problem.

Just for the record which ISP are you using? The above is Vodafone.

> Christophe Ronco
> =

> I have also fixed the issue by creating a patch for Connman to run DHCP e=
ven when network returns static/fixed IP. Its'a not the way to do, but it=
=E2=80=99s a quick fix like yours.

If we could find some sort of rule when to ignore the returned values
from oFono than we can fallback to DHCP.

Thanks,
Daniel

--===============6026161158916548355==--

