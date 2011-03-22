Content-Type: multipart/mixed; boundary="===============7146704303629934082=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] gprs.c: add list contexts for emulator
Date: Tue, 22 Mar 2011 12:24:47 -0500
Message-ID: <4D88DB5F.9070906@gmail.com>
In-Reply-To: <A782C372B9527D44AB20BF45FEEBB14F75BFCC0E03@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7146704303629934082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 03/22/2011 10:17 AM, Aygon, Bertrand wrote:
> Hi Denis,
> =

>>> Thanks Denis for your feedback.
>>> The idea behind this code is to propose the complete support of the
>>> usual AT+CGDCONT in the emulator. I think the best solution might be to
>>> stick on contexts exposed over DBus, but this could lead to problems
>>> like : a context is delete throught the DBus interface... how to handle
>>> this change in the AT emulator, and avoid the use of the deleted contex=
t ?
>>
>> Personally I'm not convinced CGDCONT management is even a good idea.
>> The typical usecase is for DUN clients to send a CGDCONT string, but
>> this can simply be accepted and ignored (for instance).
> =

> We are not looking at DUN only, but to the 'global' AT Emulator, that wil=
l be used during GCF/PTCRB certification.

I know exactly what you want this for.

> During certification, a lot of test require to set some GPRS context with=
 specific parameters. And this cannot go 'directly' to the modem, without g=
oing through AP, because the test would not be relevant, or worse will fail=
ed, due to disconnect between oFono and modem.
> =


And I know this as well ;)  However, I'm still not convinced.  oFono
simply works differently and you will encounter too many problems doing
it this way.  I listed some of them out already...

>> Just overwriting oFono's context store is not a good idea anyway as you
>> lose certain valuable information.  For instance whether this context is
>> used for internet (and ConnMan should pay attention to it) or it is used
>> for mms, etc.
>>
>> It is also possible for the dial up client to provide context details
>> that are identical to a context already defined in oFono.  In which case
>> those details should be used instead (for the reasons outlined in the
>> previous paragraph)
> =

> So from my point of view, all context must be in sync, in oFono side and =
modem side.

The reality is doing so is pretty much a bad idea from a technical point
of view.  So sounds like you're in for some fun ;)

Regards,
-Denis

--===============7146704303629934082==--

