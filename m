Content-Type: multipart/mixed; boundary="===============2472456453259008792=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH 2/3] atmodem: add a huawei hack to check attachment status
Date: Mon, 26 Apr 2010 13:44:00 +0300
Message-ID: <87hbmysdcf.fsf@potku.valot.fi>
In-Reply-To: <201004231050.34095.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2472456453259008792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

>> > shouldn't be polling AT+CGREG? the better way to do this?
>> =

>> Most probably, I'll try with that command and test how it goes.
>> =

>> But is polling acceptable way to do this? And is there anything else I
>> could do except poll? I'm open to all suggestions.
>> =

>
> These devices are sometimes quite weird, especially if they have multiple =

> ports.  Sometimes unsolicited notifications are not sent to a particular =
port, =

> and that port is for control only.  This could be the case here...

Bingo! I did some testing with cgatt and saw this on the third serial
interface:

^BOOT:38645652,0,0,0,87                                                    =
     =

                                                                           =
     =

^RSSI:18                                                                   =
     =

                                                                           =
     =

+CGREG: 0,00,0                                                             =
     =

                                                                           =
     =

^RSSI:18                                                                   =
     =

                                                                           =
     =

^RSSI:18                                                                   =
     =

                                                                           =
     =

^RSSI:18                                                                   =
     =

                                                                           =
     =

^RSSI:15                                                                   =
     =

                                                                           =
     =

+CGREG: 1,5AA,5578                                                         =
     =

                                                                           =
     =

^RSSI:18                                         =


I'll cook up something to use this.

-- =

Kalle Valo

--===============2472456453259008792==--

