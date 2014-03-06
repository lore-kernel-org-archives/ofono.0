Content-Type: multipart/mixed; boundary="===============5337475037905490368=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 23:54:11 -0600
Message-ID: <53180D83.7090600@gmail.com>
In-Reply-To: <5317BB3A.5020808@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5337475037905490368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

 > 3. For the shared case, the driver context code could be optimized to
> recognize that a context being activated has the same apn as an already
> activated context and just mark the new context activated, borrowing the
> 'Settings' from the first.

It might work.  Generally all contexts have their own interface.  The =

reason is that our data transfer counters gather statistics this way. =

You would have to solve this in some way.

>
> So this seems do-able, however it does seem like a fair amount of
> overhead, especially when you start to consider apns that are configured
> for more than just "default" & "mms" ( "dun" and "supl" are other types
> supported in apns-conf ).

Do you have any idea what these are used for by any chance?

>
> This precludes creation of apn types that don't match current ofono
> types ( eg. "dun" & "supl" ).  Neither of these are all that important
> to us currently, however if that changes, we'd have a problem supporting
> them without adding new types.
>

Cross that bridge when you come to it.

> Sure, although I have no doubts this will be easy given some of the
> competing opinions.  ;)

Things are never easy :)  oFono has been developed with careful =

attention to detail, so touching core parts of the design requires some =

care.  Don't let this be discouraging, oFono maintainers are actually =

rather helpful.

>
> I think the most minimal implementation of shared contexts would be apns
> that support just INET and MMS.  Unless I'm wrong, I think my changes
> that make it allow-able for MessageCenter and MessageProxy to be set on
> a either context type accomplish this.  None of my other changes are
> required for this type of minimal sharing.

There is just one snag.  Applications are not supposed to use =

MessageProxy directly.  Instead they should be using Settings.Proxy. =

This can probably be solved somehow..

>
> Other than "types" ( which has already been discussed ), the only two
> that might make immediate sense are "authtype" ( ie. none, PAP, CHAP,
> both ) and "roaming_protocol"?

I've looked into authtype before.  I think there might be 1 or two =

operators in this world who still require this.  It is a very broken =

design on their part.  If you really, truly need this, it can be added.

What does roaming_protocol do?  Remember, oFono is managing the roaming =

logic internally.

>
> I guess from my perspective it felt wrong to just throw away all of
> these extra attributes while provisioning, and thus the dictionary
> property was an approach to preserve them without being too intrusive (
> although the settings code did complicate things a little ).
>
> Also precedence, as there's additional apn information from mbpi which
> is ignored during provisioning ( <plan>, <usage>, <dns> ).

Just because this information is in the database, doesn't mean it is =

actually required by oFono.

>
>>> "types" is especially important, as without it, we can't tell exactly
>>> which services are supported by the APN ( as the plugin sets the type to
>>> TYPE_INTERNET ).
>>
>> As mentioned above, you'd simply create multiple contexts with the same
>> APN and different types if you wanted to accomplish this easily.
>
> Understood, although the resulting number of contexts could result in
> overload to a user if exposed in a settings UI.

I don't call 2 contexts an overload.  If you have more than 1 of a =

particular type (e.g. internet / mms) then the user should probably get =

to choose one from a list using a UI.  This is where that <plan> and =

<usage> info might be useful; to give some context to the user.

Regards,
-Denis

--===============5337475037905490368==--

