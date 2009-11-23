Content-Type: multipart/mixed; boundary="===============8654605646232418539=="
MIME-Version: 1.0
From: DJDAS <djdas@djdas.net>
Subject: oFono running on new Freerunner distribution (was: Palm Pre modem
 plugin)
Date: Mon, 23 Nov 2009 12:02:17 +0100
Message-ID: <4B0A6BB9.6050606@djdas.net>
In-Reply-To: <200911230440.14929.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8654605646232418539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior ha scritto:
> Hi Niko,
>   =

>> Nice to hear that. Anyway do not missunderstand, our team is adopting
>> oFono, we are just digging incoming issues with the nogsm part
>> integration!!!
>>
>>     =

>
> Sounds interesting.  Let me know if I can be of assistance :)
>
>   =


Well, maybe you missed some of my previous email in this list some time =

ago :)
I'm the project leader of a new distribution, called NEOPhysis, for the =

Openmoko Freerunner and Niko is the UI team leader.
We are about 10 people in our team and started from scratch creating a =

new distribution which differs from the others, approaching the system =

concept as an embedded low resources device instead of a micro-desktop =

system.
The main focus was not in a "Linux distribution" but in a "Phone with =

advanced capabilities", so as I follow this project since its born, I =

proposed to use oFono as the main telephony stack and FSO for the =

remaining part.
As a proof-of-concept I wrote a "ncurses phone app" which uses oFono to =

do simple calls and ATM I'm able to call a number dialed with the touch =

screen (yes it's very geek! :P ) and I'm finishing the parsing part to =

handle the call status to be able to answer calls.
I asked in my previous emails if someone of the oFono team could send me =

a simple C code because all the test code were written in Python (but =

for the telephony part our focus is speed and reliability so its =

mandatory to use a C/C++ framework/middleware) but received no answer, =

OTOH this let me learn using DBUS and oFono APIs so it was not as bad :)
We put up a build host which produces even an oFono package for the =

OpenEmbedded repository and we are very proud to be the first (AFAIK) to =

use oFono. If you need/want to test oFono on the Freerunner we can =

provide you the packages built each time you need to.
I have just one question: I noticed the Calypso modem registers on the =

network quite slowly (about 1,5-2 mins after powering up) is this =

normal? Can we help you in testing/patching the code to achieve faster =

times (normal phones usually register in seconds).
Thank you very much for your great work, good bye.
Dario.


--===============8654605646232418539==--

