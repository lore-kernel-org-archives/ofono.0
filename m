Content-Type: multipart/mixed; boundary="===============4743801331794597782=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Randomly SMS sent passes or fails
Date: Tue, 05 Mar 2013 16:27:38 +0100
Message-ID: <51360EEA.6090506@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4743801331794597782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I've a weird issue. I don't know what's going on...

I try to send SMS with a T-mobile SIM card in Germany. The SIM card =

doesn't require PIN code. I can get the GSM network and I don't use GPRS.

Sometimes, I can send SMS, and another time, It fails. More precisely, =

when I've got an ofono which can send SMS, I can send all the SMS I =

want, it works. But if I restart ofono, either it works or not.

I added OFONO_AT_DEBUG=3D1 in my env, and tried to find some troubles in =

the logs. I've got some errors but I don't think they are criticals and
anyway, they appeared when SMS working too :

-------------------------------
 > AT+CPINR\r
< \r\nERROR\r\n
Querying remaining pin retries failed

[...]

Provisioning failed
-------------------------------

I can see some differences in time for "AT+CRSM" commands but, they are =

in the same order. And, after many tests, I don't think the problem is here.

And, when the SMS send fails, the modem tells me :

-------------------------------
CMS ERROR: Unknown error\r\n

-------------------------------

Not very useful....

Also,@same time, I tested in Switzerland with SwissCom and I don't =

have problem.

1 month ago, it worked well. I don't get it...

I've got a "SIMCOM_SIM5216E" modem. Using the driver g1 or the new =

simcom driver I developped, with ofono 1.6 or 1.12, it's the same behavior.

Maybe have you already see this kind of things ? My brain is lost.

Regards,
avd.

-- =

.-------------------.-----------------------.-------------------.
| Viallard Anthony  | Syscom Instruments SA | Embedded System   |
| +41 024 455 24 82 | Rue de l'industrie 21 | Software Designer |
| ~~~~~~~~~~~~~~~~~ | 1450 Sainte-Croix     | ~~~~~~~~~~~~~~~~~ |
'-------------------^-----------------------^-------------------^

--===============4743801331794597782==--

