Content-Type: multipart/mixed; boundary="===============8146343004107425614=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Thu, 06 Mar 2014 23:38:25 -0500
Message-ID: <53194D41.7030704@canonical.com>
In-Reply-To: <53180D83.7090600@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8146343004107425614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/06/2014 12:54 AM, Denis Kenzior wrote:
> Hi Tony,
>
>  > 3. For the shared case, the driver context code could be optimized to
>> recognize that a context being activated has the same apn as an already
>> activated context and just mark the new context activated, borrowing the
>> 'Settings' from the first.
>
> It might work.  Generally all contexts have their own interface.  The
> reason is that our data transfer counters gather statistics this way.
> You would have to solve this in some way.

This isn't always true, especially with rilmodem, as we have yet another =

modem abstraction layer in the picture.

 From the testing I've done, many ril implementations seem to also =

optimize this case and just return the same interface/settings when a =

data call is requested for an APN which already has an active call.

>> So this seems do-able, however it does seem like a fair amount of
>> overhead, especially when you start to consider apns that are configured
>> for more than just "default" & "mms" ( "dun" and "supl" are other types
>> supported in apns-conf ).
>
> Do you have any idea what these are used for by any chance?

As we haven't done much with either type, so my rough understanding of =

the two are:

"supl" is used to indicate an APN that supports a Secure User Plane =

Location server ( used for A-GPS ).

"dun" stands for dial-up networking and I believe is used to indicate an =

APN that supports tethering.

They don't seem to be used all that commonly for stand-alone APNs, and =

"supl" by far is the more prevalent of the two ( by ~10:1 ).

>> This precludes creation of apn types that don't match current ofono
>> types ( eg. "dun" & "supl" ).  Neither of these are all that important
>> to us currently, however if that changes, we'd have a problem supporting
>> them without adding new types.
>>
>
> Cross that bridge when you come to it.
>
>> Sure, although I have no doubts this will be easy given some of the
>> competing opinions.  ;)
>
> Things are never easy :)  oFono has been developed with careful
> attention to detail, so touching core parts of the design requires some
> care.  Don't let this be discouraging, oFono maintainers are actually
> rather helpful.

Undersood, and thanks for the encouragement.

>> I think the most minimal implementation of shared contexts would be apns
>> that support just INET and MMS.  Unless I'm wrong, I think my changes
>> that make it allow-able for MessageCenter and MessageProxy to be set on
>> a either context type accomplish this.  None of my other changes are
>> required for this type of minimal sharing.
>
> There is just one snag.  Applications are not supposed to use
> MessageProxy directly.  Instead they should be using Settings.Proxy.
> This can probably be solved somehow..

I'd assumed that mmsd used 'MessageProxy' directly, but after =

re-examination, I see that it's using "Settings.Proxy".

That said in our case if we'd like NetworkManager to handle the route =

configuration, wouldn't it make sense to use 'MessageProxy' directly?  I =

guess I'm not sure I understand the difference between 'Settings.Proxy' =

and 'MessageProxy' as the former seems to be a copy of the latter.

Also, as both 'MessageProxy' and 'MessageCenter' were always handled =

together in the core gprs code, it made sense to make both available for =

combined contexts.

One last point, it looks like the ofono code presumes that a =

'MessageProxy' value is always in IPV4 number-and-dots notation. Some of =

the proxies defined for APNs in apns-conf contain hostnames.  My guess =

is that this would cause problems for a stand-alone MMS APN, but would =

work with a combined context?

>> Other than "types" ( which has already been discussed ), the only two
>> that might make immediate sense are "authtype" ( ie. none, PAP, CHAP,
>> both ) and "roaming_protocol"?
>
> I've looked into authtype before.  I think there might be 1 or two
> operators in this world who still require this.  It is a very broken
> design on their part.  If you really, truly need this, it can be added.

Well... I'm not sure about the "really, truly" part, but again these =

were examples of other attributes which weren't a stretch to see being =

added as direct ofono properties.

Re: authtype specifically, we've seen at one least modem which chokes =

with our default settings for this parameter.  That said, this may have =

been an operator specific behavior...

Looking at a fairly recent apns-conf, there are close to 500 APNs which =

specify authtype, out of a db of ~2000.  As this is a parameter that our =

rilmodem driver could use when setting up a data call, I would say this =

is useful.

> What does roaming_protocol do?  Remember, oFono is managing the roaming
> logic internally.

I believe this represents the protocol ( ip, ipv6, dual ) to use when =

roaming and activating a context.

>> I guess from my perspective it felt wrong to just throw away all of
>> these extra attributes while provisioning, and thus the dictionary
>> property was an approach to preserve them without being too intrusive (
>> although the settings code did complicate things a little ).
>>
>> Also precedence, as there's additional apn information from mbpi which
>> is ignored during provisioning ( <plan>, <usage>, <dns> ).
>
> Just because this information is in the database, doesn't mean it is
> actually required by oFono.

Understood, however some of these attributes might be interesting to =

other processes using ofono to access the contexts which have been =

provisioned ( and persisted on-disk ).

Again, this is the reason I went ahead and added support for an =

ExtraData dictionary that captures all the extra attributes we can't map =

directly to context properties.  This seemed like the least intrusive =

approach to us.  Are all of these additioanl atrributes absoultely =

critical to us right now?  Probably not, but why throw information away?

Also, as Slava from Jolla pointed out, it also might be nice to use this =

mechanism ( or something similar ) to add some additional private data =

to a context, such as "user-selected", or maybe even a "last-connected".

I hadn't gone this far with my implementation ( ie. allowing writes of =

new keys to ExtraData ), as we'd also discussed using some other =

settings store to write this kind of user preference.  That said, if =

most of the other properties can be updated via the DBus interface, it's =

not a huge stretch...

>>>> "types" is especially important, as without it, we can't tell exactly
>>>> which services are supported by the APN ( as the plugin sets the
>>>> type to
>>>> TYPE_INTERNET ).
>>>
>>> As mentioned above, you'd simply create multiple contexts with the same
>>> APN and different types if you wanted to accomplish this easily.
>>
>> Understood, although the resulting number of contexts could result in
>> overload to a user if exposed in a settings UI.
>
> I don't call 2 contexts an overload.  If you have more than 1 of a
> particular type (e.g. internet / mms) then the user should probably get
> to choose one from a list using a UI.  This is where that <plan> and
> <usage> info might be useful; to give some context to the user.

Sure, if we stick to just Internet/MMS, the number could be managable. =

My point was if an operator defined 3-4 APNS, and each was a multi-usage =

APN ( eg. "default,mms,supl" ), then you'd end up with nine contexts ( =

this assumes creation of a SUPL context type ).

At the moment we're really focused on MMS support, and so at minimum we =

want shared contexts to work for Internet and MMS together. This by =

itself I still believe is a worthy goal, and I think it's do-able with =

minor changes to the core.

That said, before I say much more, I need to re-read and respond to =

Marcel's recent emails.  ;)

I appreciate your feedback and thoughts on this.

Thanks,
/tony


--===============8146343004107425614==--

