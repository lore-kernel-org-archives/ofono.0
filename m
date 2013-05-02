Content-Type: multipart/mixed; boundary="===============5171783873651102812=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Thu, 02 May 2013 18:40:10 +0200
Message-ID: <518296EA.6080107@syscom-instruments.com>
In-Reply-To: <51680753.90109@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5171783873651102812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm still working on this subject. I analyzed ofono logs to see if there =

are troubles.

> On 28. 03. 13 15:24, Denis Kenzior wrote:
>>
>> Is the modem auto-attaching to GPRS by default? You might want to turn
>> off that behavior if posible.
>>
> What did you mean by auto-attaching to GPRS by default ?
>
> To bring GPRS up, I configure it and I call
> ConnectionContext.SetProperty with Active=3D1 and then, I've got GPRS.

I still don't understand what do you mean by auto-attaching. Where can I =

see this ? in an AT command return ? viewing AT command sent ?

>
> I dig out this old answer because I searched why in ConnectionManager
> I've got Bearer: "none". Then, I've found a place (in gprs_initialized()
> function) where ofono try to get data bearer. By default, ofono uses
> "AT+CPSB=3D1" and a callback on "+CPSB:" reply.

So, I added AT+CNSMOD simcom quirk... I don't know if it mandatory. This =

bearer is required to do right stuff ?


Otherwise, I see weird things in logs:

  * some AT+CRSM requests (READ RECORD) return "FFFFF..." :

------------
ofonod[11230]: Data: < \r\n+CRSM: 144,0,"FFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
------------

Is it normal ? For example, on EFmsisdn (6F40), the first AT command is =

a "GET RESPONSE" and next, ofono does a "READ RECORD". And this "READ =

RECORD" returns FFFFF.... whereas "GET RESPONSE" returns pretty good data" :

------------
ofonod[11230]: Data: > AT+CRSM=3D192,28480,0,0,255\r
ofonod[11230]: Data: < \r\n+CRSM: =

144,0,"6221182050221001E0483026F40A5038001718A01058B036F060B800200788800F10=
100"\r\n\r\nOK\r\n
ofonod[11230]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 35
ofonod[11230]: Data: > AT+CRSM=3D178,28480,1,4,30\r
ofonod[11230]: Data: < \r\n+CRSM: =

144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\=
nOK\r\n
ofonod[11230]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 30
------------

  * Some SIM files aren't found. On this T-Mobile SIM card, it's =

essentially about "CPHS: ..." files (6F16, 6F13, 6F15), on Service =

Dialing Numbers (6F49), on Phase identification (6FAE). I guess phase =

identification file is important, isn't it ?

  * on AF20 file (GSM ciphering key Kc), I see this error message :

------------
ofonod[11230]: Requested file structure differs from SIM: 4f20
------------

  * some AT commands fails : AT+CCWE (Call meter max event), AT+CPSB =

(fixed with AT+CNSMOD quirk), AT+CNAP (Calling name presentation). Must =

I add quirk for all theses commands ?

King regards,
Viallard Anthony.






--===============5171783873651102812==--

