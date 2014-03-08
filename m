Content-Type: multipart/mixed; boundary="===============5381045926881871900=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Fri, 07 Mar 2014 19:30:02 -0500
Message-ID: <531A648A.3020108@canonical.com>
In-Reply-To: <F9C0146E-49B5-41AA-9697-FB57B9846155@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5381045926881871900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/05/2014 09:41 PM, Marcel Holtmann wrote:
> Hi Tony,
>
>>>> We've been working on MMS support for Ubuntu Touch recently and have r=
un into a couple of stumbling blocks, so I have a few questions about the c=
urrent MMS logic in oFono ( we're still 1.12 based ), and in particular the=
 provisioning/management of gprs-contexts.
>>>>
>>>> As part of this work, we're planning to switch from using the builtin =
gprs 'provision' plugin, to the new android-provision/apndb plugin ( origin=
ally written by Simon Busch ) which uses the file apns-conf.xml instead of =
mbpi's serviceproviders.xml.
>>>>
>>>> There are a couple of issues we ran into...
>>>>
>>>> 1. How to represent APNs that support multiple usages types?
>>>>
>>>> The "type" attribute in apns-conf.xml is a list vs. the single type de=
fined by a gprs_context.
>>>>
>>>> The android-apndb plugin uses TYPE_INTERNET for APNs which support mul=
tiple types.  In order to properly support MMS, the core code needed to be =
modified to allow the MMS properties to be additionally be set on a TYPE_IN=
TERNET context.  Thus if an APN supports both Internet and MMS, our Downloa=
dManager can grab the additional MMS properties from the context and handle=
 MMS traffic.
>>>>
>>>> Now perhaps I missed something and there is a way to represent a combi=
ned usage APN ( maybe using TYPE_ANY? ), but I couldn't see how to accompli=
sh without changes to the core gprs code.
>>>>
>>>> 2. No way to disable core ofono TYPE_MMS network config.
>>>>
>>>> The core gprs_context code has special logic for TYPE_MMS contexts whi=
ch configures the HTTP proxy using networking ioctl requests.  We have an e=
xternal download manager that handles the actual download of content from t=
he message center.  As it has logic to handle HTTP proxies already, if we u=
se TYPE_MMS, we'd need a way to disable ofono's builtin logic.
>>>
>>> you do realize that these are not actually standard HTTP proxies. You a=
re suppose to talk to the MMS Proxy to reach the MMSC. That is how this wor=
ks. You always go through the MMS Proxy.
>>
>> I haven't actually worked directly on the proxy support myself, and had =
assumed this was a standard HTTP proxy.  I will make sure my co-worker hand=
ling the support in our download manager realizes this, and point him at mm=
sd/connman's GWeb code for reference.
>>
>>> If you are mixing Internet proxies with MMS proxies, you end up in a re=
ally awkward configuration later down the road.
>>
>> Sorry, no intentions of mixing them.
>>
>>> As Denis mentioned we have been using this successfully within mmsd tha=
t we wrote.
>>
>> I saw that, we originally did a bunch of work with mmsd, however we deci=
ded instead to add MMS capability to our ubuntu-download-manager used in To=
uch.
>
> feels weird if a download manager handles delivery receipts and read rece=
ipts. Especially since there are so many MMS specific header in the HTTP re=
quest.

>>> The current design of oFono works just fine by activating the
>>> MMS context and then talking to the MMS proxy to reach the MMSC.
>>
>> Sure, although as I mentioned orginally, if we already have an active da=
ta connection and the apn happens to also support MMS, it seems odd not bei=
ng able to share.
>
> If you have an active data connection you can just compare the TYPE_MMS c=
ontext details (APN, username, passed)
> with the TYPE_INTERNET context ones and if they match, you choose not to =
activate the MMS one and just use the
> Internet one.

Sure, this is along the lines of what Denis suggested, however it does =

seem like a lot of overhead, when in theory the addition of MMS =

properties to a TYPE_INTERNET context would allow it be used for MMS.

> As I said in the other emails, oFono is activating contexts only on reque=
st.

Ack

> So either ConnMan requests theInternet context or mmsd requests the MMS c=
ontext. oFono is not in the =

business of
> magically activating contexs. It only attaches to the GPRS part of the ne=
twork.

I'm not proposing any kind of auto-activation either.  In our case it's =

NetworkManager that's responsible for activating one or more contexts =

for Internet and MMS on-demand when needed.

Again this is also dependent on our disabling ( probaly via a configure =

option ) the ofono MMS IP addr/static route code.  I will discuss this =

again with our NM maintainer though,

> The only problem with the Internet context usage for MMS is that you now =
also have to talk to ConnMan to figure out when the IP part of the context =
is successfully configured.

Well again, as we have Network Manager handling context activation, I =

don't think is an issue for us.

That said, in a default configuration where ConnMan is being used, =

couldn't ofono still setup the static route to the mms proxy if the =

context was combined, and let ConnMan do the rest?

> And here is where this gets complicated. And active context does not mean=
 it is actively in use. You might actually use your WiFi and have an activa=
ted Internet context, but neither the IP or routing is set.
> Or in same case you are just on WiFi and have no Internet context activat=
ed.

If the Internet context is not activated due to insufficient signal, or =

mobile data is disabled, then all bets are off for MMS, and even we =

tried to activate an independent context in this case, it would fail.

If the Internet context is active, but WiFi was subsequently activated =

and is set as the default route, the static route to the MMS proxy =

should still be available for MMS messages.

I will review again internally to ensure we've covered our bases here.

> As you can see this can get extremely complex.

No argument there.

> We opted for just providing a MMS context type and an Internet context ty=
pe. If the APN happens to be the same (not always the case btw.) then you j=
ust double activate that context. Send or receive your MMS and deactivate i=
t.
> We have used this just fine. And in that case oFono does all the heavy li=
fting for you. You just need to talk to the MMS Proxy address that has been=
 configured. That is it.'

As explained in a previous reply to Denis, double-activating the same =

context may not result in a new interface when talking to a rild =

implementation.

If we were to stay with this default behavior ( which I still would like =

to avoid by use of shared MMS/INET contexts ), we'd have to implement =

logic discussed previously ( ie. check for an already active context =

with the same APN/username/pw in the rilmodem ).

Thanks again for your comments/feedback Marcel.

Regards,
/tony







--===============5381045926881871900==--

