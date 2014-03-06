Content-Type: multipart/mixed; boundary="===============0275758007555801488=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 19:03:06 -0500
Message-ID: <5317BB3A.5020808@canonical.com>
In-Reply-To: <5316965A.5070902@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0275758007555801488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/04/2014 10:13 PM, Denis Kenzior wrote:
> Hi Tony,
>
>  > Now perhaps I missed something and there is a way to represent a
>> combined usage APN ( maybe using TYPE_ANY? ), but I couldn't see how to
>> accomplish without changes to the core gprs code.

Thanks for the reply Denis.

> oFono is not designed to handle combined usage APNs.

Understood...

> If the APN for MMS
> and Internet is the same, we would simply 'double-activate' the same APN
> using multiple contexts. e.g. you would have an Internet context and an
> MMS context with the same APN.  This of course requires your underlying
> modem driver to be able to use multiple contexts simultaneously (e.g.
> multiple gprs_context atoms present.)

OK, applying this logic to the apns-conf db ( I'll get to Marcel's =

second reply focused on this apns shortly ):

1. The provision plugin would need to create separate contexts for each =

type found in an apn's "type" attribute.  This would work when there are =

exact matches between ofono and the apn types ( eg. default=3Dinternet, mms=
 ).

2. Regarding multiple contexts supported in the rilmodem.  We're =

planning on doing this anyways, as we need to support the case where a =

MMS apn is stand-alone.

3. For the shared case, the driver context code could be optimized to =

recognize that a context being activated has the same apn as an already =

activated context and just mark the new context activated, borrowing the =

'Settings' from the first.

So this seems do-able, however it does seem like a fair amount of =

overhead, especially when you start to consider apns that are configured =

for more than just "default" & "mms" ( "dun" and "supl" are other types =

supported in apns-conf ).

This precludes creation of apn types that don't match current ofono =

types ( eg. "dun" & "supl" ).  Neither of these are all that important =

to us currently, however if that changes, we'd have a problem supporting =

them without adding new types.


> If you want to go through the trouble of adding hybrid behavior, then
> patches are welcome.

Sure, although I have no doubts this will be easy given some of the =

competing opinions.  ;)

I think the most minimal implementation of shared contexts would be apns =

that support just INET and MMS.  Unless I'm wrong, I think my changes =

that make it allow-able for MessageCenter and MessageProxy to be set on =

a either context type accomplish this.  None of my other changes are =

required for this type of minimal sharing.

I think the larger question of whether this should be more generic has =

yet to be answered...

>> 2. No way to disable core ofono TYPE_MMS network config.
>>
>> The core gprs_context code has special logic for TYPE_MMS contexts which
>> configures the HTTP proxy using networking ioctl requests.  We have an
>> external download manager that handles the actual download of content
>> from the message center.  As it has logic to handle HTTP proxies
>> already, if we use TYPE_MMS, we'd need a way to disable ofono's builtin
>> logic.
>>
>> Would it make sense to add a command-line option to control this
>> behavior?
>
> oFono only sets up a route and runs the equivalent of ifconfig.  It
> doesn't do any proxying.

Got it, I guess I got confused by the function gprs.c::pri_setproxy() =

which sets up a host route for the proxy if configured.  As per Marcel's =

first reply, a proxy is always used for MMS downloads so this will =

always occur.

> This logic is there because ConnMan explicitly
> ignores contexts of type=3Dmms.  So someone must take care of bringing up
> the interface, assigning IP, etc.

Sure, makes sense.  In our case, we'd decided to have NetworkManager =

handle this work for INET or MMS contexts, so again it would be nice if =

this behavior were configurable.

> You might also want to check out the mmsd project since that already
> works with oFono.

We initially had planned to use mmsd, however decided to extend our =

exisitng Download Manager to support downloading MMS content.

>> 3. No way to associate additional APN properties with a gprs_context.
>>
>> apns-conf.xml has many additional APN attributes which don't map
>> directly to gprs_context properties ( eg. authtype, mvno_type, ... ).
>>
>
> If you have usecases in mind for some of these properties, feel free to
> suggest extensions to the oFono API.

Other than "types" ( which has already been discussed ), the only two =

that might make immediate sense are "authtype" ( ie. none, PAP, CHAP, =

both ) and "roaming_protocol"?

I guess from my perspective it felt wrong to just throw away all of =

these extra attributes while provisioning, and thus the dictionary =

property was an approach to preserve them without being too intrusive ( =

although the settings code did complicate things a little ).

Also precedence, as there's additional apn information from mbpi which =

is ignored during provisioning ( <plan>, <usage>, <dns> ).

>> "types" is especially important, as without it, we can't tell exactly
>> which services are supported by the APN ( as the plugin sets the type to
>> TYPE_INTERNET ).
>
> As mentioned above, you'd simply create multiple contexts with the same
> APN and different types if you wanted to accomplish this easily.

Understood, although the resulting number of contexts could result in =

overload to a user if exposed in a settings UI.

Regards,
/tony





--===============0275758007555801488==--

