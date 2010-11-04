Content-Type: multipart/mixed; boundary="===============0904244343930345574=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Huawei EM 770 not working properly
Date: Thu, 04 Nov 2010 13:17:41 +0100
Message-ID: <1288873061.9615.90.camel@aeonflux>
In-Reply-To: <1288869292.10276.10.camel@par-r81vxc7.par.novell.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0904244343930345574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

> I'm trying to get ofono working properly with integrated 3G card on my
> EEE PC.
> =

> Card is Huawei EM 770 (12d1:1001).
> =

> I'm testing with ofono 0.34.
> =

> so far, the modem is correctly detected :
> =

> list-modem returns :
> [ /huawei0 ]
>  Features =3D sim
>  Powered =3D 1
>  Interfaces =3D org.ofono.SimManager
>  Online =3D 0
>  Model =3D EM770
>  Manufacturer =3D huawei
>  Serial =3D ....
>  Revision =3D 11.104.16.12.00
>  [ org.ofono.SimManager ] =

>   Present =3D 0
> =

> And trying to put it "online" using online-modem returns
> "org.ofono.Error.NotAvailable"
> =

> Logs are as follow :
> =

> ofonod[1493]: plugins/bluetooth.c:manager_properties_cb() =

> ofonod[1493]: plugins/bluetooth.c:parse_adapters() =

> ofonod[1493]: plugins/bluetooth.c:parse_adapters() Calling GetProperties
> on /org/bluez/465/hci0
> ofonod[1493]: plugins/bluetooth.c:parse_devices() =

> ofonod[1493]: plugins/bluetooth.c:adapter_properties_cb() Adapter
> Address: 00:25:D3:A2:D1:09, Path: /org/bluez/465/hci0
> ofonod[1493]: plugins/huawei.c:huawei_enable() 0x941b210
> ofonod[1493]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
> ofonod[1493]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
> ofonod[1493]: plugins/huawei.c:query_sim_state() =

> ofonod[1493]: PCUI: > ATE0 +CMEE=3D1\r
> ofonod[1493]: PCUI: < \r\nOK\r\n
> ofonod[1493]: PCUI: > AT+CFUN=3D1\r
> ofonod[1493]: PCUI: < \r\nOK\r\n
> ofonod[1493]: plugins/huawei.c:cfun_enable() =

> ofonod[1493]: PCUI: > AT^SYSINFO\r
> ofonod[1493]: PCUI: < \r\n^SYSINFO:0,0,0,0,0,,0\r\n\r\nOK\r\n
> ofonod[1493]: plugins/huawei.c:notify_sim_state() 0
> ofonod[1493]: plugins/huawei.c:huawei_pre_sim() 0x941b210
> ofonod[1493]: plugins/huawei.c:query_sim_state() =

> ofonod[1493]: PCUI: > AT^U2DIAG?\r
> ofonod[1493]: PCUI: < \r\nERROR\r\n
> ofonod[1493]: PCUI: > AT^GETPORTMODE\r
> ofonod[1493]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
> ofonod[1493]: PCUI: > AT^USSDMODE=3D?\r
> ofonod[1493]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
> ofonod[1493]: PCUI: > AT^CVOICE=3D?\r
> ofonod[1493]: PCUI: < \r\n^CVOICE:(1)\r\n\r\nOK\r\n
> ofonod[1493]: PCUI: > AT^SYSINFO\r
> ofonod[1493]: PCUI: < \r\n^SYSINFO:0,0,0,0,0,,0\r\n\r\nOK\r\n
> ofonod[1493]: plugins/huawei.c:notify_sim_state() 0
> ofonod[1493]: PCUI: > AT+CGMI\r
> ofonod[1493]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
> ofonod[1493]: PCUI: > AT^CVOICE?\r
> ofonod[1493]: PCUI: < \r\n^CVOICE:1\r\n\r\nOK\r\n
> ofonod[1493]: PCUI: > AT+CGMM\r
> ofonod[1493]: PCUI: < \r\nEM770\r\n\r\nOK\r\n
> ofonod[1493]: PCUI: > AT+CGMR\r
> ofonod[1493]: PCUI: < \r\n11.104.16.12.00\r\n\r\nOK\r\n
> ofonod[1493]: PCUI: > AT+CGSN\r
> ofonod[1493]: PCUI: < \r\n355093024527802\r\n\r\nOK\r\n
> ofonod[1493]: PCUI: < \r\n^RSSI:23\r\n\r\n^SRVST:1\r\n\r\n^MODE:5,4\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> ofonod[1493]: PCUI: < \r\n^BOOT:24527802,0,0,0,24\r\n
> =

> Any idea ?

how long did you wait here? Sometimes the Huawei firmware needs a long
time to detect if the SIM card is actually ready.

Also it could be that the SIM card detection is broken with EM770. I
would need to dig though the manual again.

So the ^SRVST:1 means we are in Restricted Service mode. Whatever that
actually means.

The ^MODE:5,4 means we are in WCDMA mode (UMTS) without HSPA.

So what I am missing is a ^SIMST notification telling us about the
current SIM state. So it could be that this firmware just does not send
one at all. So we might have to query AT+CPIN to figure out if the SIM
card is indeed ready.

Or the CFUN handling in this firmware is broken. I have one of these
cards where it is the case as well. Behaves really wrongly, but I have
had no time to look into it.

Regards

Marcel



--===============0904244343930345574==--

