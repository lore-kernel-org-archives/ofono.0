Content-Type: multipart/mixed; boundary="===============2132175309251206380=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono LTE modems and connman services
Date: Mon, 26 Feb 2018 10:12:27 -0600
Message-ID: <4a5f9819-3efc-20ed-4080-e958bafabf2a@gmail.com>
In-Reply-To: <0643a0f2-e7ab-3b6e-30b3-d922ba325dbb@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2132175309251206380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 02/26/2018 08:37 AM, Jonas Bonn wrote:
> The following issue is causing us some grief and I really need some =

> guidance on how to approach this.=C2=A0 This is being sent to both the of=
ono =

> and connman mailing lists because it's not really clear to me who's =

> doing the right/wrong thing here...
> =

> The connman ofono plugin does the following:
> i)=C2=A0 It powers up (enables) the modem
> ii)=C2=A0 If cellular tech is enabled, it brings the modem online
> =

> For an LTE-modem, this second step results in a default bearer being =

> attached and thereby the modem is 'connected'.=C2=A0 The third connman st=
ep, =

> setting the ofono context to Active, is not required for LTE; the =

> context becomes 'Active=3Dtrue' right away.
> =

> The above effectively means that it's not possible to have an LTE modem =

> that does not auto-connect (in connman terms).
> =


There are multiple possible scenarios here, the two most common ones are:

1. Default attach APN is an internet context
2. Default attach APN is an IMS context

The network provider usually behaves in way 1 or 2 above.  We can =

control the default attach context to some degree by using =

org.ofono.LongTermEvolution.DefaultAccessPointName

For this to work nicely you really need automatic context provisioning =

to work so that the various APN types are known ahead of time.

Either way, when the context is auto activated by the modem it should =

tell what APN ended up being used.  Ideally that APN _should_ match one =

of the provisioned contexts.

> Now the APN that ofono sets on the LTE context is 'automatic'; that was =

> selected because connman _requires_ some APN or else it ignores the =

> context altogther.

That would seem to be a driver issue.  drivers/qmimodem/gprs-context.c =

even has a TODO entry in there...

> =

> If the modem roams away from LTE connectivity and wants to fallback to =

> UMTS/GSM, it needs another context with a valid APN.=C2=A0 So now the mod=
em =

> has two 'internet' contexts ('automatic' and APN) which connman presents =

> as two distinct services.
> =


This is obviously wrong.  If the modem roams onto 3G then the contexts =

should be preserved.  There should still be a single internet context...

> These two services, as far as I can tell, end up competing with each =

> other when connecting and a mess ensues... if the lower numbered context =

> is the 3G context, connman goes into an endless loop attempting to set =

> it Active and continuously failing when the tech switches to LTE.
> =


Yeah, no wonder...

> The question is, what are the expectations here:
> i)=C2=A0=C2=A0 What does it mean for connman to see two 'internet' contex=
ts since =

> it sets up two services for them?
> ii)=C2=A0 How is a modem supposed to roam between LTE and UMTS/GSM networ=
ks =

> when one requires an APN and the other does not.
> iii) Not auto-connecting an LTE modem means not bringing it online; what =

> implications does this have for connman?
> =

> The above is currently a bit of a confusing mess and both ofono and =

> connman get themselves tied in a knot when the modem switches between =

> LTE and non-LTE techs.=C2=A0 Any guidance on how to approach this would b=
e =

> appreciated.
> =


The answer is to just fix your oFono driver.

Regards,
-Denis

--===============2132175309251206380==--

