Content-Type: multipart/mixed; boundary="===============0352259133809945541=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC_v1 2/2] sierra: Add SIM state polling
Date: Fri, 02 Dec 2011 06:11:18 -0600
Message-ID: <4ED8C066.4030808@gmail.com>
In-Reply-To: <4EDCA3B2.2060406@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0352259133809945541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>> - The sierra driver does not instantiate any gprs_context drivers, so it
>> isn't even capable of GPRS in its current state.  Sending the&C0
>> command is only needed if you are planning to use PPP and probably
>> belongs in a separate patch.
>>
> =

> I didn't see the gprs context was never created into sierra plugin, do
> we have a reason for that?
> =


Probably just an oversight.

Regards,
-Denis

--===============0352259133809945541==--

