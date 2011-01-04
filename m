Content-Type: multipart/mixed; boundary="===============0626358082772390626=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH v2 0/4] Query retry counters
Date: Tue, 04 Jan 2011 12:24:46 -0200
Message-ID: <AANLkTinMDnLciUOxRG_pbA4=KyH6B1C780BBnj9=2z_5@mail.gmail.com>
In-Reply-To: <AANLkTin0pt7fjJCWnH+ggyihC7PMTnDbAowoRLxy7mNY@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0626358082772390626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar

Em 04/01/2011 11:20, "Sankar" <gsankar.gs@gmail.com> escreveu:
> On Tue, Jan 4, 2011 at 6:36 PM, Lucas De Marchi <lucas.demarchi@profusi=
on.mobi> wrote:
>>
>> Here is the second implementation for the retry counter task. The differ=
ence
>> from the previous approach is that now a dict with all the available ret=
ry
>> counters is returned. This way is possible to query the retry counter ev=
en when
>> PinRequired =3D=3D None, what allows us to properly handle calls to Ente=
rPin(),
>> LockPin(), UnlockPin() and so on.
>>
>> The dict has the form { pin =3D 3, puk =3D 10, ... }. The driver impleme=
ntation for
>> huawei modem is done using its proprietary command, which returns 4 coun=
ters:
>>
>> {SimManager} [/huawei0] Retries =3D { pin2 =3D 3, puk2 =3D 10, pin =3D 3=
, puk =3D 10 }
>
>
> How this information is retrieved at the oFono core. Is your solution to =
maintain a counter or read the value from the sim elementary files?

Each vendor has proprietary commands to read these counters. For
example, on huawei you can get the retry counters by sending
"AT^CPIN?". Last version of 27.007 included an AT command for that
(+CPINR), so it's possible to have a generic implementation for
atmodem. However I don't know what vendors already support it.



regards,

Lucas De Marchi

--===============0626358082772390626==--

