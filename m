Content-Type: multipart/mixed; boundary="===============7421417866317490830=="
MIME-Version: 1.0
From: Andrea Galbusera <gizero@gmail.com>
Subject: Re: Getting started (serial GPRS modem)
Date: Wed, 12 Sep 2012 19:31:35 +0200
Message-ID: <CAC+thW3oXq=3thd0q05S-R-i7WQ2z-gZipFSi5OkTsGuncTgiw@mail.gmail.com>
In-Reply-To: <159F4FBE0126984EABAC4A5C555EDE13297CF441@srv-its-xch02.tmt.telital.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7421417866317490830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniele,

On Wed, Sep 12, 2012 at 5:55 PM, Daniele Palmas
<Daniele.Palmas@telit.com> wrote:
> Hi Erik,
>
> Da: ofono-bounces(a)ofono.org [ofono-bounces(a)ofono.org] per conto di Er=
ik [stimpit(a)gmail.com]
> Inviato: mercoled=C3=AC 12 settembre 2012 10.40
> A: ofono(a)ofono.org
> Oggetto: Re: Getting started (serial GPRS modem)
>
>> I found Android's reference-ril code (not trying to offend anyone, not s=
ure
>> about any potential religious wars going on here) which seems really
>> simple. I'll see if that might suit my immediate needs better. But I hav=
en't
>> written off ofono yet.
>
> The reference-ril code is indeed simple to customize, but consider that m=
ost of the intelligence in the Android RIL is in the Java layer.

Nice to see @telit.com people listening to this list! ;-) Me and most
actively some other guys are working with ofono and Telit devices.

On my side, the reason I started looking at ofono was that using a
modem in Linux for embedded "the old way" (mgetty, ppp, etc...) was
getting too limiting and frustrating. On the other hand, developing
all that FSM stuff on my own was too much work and I'd even ended up
with something probably too coupled with specific hardware. I believe
that the driver architecture ofono is designed on, based on plugins,
will make using modern modems advanced features more affordable.

BTW, is there any interest by Telit to support ofono drivers for their devi=
ces?

--===============7421417866317490830==--

