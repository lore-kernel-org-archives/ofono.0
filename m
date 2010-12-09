Content-Type: multipart/mixed; boundary="===============1880033672080435764=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Attach GPRS on demand
Date: Thu, 09 Dec 2010 04:12:00 -0600
Message-ID: <4D00AB70.10701@gmail.com>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC030131@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1880033672080435764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 12/09/2010 03:57 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis,
> =

>>> I'm not quite sure what you mean here. There are many =

>> different cases, where the network can detach a UE from GPRS =

>> service. See possible detach causes in 24.008. Currently, =

>> oFono does not recover at all. Trying to figure out when GPRS =

>> is again available can get pretty complicated and the =

>> different detach causes require different handling. IMO, the =

>> simplest approach by far is to retry GPRS attach when someone =

>> actually needs a PDP context. =

>>
>> So here's the problem, ConnMan is in charge of activating the =

>> context on
>> Meego.  ConnMan activates the context once we're attached.  So how do
>> you expect your 'on-demand' re-attach to work exactly?
> =

> ConnMan really should not care whether we are attached or not. Why do you=
 need a trigger in ConnMan, anyway? As far as I can see, a GPRS connection =
should only be activated if some client of ConnMan requests it.

Actually it should care.  We do safe-guard against attaching while
roaming...

Besides, ConnMan doesn't really work this way.  Maybe in the future with
the session API it would be able to, but not at the moment.  I'll let
Marcel explain this more if he wants too..

> =

>> Besides, 24.008 cause codes give us plenty of hints of =

>> whether / when to
>> re-attach, and only a few of them require 'special' handling.
>>
>> I still think that we should come up with some strategy to re-attach
>> automatically when detached by the network.
> =

> Even if you can come up with an algorithm, testing it is very very challe=
nging. There are plenty of differences in operator networks and it is very =
difficult to cover all cases. Making sure that the algorithm works requires=
 extensive IOT and Field testing. We really don't want a case, where oFono =
fails to re-attach for whatever reason. We also don't want the case where o=
Fono has not yet attempted to re-attach (e.g. on a timer) and a PDP context=
 activation fails, even though GPRS would actually be available.
> =

> For the above reasons, retrying attach on PDP context activation makes se=
nse as a safe-guard, regardless of whether we have a re-attach algorithm or=
 not. We use on-demand attach in pretty much all our products (except for c=
ertain operator specific variants) precisely because it is certain to work.=
 No funny business. If there is GPRS service, you get a connection. It is a=
lso an approach that should work with any AT modem as well.
> =


You might be right, but I'd really like to see whether the re-attach
algorithm would be good enough first...

Regards,
-Denis

--===============1880033672080435764==--

