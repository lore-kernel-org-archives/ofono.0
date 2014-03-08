Content-Type: multipart/mixed; boundary="===============6098902354417808348=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Fri, 07 Mar 2014 19:23:30 -0500
Message-ID: <531A6302.7060008@canonical.com>
In-Reply-To: <53195BBB.40808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6098902354417808348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/07/2014 12:40 AM, Denis Kenzior wrote:
> Hi Tony,
>
>  >  From the testing I've done, many ril implementations seem to also
>> optimize this case and just return the same interface/settings when a
>> data call is requested for an APN which already has an active call.
>
> Then that will be something for you to solve then.  oFono actually
> expects a different interface entirely for each active context.

My solution was to use a shared context when appropriate and not try to =

start a second data call.  ;)

>> I'd assumed that mmsd used 'MessageProxy' directly, but after
>> re-examination, I see that it's using "Settings.Proxy".
>>
>> That said in our case if we'd like NetworkManager to handle the route
>> configuration, wouldn't it make sense to use 'MessageProxy' directly?  I
>> guess I'm not sure I understand the difference between 'Settings.Proxy'
>> and 'MessageProxy' as the former seems to be a copy of the latter.
>
> It is due to historical / design reasons.  Using Settings.Proxy would
> allow us to run a local proxy instead of relying on the remote Proxy.
> This allows extra flexibility in the future.  Whether this is still
> something we need can be discussed.

OK, thanks for the explanation.

>> One last point, it looks like the ofono code presumes that a
>> 'MessageProxy' value is always in IPV4 number-and-dots notation. Some of
>> the proxies defined for APNs in apns-conf contain hostnames.  My guess
>> is that this would cause problems for a stand-alone MMS APN, but would
>> work with a combined context?
>
> Since for MMS contexts the only route is via a proxy, DNS resolution is
> impossible.  MessageProxy has to be an ipv4 address.

That's what I assumed after looking at the code, but appreciate the =

confirmation.  This might be a good addition to the API documentation ( =

connman-api.txt ).

> For combined contexts this might be relaxed.

And that's certainly what looks to be the case in apns-conf ( ie. =

mmsproxys specified with hostnames only appear for shared contexts, =

although some still use ipv4 addresses. ).

>> Re: authtype specifically, we've seen at one least modem which chokes
>> with our default settings for this parameter.  That said, this may have
>> been an operator specific behavior...
>>
>
> 3GPP mandates that CHAP is always supported.  In fact the authentication
> is not done against the modem, instead the modem simply takes the
> challenge-response data and forwards it as a part of context activation
> procedure.  Some operators were not following their own standards and
> were not accepting CHAP data, hence the need for authtype.  Last I heard
> this was no longer a problem.  If there are still hold outs, I'd be
> interested in hearing about it.

Again, I'm basing this on the contents of a recently shipping apns-conf =

file.

As I'm not able personally to test against these operators I can't =

really offer much proof one way or another as to how compliant they are.

>> Looking at a fairly recent apns-conf, there are close to 500 APNs which
>> specify authtype, out of a db of ~2000.  As this is a parameter that our
>> rilmodem driver could use when setting up a data call, I would say this
>> is useful.
>
> And I would ask that you find at least one example where a context
> activation fails when using a non-default authtype.

As mentioned, that's not possible for me to do directly.

>> Understood, however some of these attributes might be interesting to
>> other processes using ofono to access the contexts which have been
>> provisioned ( and persisted on-disk ).
>
> Concrete examples?

I think I've given enough concrete examples where this kind of =

information in a provisioning db might be useful to an ofono driver =

implementation such as rilmodem, a client of ofono, or both.

That said, if I can't convince you, and it's something that we end up =

requiring, we'll have to carry patches to implement this.

For now I'm willing to forgo trying to convince you that extra data is a =

worthwhile concept, as I'd really like to focus on hybrid MMS/INET support.

>> Again, this is the reason I went ahead and added support for an
>> ExtraData dictionary that captures all the extra attributes we can't map
>> directly to context properties.  This seemed like the least intrusive
>> approach to us.  Are all of these additioanl atrributes absoultely
>> critical to us right now?  Probably not, but why throw information away?
>>
>
> Lots of reasons.  Here are the top two:
>
> First, any code that gets accepted gets reviewed and maintained.  You
> are asking us to maintain code that is of dubious value.  So right away
> that is a non-starter.
>
> Second, the API is frozen.  Things can be added, but not removed.  It is
> much easier to add something when you need it than to remove it when you
> realize your ideas were wrong in the first place.

Well, then let's agree to politely disagree, and move on for now.

Actually though, I do have one question about the API being frozen.  Are =

there any plans to remove the OFONO_API_SUBJECT_TO_CHANGE pre-processor =

logic in plugins.h?

>> Also, as Slava from Jolla pointed out, it also might be nice to use this
>> mechanism ( or something similar ) to add some additional private data
>> to a context, such as "user-selected", or maybe even a "last-connected".
>>
>
> Yes it _might_ be nice to someone somewhere ;)  But you still need to
> answer how this is of value to the oFono project?  Remember our core
> design philosophy, Minimal and Complete.  And then ask yourself whether
> adding a particular feature fulfills that philosophy.

We value the ofono project because it provides a solid, flexible =

framework for providing telephony services to Linux-based devices.

In our case ( and Jolla's ), we felt that this feature helped fulfill =

the mission of shipping Linux-based phones ( based on two very different =

distributions I might add ).

But again, my original email was meant as a RFC, and clearly this =

feature isn't something you're willing to entertain, so I'm willing to =

drop further discussion for the time being.

>> Sure, if we stick to just Internet/MMS, the number could be managable.
>> My point was if an operator defined 3-4 APNS, and each was a multi-usage
>> APN ( eg. "default,mms,supl" ), then you'd end up with nine contexts (
>> this assumes creation of a SUPL context type ).
>
> We have a favorite phrase around here, "We don't deal with
> hypotheticals".  Find me an operator that did that, and I will consider
> this case.  Until then it doesn't exist :)

I'm trying not to deal with hypotheticals either, I'm more focused on =

making sure what we have solid product for OEMs to ship.

As for operator examples, the apns-conf from a Galaxy Nexus (4.3?) =

includes five different APNs for ATT in the US ( mcc/mnc: 310/410 ); =

this includes one APN for the MVNO Straightalk.  I have another newer =

version of apns-conf that has only two defined for the same operator.

The current version of mbpi shipping in Ubuntu has three APNs for ATT/US.

So clearly not hypothetical.

That said, even though the SPN is passed to the provisioning plugin, it =

doesn't appear to be used in the mbpi logic, nor the original version of =

the android_apndb code.

But again, I'd rather focus on whether hybrid INET/MMS contexts could be =

made to work.

>> At the moment we're really focused on MMS support, and so at minimum we
>> want shared contexts to work for Internet and MMS together. This by
>> itself I still believe is a worthy goal, and I think it's do-able with
>> minor changes to the core.
>>
>
> Agreed ;)

Great, we can claim some progress in our discussion then!

Thanks,
/tony


--===============6098902354417808348==--

