Content-Type: multipart/mixed; boundary="===============1265898100675158757=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Tue, 05 Mar 2013 14:43:00 -0600
Message-ID: <513658D4.8040508@gmail.com>
In-Reply-To: <51360EEA.6090506@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1265898100675158757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/05/2013 09:27 AM, Viallard Anthony wrote:
> Hello,
>
> I've a weird issue. I don't know what's going on...
>
> I try to send SMS with a T-mobile SIM card in Germany. The SIM card
> doesn't require PIN code. I can get the GSM network and I don't use GPRS.
>
> Sometimes, I can send SMS, and another time, It fails. More precisely,
> when I've got an ofono which can send SMS, I can send all the SMS I
> want, it works. But if I restart ofono, either it works or not.
>
> I added OFONO_AT_DEBUG=3D1 in my env, and tried to find some troubles in
> the logs. I've got some errors but I don't think they are criticals and
> anyway, they appeared when SMS working too :
>
> -------------------------------
>  > AT+CPINR\r
> < \r\nERROR\r\n
> Querying remaining pin retries failed

This is not supported by all modems, it is a generic 27.007 command for =

pin retry counts.  However it was added in a fairly late version of the =

spec, so not many devices support this.

>
> [...]
>
> Provisioning failed
> -------------------------------

This should not affect anything, unless your operator requires SMS to be =

sent over GPRS.

>
> I can see some differences in time for "AT+CRSM" commands but, they are
> in the same order. And, after many tests, I don't think the problem is
> here.
>

Nope

> And, when the SMS send fails, the modem tells me :
>
> -------------------------------
> CMS ERROR: Unknown error\r\n
>
> -------------------------------
>
> Not very useful....
>
> Also, at same time, I tested in Switzerland with SwissCom and I don't
> have problem.
>
> 1 month ago, it worked well. I don't get it...
>
> I've got a "SIMCOM_SIM5216E" modem. Using the driver g1 or the new
> simcom driver I developped, with ofono 1.6 or 1.12, it's the same behavio=
r.
>
> Maybe have you already see this kind of things ? My brain is lost.
>

Nope, can't really help here; perhaps if you shared a detailed AT log?

Regards,
-Denis

--===============1265898100675158757==--

