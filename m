Content-Type: multipart/mixed; boundary="===============7501890675580477133=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Howto about Qt QML and Ofono
Date: Thu, 22 Jul 2010 22:21:30 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473274AB1F1@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C484809.6090000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7501890675580477133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthias, =


>>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-1/
>>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-2/
>>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-3/
>>>
>>> I hope this helps people out there to create cool new phone
>>> applications. You're welcome to leave a note here or on the howto direc=
tly.
>>>
>>
>> Your lovely program gives a good demo on how to writing an application b=
ased on
>oFono. oFono does claim it will help on building application in a convenie=
nt way, so
>the prosperity of application will definitely bring feedback to oFono and =
make oFono
>grow better.
>> I have two comments on your first part: 1) configure is not in the git t=
ree of oFono, so
>we will use bootstrap-configure instead. 2) I'm sure your phonesim works w=
ell. But we
>also have another phonesim derived from your repo, which we had some modif=
ication
>and enhancement in. The repo is
>"git://git.kernel.org/pub/scm/network/ofono/phonesim.git". The building co=
mmand is
>same as oFono, and the execution command is "./phonesim -p 12345 -gui
>src/default.xml".
>
>Thanks Yang, I've added the ./bootstrap command to the listing. I also
>wrote down a hint to the ofono branch of phonesim.

"bootstrap-configure" is a single script, rather than two different ones. =


Regards,
-Yang

--===============7501890675580477133==--

