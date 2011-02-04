Content-Type: multipart/mixed; boundary="===============5615580378527388569=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 12:27:23 -0600
Message-ID: <4D4C450B.7060905@gmail.com>
In-Reply-To: <A459777776EB4841B844E1134E7928740157C97A@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5615580378527388569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On 02/04/2011 12:07 PM, mikhail.zabaluev(a)nokia.com wrote:
> Hi,
> =

>> -----Original Message-----
>> From: ext Denis Kenzior [mailto:denkenz(a)gmail.com]
>> Sent: Friday, February 04, 2011 7:06 PM
>> To: ofono(a)ofono.org
>> Cc: Zabaluev Mikhail (Nokia-MS/Helsinki)
>> Subject: Re: [RFC 2/2] doc: Add description for history agent interface
>>
>>> I totally agree. But it means that you have code in oFono to reliably
>> store an ordered collection of stuff in a filesystem. I wouldn't like
>> MeeGo developers to maintain very similar code in a different
>> component, just for API adaptation reasons.
>>
>> No we do not.  We have code to reliably store tpdus, fragments not
>> re-assembled messages.  It is not ordered or anything else you make it
>> out to be.  Why don't you actually read the sms_assembly code and tell
>> me if it is usable for anything else.  The code for storing assembled
>> messages would be _completely_ different.
> =

> Why, you already cache fragments by their respective message refs efficie=
ntly.
> The only thing missing is a thin API to provide a view on complete messag=
es.
> =


I think you really need to go into the code and understand what is going
on there.  You have a misconception of how it works.  Trust me, the tpdu
fragment store does not translate to any sort of D-Bus API.  And once
you see the code, I'm sure you will be convinced not to even bother ;)

Moreover, you have to realize that there are non-text messages in that
tpdu store that go via an entirely different path and unless there's a
relevant plugin handling these, they will not go through history.

In the text message case we already provide the history plugin with
_everything_ that it needs.  If you want to implement a particular API,
then history is the right avenue to do so.  There is no inherent benefit
of having oFono core do so and we do not want to introduce the concept
of a message store into oFono anyway.

> So the ratio is 2/3 for the only event flow that is relevant for performa=
nce, more likely.
> But I agree, it's a bit more efficient for simple plugins, provided that =
they never fall off the bus.

Lets put it this way, your proposal is 1.5x slower in the absolute best
case; worse if multiple clients subscribe to the signal, purposefully or
otherwise.

Falling off the bus has nothing to do with this performance.  You can
make your history plugin detect the 'falling off the bus' events and
handle them appropriately (e.g. spool messages internally until the
consumer comes back.)  That is how every single 'Agent' in oFono /
ConnMan / BlueZ works today anyway.

Regards,
-Denis

--===============5615580378527388569==--

