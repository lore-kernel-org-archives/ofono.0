Content-Type: multipart/mixed; boundary="===============4108765916010458253=="
MIME-Version: 1.0
From: Matthias =?unknown-8bit?q?G=C3=BCnther?= <matgnt@gmail.com>
Subject: Re: Howto about Qt QML and Ofono
Date: Thu, 22 Jul 2010 15:30:49 +0200
Message-ID: <4C484809.6090000@gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A473272A2B61@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4108765916010458253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


>> I wrote a little howto about how to use Ofono with Phonesim in the back
>> and a Qt application as frontend. The Qt applicatin is devided into two
>> parts, the C++ part where all the D-Bus stuff is handled and the QML
>> part where you can use C++ methods to e.g. activate the Ofono modem or
>> do something when an Ofono signal is recieved. The howto is separated
>> into three parts:
>>
>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-1/
>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-2/
>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-3/
>>
>> I hope this helps people out there to create cool new phone
>> applications. You're welcome to leave a note here or on the howto direct=
ly.
>>
> =

> Your lovely program gives a good demo on how to writing an application ba=
sed on oFono. oFono does claim it will help on building application in a co=
nvenient way, so the prosperity of application will definitely bring feedba=
ck to oFono and make oFono grow better. =

> I have two comments on your first part: 1) configure is not in the git tr=
ee of oFono, so we will use bootstrap-configure instead. 2) I'm sure your p=
honesim works well. But we also have another phonesim derived from your rep=
o, which we had some modification and enhancement in. The repo is "git://gi=
t.kernel.org/pub/scm/network/ofono/phonesim.git". The building command is s=
ame as oFono, and the execution command is "./phonesim -p 12345 -gui src/de=
fault.xml".

Thanks Yang, I've added the ./bootstrap command to the listing. I also
wrote down a hint to the ofono branch of phonesim.

Best regards,
Matthias

--===============4108765916010458253==--

