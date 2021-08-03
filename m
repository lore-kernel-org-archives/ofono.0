Content-Type: multipart/mixed; boundary="===============4835120316895144551=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Tue, 03 Aug 2021 09:28:07 -0500
Message-ID: <70bd0c15-0fe5-59ea-f619-54dadd35e586@gmail.com>
In-Reply-To: <e74bf986-cc91-287b-9c6b-83d7804333a7@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4835120316895144551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

> I have been chasing this up with Quectel and they tell me this the correc=
t =

> implementation.
> =

> "QCOPS and QENG command show the RSSI=E3=80=81RSRP and SINR value of the =
network, this =

> is in accordance with the 3GPP TS regulations, so it is normal for negati=
ve =

> numbers to be displayed.image"


So the image shows the value for <rsrp>

'0' if -140 dbm
...
'95' if dbm is -46 to -45
etc.

<rsrp> (what is actually sent over AT commands) is never negative. Isn't th=
e =

image supporting my earlier assertion:  'AT commands do not have a concept =
of =

negative numbers'?

oFono exposes the <rsrp> value from 3GPP:

"byte ReferenceSignalReceivedPower [optional, lte]

         Contains the Reference Signal Received Power.  Valid range of valu=
es
         is 0-97. Refer to <rsrp> in 27.007, Section 8.69 for more details.
"

Regards,
-Denis
--===============4835120316895144551==--

