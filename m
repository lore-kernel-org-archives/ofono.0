Content-Type: multipart/mixed; boundary="===============8935902577176816495=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Attach GPRS on demand
Date: Thu, 09 Dec 2010 03:22:09 -0600
Message-ID: <4D009FC1.2050909@gmail.com>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC03000F@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8935902577176816495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 12/09/2010 02:12 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis,
> =

>>> With these patches, GPRS context activation will cause oFono to
>>> automatically attempt GPRS attach if the modem is presently =

>> detached.
>>>
>>
>> Before I look at these patches: Have you considered fixing the attach
>> behavior instead?
> =

> I'm not quite sure what you mean here. There are many different cases, wh=
ere the network can detach a UE from GPRS service. See possible detach caus=
es in 24.008. Currently, oFono does not recover at all. Trying to figure ou=
t when GPRS is again available can get pretty complicated and the different=
 detach causes require different handling. IMO, the simplest approach by fa=
r is to retry GPRS attach when someone actually needs a PDP context. =


So here's the problem, ConnMan is in charge of activating the context on
Meego.  ConnMan activates the context once we're attached.  So how do
you expect your 'on-demand' re-attach to work exactly?

Besides, 24.008 cause codes give us plenty of hints of whether / when to
re-attach, and only a few of them require 'special' handling.

I still think that we should come up with some strategy to re-attach
automatically when detached by the network.

Regards,
-Denis

--===============8935902577176816495==--

