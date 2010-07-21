Content-Type: multipart/mixed; boundary="===============0659792762590837651=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Howto about Qt QML and Ofono
Date: Wed, 21 Jul 2010 16:15:26 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473272A2B61@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C4557F4.2060907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0659792762590837651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Matthias G=C3=BCnther
>Sent: Tuesday, July 20, 2010 4:02 PM
>To: qt-qml(a)trolltech.com; ofono(a)ofono.org
>Subject: Howto about Qt QML and Ofono
>
>Hi all together.
>
>I wrote a little howto about how to use Ofono with Phonesim in the back
>and a Qt application as frontend. The Qt applicatin is devided into two
>parts, the C++ part where all the D-Bus stuff is handled and the QML
>part where you can use C++ methods to e.g. activate the Ofono modem or
>do something when an Ofono signal is recieved. The howto is separated
>into three parts:
>
>>http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-1/
>>http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-2/
>>http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-3/
>
>I hope this helps people out there to create cool new phone
>applications. You're welcome to leave a note here or on the howto directly.
>

Your lovely program gives a good demo on how to writing an application base=
d on oFono. oFono does claim it will help on building application in a conv=
enient way, so the prosperity of application will definitely bring feedback=
 to oFono and make oFono grow better. =

I have two comments on your first part: 1) configure is not in the git tree=
 of oFono, so we will use bootstrap-configure instead. 2) I'm sure your pho=
nesim works well. But we also have another phonesim derived from your repo,=
 which we had some modification and enhancement in. The repo is "git://git.=
kernel.org/pub/scm/network/ofono/phonesim.git". The building command is sam=
e as oFono, and the execution command is "./phonesim -p 12345 -gui src/defa=
ult.xml".


Regards,
-Yang

--===============0659792762590837651==--

