Content-Type: multipart/mixed; boundary="===============7522102168952470566=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Mon, 11 Mar 2013 15:53:32 +0100
Message-ID: <513DEFEC.2070208@syscom-instruments.com>
In-Reply-To: <51370B2D.5050904@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7522102168952470566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06. 03. 13 10:23, Viallard Anthony wrote:
> On 05. 03. 13 21:43, Denis Kenzior wrote:
>
>>
>> Nope, can't really help here; perhaps if you shared a detailed AT log?
>>
>> Regards,
>> -Denis
>
> I tried to find some information about the operator and SMS/GPRS. I
> didn't find documentation in my fluent language. I will ask to a german
> guy. Maybe, there are a AT command to know wether operator supports this ?
>
> Otherwise, I try to find documentation about this amazing SMS over GPRS
> feature. From what I read, there an AT command to select the behavior. I
> guess it's the AT+CGSMS command. Ofono set CGSMS to 3 :
>
> AT+CGSMS=3D3
>
>  From the modem documentation, I see :
>
> A numeric parameter which indicates the service or service preference to
> be used
> 0 =E2=80=93 GPRS(value is not really supported and is internally mapped t=
o 2)
> 1 =E2=80=93 circuit switched(value is not really supported and is interna=
lly
> mapped to 3)
> 2 =E2=80=93 GPRS preferred (use circuit switched if GPRS not available)
> 3 =E2=80=93 circuit switched preferred (use GPRS if circuit switched not =
available)
>
> Maybe the "circuit switched" has got some troubles on the operator
> network and as I disabled GPRS, the SMS sending failed most of the time ?
>
> There also the command AT+CSMS :
>
> +CSMS: 1,1,1
>
> The first 1 tells the "SMS at command is compatible with GSM phase 2+.".
> Perhaps, the thing has an impact about the issue ...

Any comments ? :(

Before, I tested with 1.6.

And, today, I tried with 1.12.

And, I've got some troubles at modem power up... During the 3 first =

start, ofono was blocked after sending a command. Here 2 pastes :

------------------------------
[...]
ofonod[13400]: drivers/atmodem/cbs.c:at_cbs_set_topics()
ofonod[13400]: Data: > AT+CSCB=3D0,"4352-4356"\r
ofonod[13400]: Data: < \r\nOK\r\n
ofonod[13400]: Data: > AT+CRSM=3D192,28437\r
ofonod[13400]: Data: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[13400]: Data: > AT+CRSM=3D192,28436\r
------------------------------

------------------------------
[...]
ofonod[10387]: src/network.c:ofono_netreg_status_notify() /simcom_0 =

status 1 tech -1
ofonod[10387]: src/cbs.c:cbs_location_changed() 1, -1, -1, -1, (null)(null)
ofonod[10387]: Data: > AT+CRSM=3D192,28480\r
ofonod[10387]: Data: < \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
ofonod[10387]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 0
ofonod[10387]: Data: > AT+CMGF=3D?\r
------------------------------

As you can see, It's not always at the same moment. After that, I can't =

send AT command anymore, the modem seems to be locked.

I try to debug this and found the CMUX and CMUXSRVPORT ports. I can have =

a DIAG port, so, I try to configure it. I stopped ofono, the modem and =

sent these commands :

------------------------------
AT+CMUXSRVPORT=3D0, 0
AT+CMUXSRVPORT=3D1, 5
AT+CMUXSRVPORT=3D2, 1
AT+CMUXSRVPORT=3D3, 1

+CMUX=3D0
------------------------------

------------------------------
AT+CMUXSRVPORT
--------------
< port >: virtual com port
0 =E2=80=93 3 currently support 4 virtual com ports index from 0 to 3

< service >: valid service
0 =E2=80=93 DIAG Service
1 =E2=80=93 DATA(MODEM) Service
5 =E2=80=93 NMEA Service
------------------------------

And now, each time I start ofono and power up the modem, it works. No =

lock. Hum, I'm disapointed. I didn't think theses commands could fix the =

problem. And, no messages in diag or NMEA tty. Hum... And moreover, now =

all SMS I send are received. No failure. So good news, but, I'm troubled.

After grepping on ofono source, I see some driver plugins do a CMUX set =

(calipso, phonesim). Maybe, I need to execute a CMUX set ??? It can be =

important ?

Nevertheless, I don't understand why I have problems with this T-Mobile =

SIM card and not with Vodafone for example...

Regards,
Anthony.


--===============7522102168952470566==--

