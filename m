Content-Type: multipart/mixed; boundary="===============2889421915624852583=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] atmodem: Probe device for previous APN.
Date: Mon, 03 Dec 2012 22:41:38 -0600
Message-ID: <50BD7F02.8050900@gmail.com>
In-Reply-To: <20121206025456.GC4235@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2889421915624852583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Forest,

On 12/05/2012 08:54 PM, Forest Bond wrote:
> Hi Marcel,
>
> Thanks for your message.
>
> On Thu, Dec 06, 2012 at 12:12:26AM +0100, Marcel Holtmann wrote:
>> Hi Forest,
>>
>>> If the device has retained parameters for a previously defined IP
>>> context, is is probed via AT+CGDCONT?.
>>
>> this is really not a good idea. The AT+CGDCONT? settings are on a per
>> device basis. That is not how oFono actually works. It operates on a per
>> SIM card basis. And since you do not know to what SIM card these
>> previous settings apply to, the only sensible thing to do is to ignore
>> them.
>
> Okay, I was not aware of this.  But surely the common case (i.e. the only=
 one
> I've personally seen) is to have a single SIM card per device, and under =
those
> limited circumstances it is safe to assume that the settings are valid fo=
r that
> SIM.  Would it be reasonable to implement such a fallback for this more l=
imited
> case?
>

I admit your approach did make me chuckle for being so unorthodox :) =

However, I think your perception is slightly wrong, there are people who =

switch sim cards like crazy (e.g. frequent travelers) so this form of =

provisioning is not really a good idea in those cases.

>> You do know that oFono does keep its settings per SIM card persistent.
>> So no matter what device you enter that SIM card into, the settings will
>> be available the next time you try to connect. So it is a one time
>> configuration option.
>
> Yes, I do know this.  But it's just not a great fit for our use case.
>
> We're using ConnMan and oFono to manage networking for computing applianc=
es
> (e.g. interactive kiosks and digital signs).  These are typically deploye=
d in
> fleets of anywhere from 10 to 10,000 units.  Clearly we do not want to ma=
nually
> configure an APN for each machine. ;)
>
> Ideally, we try to use a single configuration for the entire fleet to kee=
p the
> fleet easy to manage.  But for a variety of business and technical reason=
s,
> multiple service providers may be used within a given fleet.  So we can't=
 simply
> provision a single APN for the entire fleet.  What we really want is to b=
e able
> to plug a modem into the machine and it will Just Work.
>
> So we'd like to choose the right APN based solely on information from the=
 modem.
> I've observed that modems tend to arrive with an IP context pre-configured
> (including the correct APN).  I assume the service provider sets this as =
part of
> some internal provisioning process.  Perhaps it is not safe to assume tha=
t this
> will be the case with the majority of devices and/or providers.  On the o=
ther
> hand, if it is, it seems sensible to make use of that data.
>
> The alternative to pulling the data from the device is to provide a mecha=
nism
> for specifying the APN policy for a particular fleet.  (At least in theor=
y the
> APN selection policy can vary from one fleet to the next.)  I assume this=
 would
> be implemented as a custom provisioning plugin that either hard-codes the=
 policy
> for the fleet, or provides a configuration mechanism that is flexible eno=
ugh to
> accommodate the needs of most fleets (probably using a provider ->  APN m=
apping,
> assuming we can guess the provider e.g. using the mobile-broadband-provid=
er-info
> database).

I'm getting lost, why is the default mobile-broadband-provider-info =

plugin not good enough?  And why don't you simply create your own =

database based on the providers you are targeting?  To me it seems like =

you need X entries for all X providers you have.  Unless the settings =

vary within a given provider somehow?

Regards,
-Denis

--===============2889421915624852583==--

