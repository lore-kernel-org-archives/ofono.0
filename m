Content-Type: multipart/mixed; boundary="===============0332909745455225964=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: Re: Howto about Qt QML and Ofono
Date: Thu, 22 Jul 2010 12:11:34 -0300
Message-ID: <AANLkTinmdxG-ALgn1pHPI1KaCE2bdpgT3AFAosV2X9Jp@mail.gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A473274AB1F1@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0332909745455225964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 22, 2010 at 11:21, Gu, Yang <yang.gu@intel.com> wrote:
> Hi Matthias,
>
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
>>oFono. oFono does claim it will help on building application in a conveni=
ent way, so
>>the prosperity of application will definitely bring feedback to oFono and=
 make oFono
>>grow better.
>>> I have two comments on your first part: 1) configure is not in the git =
tree of oFono, so
>>we will use bootstrap-configure instead. 2) I'm sure your phonesim works =
well. But we
>>also have another phonesim derived from your repo, which we had some modi=
fication
>>and enhancement in. The repo is
>>"git://git.kernel.org/pub/scm/network/ofono/phonesim.git". The building c=
ommand is
>>same as oFono, and the execution command is "./phonesim -p 12345 -gui
>>src/default.xml".
>>
>>Thanks Yang, I've added the ./bootstrap command to the listing. I also
>>wrote down a hint to the ofono branch of phonesim.
>
> "bootstrap-configure" is a single script, rather than two different ones.
>

There is a bootstrap script also, and bootstrap-configure basically
runs it and then runs configure with a pre-set of switches.

-- =

Jo=C3=A3o Paulo Rechi Vita
http://jprvita.wordpress.com/

--===============0332909745455225964==--

