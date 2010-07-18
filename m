Content-Type: multipart/mixed; boundary="===============5241549036185386751=="
MIME-Version: 1.0
From: Florian Steinel <Florian.Steinel@gmail.com>
Subject: Re: Huawei E176 - not online
Date: Sun, 18 Jul 2010 22:19:36 +0200
Message-ID: <20100718201936.GA29262@h02.hostsharing.net>
In-Reply-To: <4C4315FD.2030306@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5241549036185386751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
>> I can't get my Huawei E176 USB Stick into the online state.
>> =

>
>You won't be able to get into Online state unless your SIM is present.
><snip>
>
>> atlog output:
>
>oFono huawei driver determines sim presense in two ways: ^SIMST:1
>unsolicited notification, and by querying the ^SYSINFO.
>> =

>> ofonod[15261]: oFono version 0.25
>> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,2,0,25\r\n
>> ofonod[15261]: Pcui:> ATE0\r
>> ofonod[15261]: Pcui:< \r\n^RSSI:99\r\n\r\n^SRVST:0\r\n\r\n^MODE:0,0\r\n\=
r\n^RSSI:10\r\n\r\n^SRVST:1\r\n\r\n^MODE:5,4\r\n\r\n^BOOT:********,0,0,0,25=
\r\n\r\nOK\r\n
>> ofonod[15261]: Pcui:> AT+CFUN=3D1\r
>> ofonod[15261]: Pcui:< \r\nOK\r\n
>> ofonod[15261]: Pcui:> AT^SYSINFO\r
>> ofonod[15261]: Pcui:< \r\n^SYSINFO:1,0,1,5,0,,4\r\n\r\nOK\r\n
>
>According to Huawei docs, the 5th field is the SIM presence state.  The
>above is telling us it isn't present.

http://www.bez-kabli.pl/printview.php?t=3D20735&start=3D0
(Since i do not speak polish, I've used translate.google.com)
The 5 field (the state of the SIM card)
0 - invalid SIM card or PIN code blocked
1 - normal SIM card
2 - SIM card not valid in CS mode
3 - SIM card not valid in PS mode
4 - SIM card not valid in PS or CS mode
255 - SIM not present =


The SIM is present, but still PIN code blocked.
The notify_sim_state function needs be changed.

pseudo code:
 If sim_state =3D=3D 0 then =

   if 'AT+CPIN?' returns 'CPIN: SIM PIN' then
     sim_state =3D 'present but sim locked'
   else
     sim_state =3D 'invalid SIM'
   endif
 else if sim_state =3D=3D 255 then
   sim_state =3D 'SIM not present'
 endif

<snip>
>
>It sounds like your firmware never sends us the SIMST unsolicited
>notification.  Can you check whether after sending CFUN=3D1, few seconds
>later ^SYSINFO goes to 1?  See plugins/huawei.c for more details.
>

I don't see any ^SIMST:1 or ^SYSINFO message.

Regards,
Florian

--===============5241549036185386751==--

