Content-Type: multipart/mixed; boundary="===============8319780078438828902=="
MIME-Version: 1.0
From: Yoon, Youngsik <youngsik.yoon@intel.com>
Subject: RE: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 09:37:54 +0800
Message-ID: <E63C5DDBF9FA424AB501A4C5647901434C1CBD3974@pgsmsx506.gar.corp.intel.com>
In-Reply-To: <COL106-W45938FF91C5687A044DD75F6F60@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8319780078438828902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

As you might know, phonesim is emulator. it acts like modem.
(you don't need real modem to use phonesim)
So you need to power up the modem(phonesim) to use it.

You already did following procedure.
1. ofono-phonesim -p 12345 -gui ~/data/moblin.xml
2. sudo ofonod -nd =


And then, you need to type following command to power up modem(phonesim).
3. dbus-send --system --print-reply --dest=3Dorg.ofono / phonesim0 org.ofon=
o.Modem.SetProperty string:Powered variant:boolean:true

Thanks,
Yoon

From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of krishna k
Sent: Friday, May 07, 2010 10:07 PM
To: ofono(a)ofono.org
Subject: FW: How to start ofono-phonesim in ubuntu-10.04 -reg

Hi Andrew,

Thank you very much. I am not using real modem. I am using E71. If i want t=
o use =

Phonesim emulator with gui (With out connecting E71). Can you please suggest
how to proceed? Am I need to connect with Real Modem? If it is the case can
you please suggest what are the modem types supported by ofono-phonesim emu=
lator.


Thanks and Regards,
Krishna K Kandula.

You're talking about two things here: using a real modem, and using
phonesim.  Phonesim emulates a modem, so you don't need the E71.  Or
you can use the E71 (like you did) and then you don't need phonesim
and no gui.
 =

Best regards,
Andrew
 =


________________________________________
Catch the changing security environment Get it now.

--===============8319780078438828902==--

