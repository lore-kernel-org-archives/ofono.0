Content-Type: multipart/mixed; boundary="===============0850018242229117008=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: SIM PIN unlock
Date: Wed, 28 Oct 2009 15:17:15 +0100
Message-ID: <4AE8526B.7000305@gmail.com>
In-Reply-To: <200910271110.18713.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0850018242229117008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Denis Kenzior wrote:
> Hi Ryan,
> =

>> Ok. I have narrowed it down a little.
>>
>> It seems to be the CRSM command reading the
>> SIM_EFLI_FILEID when it succeeds.
>>
>> ofonod[6326]: > AT+CRSM=3D192,28421\r
>> ofonod[6326]: < \r\n+CRSM: 144,
>> ofonod[6326]: < 0,850D00046F05040001FFAA03020000\r\n\r\n
>> ofonod[6326]: < \r\nOK\r\n
>>
>> goes no further....
> =

> The parser is stuck because your modem is spewing garbage.  atgen plugin =
uses =

> the _really_ strict gsmv1 syntax.  I suggest you make a custom driver for=
 your =

> device that uses the gsm_permissive syntax.
> =

This worked! Thank you. Could this be another option in modem.conf =

(Syntax=3D[Permissive,GSM1])?

>> 	ofono_sim_read(sim, SIM_EFLI_FILEID,
>>          	                OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>>                  	        sim_efli_read_cb, sim);
> =

> This is wrong and won't get you very far as there are about 20 other SIM =
files =

> that we read.

I knew it was wrong, it was not a fix, just a localized point where my =

device was failing.


Regards,
Ryan

> =

> Regards,
> -Denis
>=20

--===============0850018242229117008==--

