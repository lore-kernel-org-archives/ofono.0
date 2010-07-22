Content-Type: multipart/mixed; boundary="===============6262778741230634928=="
MIME-Version: 1.0
From: Matthias =?unknown-8bit?q?G=C3=BCnther?= <matgnt@gmail.com>
Subject: Re: Howto about Qt QML and Ofono
Date: Thu, 22 Jul 2010 18:23:49 +0200
Message-ID: <4C487095.4050107@gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A473274AB1F1@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6262778741230634928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

>>>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-1/
>>>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-2/
>>>>> http://matgnt.wordpress.com/2010/07/19/qt-ofono-d-bus-and-qml-part-3/
>>>>
>>>> I hope this helps people out there to create cool new phone
>>>> applications. You're welcome to leave a note here or on the howto dire=
ctly.
>>>>
>>>
>>> Your lovely program gives a good demo on how to writing an application =
based on
>> oFono. oFono does claim it will help on building application in a conven=
ient way, so
>> the prosperity of application will definitely bring feedback to oFono an=
d make oFono
>> grow better.
>>> I have two comments on your first part: 1) configure is not in the git =
tree of oFono, so
>> we will use bootstrap-configure instead. 2) I'm sure your phonesim works=
 well. But we
>> also have another phonesim derived from your repo, which we had some mod=
ification
>> and enhancement in. The repo is
>> "git://git.kernel.org/pub/scm/network/ofono/phonesim.git". The building =
command is
>> same as oFono, and the execution command is "./phonesim -p 12345 -gui
>> src/default.xml".
>>
>> Thanks Yang, I've added the ./bootstrap command to the listing. I also
>> wrote down a hint to the ofono branch of phonesim.
> =

> "bootstrap-configure" is a single script, rather than two different ones. =


Thanks for your comment. As mentioned in the thread before, there are
two scripts. The problem with "bootstrap-configure" is, that it enables
the --enable-capng switch which may cause problems. It'll probably end
up in missing files. Therefore I chose "bootstrap" to just create the
configure script and then use it without any configuration arguments -
just the defaults. For the purpose of the howto, the debug switches are
not really necessary.

Best regards,
Matthias

--===============6262778741230634928==--

