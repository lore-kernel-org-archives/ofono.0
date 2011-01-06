Content-Type: multipart/mixed; boundary="===============3330378253489111747=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2, 3/7] cdma-sms: Add CDMA SMS Support
Date: Thu, 06 Jan 2011 14:23:06 -0600
Message-ID: <4D2624AA.6020205@gmail.com>
In-Reply-To: <4D24AEB9.4060800@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3330378253489111747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,

>> So it looks to me like this function takes arbitrary bit fields from a
>> stream.  Is this a 'peculiarity' of the address field or will this be
>> used elsewhere?
>>
> Yes, your interpretation of the function is correct.
> =

> Actually, cross CDMA SMS spec (and also other CDMA protocol specs), a
> lot of the message (parameter and etc) structures are defined just as
> 'peculiar' as Address field. For example: User Data (section 4.5.2 of
> C.S0015-B), Call Back Number (can be considered same as address).
> =

> Essentially, CDMA SMS specs defines structures as bit streams and a
> field can start at any offset within the bit stream. Even worse,
> depending on the values of the previous fields, a field can start at
> different locations within a bit stream for the different instances of
> the same type of the message.
> =


Yes, some really smart engineers must have designed this spec ;)

>> This looks like a really inefficient function to call for every field,
>> so it might makes things easier if the offsets were simply hardcoded...
>>
> =

> The main reason I do this way is that I feel there will be more chances
> to make mistake if the 'shift', 'bit-wise and', bit-wise or' operation
> is carried out when decoding each field separately. It will be cleaner
> to have this generic function and decoding of each field will just care
> about size of the field and start offset of the field into the stream.
> =


I'm unconvinced.  The first thing I question is why you bother decoding
up to 32 bits at once in a loop.  The max size of the field I've seen so
far is 16 bits and even that is not common.  Decoding as 8 bits and
bitwise ORing in the appropriate place might be way simpler (and faster).

> Efficiency-wise, I see worst case a few extra machine instructions will
> be used in comparing to 'manually' decoding at each place.

Efficiency wise this is actually pretty bad compared to a tight loop.
Especially for things like user-data which is just 8 bits but
bit-shifted a random amount.

We're talking about potentially 250+ functions calls per sms segment...
 Since the function is fairly large, not sure if it can even be inlined
successfully.  We are targeting embedded devices here, right? ;)

Can you try substituting a macro / inline function that can extrat a max
of 8 bits from a bitstream instead?  I believe such an operation would
be easily inlined, would not require branching and still keep most of
the advantages you list out above...

>> Explicit casts should be avoided
> =

> Will fix. Could you pls also educate me the rationales behind this rule?
> =


Two reasons: It looks ugly; and

When I'm reviewing code, every time there's an explicit cast my alarm
bells go off.  It could mean that one:
	a. Didn't think through one's data structures / code (e.g. const /
non-const, enum vs int, etc).  The compiler's job is to point out such
possibilities in order for them to be fixed appropriately.  Often
casting is just an attempt to hide these warning signs.
	b. is doing something really evil without fully thinking it through.
See point a.
	c. Doing something really evil for a good reason, but it is so tricky
it needs special attention. This last one should be pretty rare ;)

>> Have you looked at how STK pdus are decoded in stkutil.c,
>> parse_dataobj() in particular.  Looking at the basic code structure so
>> far, that design pattern could be (or not) a really nice fit here and
>> save you some kLoC in the future.
>>
> =

> Looked at it. I am assuming that the design pattern you are referring to
> is that we can create an array of structure where decoding function for
> a parameter record can be stored thus, this part of the code will be
> reduced to something like: parsing the type and invoke the decoding
> function (dataobj_handler as in stkutil.c) as in the array of the
> function handlers.
> =

> I don't see this approach and the approach I described above are really
> not much differences since the logics below are nothing but a big
> switch-case state which will be required even with function handler
> array approach anyway.
> =

> The only simplification I can see below is to somehow to put
> set_bitmap() into one place. This will reduce ~30 LOC.
> =


There's more to it than that.  You also get automatic checking of the
presence of the mandatory fields which you do not do right now and will
repeat at least twice.  You also don't need to code the same exact loop
multiple times.

That reminds me, it might be useful to have a proper iterator for
subparameter data.  E.g. similar to simple_tlv_iter.  It should make
things way easier to read for the uninitiated.

Regards,
-Denis

--===============3330378253489111747==--

