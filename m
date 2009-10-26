Content-Type: multipart/mixed; boundary="===============1823087287669552842=="
MIME-Version: 1.0
From: Chris Pitchford <ofono@intrepid.cx>
Subject: Re: Incoming line identity and ALS
Date: Mon, 26 Oct 2009 16:27:08 +0000
Message-ID: <20091026162708.14816kvlcut5xts0@boatman.intrepid.co.uk>
In-Reply-To: <200910261059.04471.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1823087287669552842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Quoting Denis Kenzior <denkenz@gmail.com>:

> Hi Chris,
>
>> Hi all,
>>
>> I've been looking through the 0.8 source code for some indication of ALS
>> support.
>>
>> ALS (or line-2) allow two different numbers to be attached to a mobile
>> device. The device can accept calls from both numbers and make calls from
>> either of the two numbers, effectively acting as if two lines were
>> attached to the device.
>
> ALS was never part of the core GSM specification.  It was an extension
> supported by several network providers and phone manufacturers.  It was
> incorporated into recent GSM specifications as 'Multiple Subscriber Profi=
le.'
>

I'm glad it was made more official, I just wish it was more widely  =

available. It's a fantastic feature.. one number for business, one for  =

personally.. It's all good!


>> First is selecting which line/number to use when making a call. I'm not
>> certain how handsets make this distinction and I wonder if it might be
>> vendor specific.. Changing out bound line seems to be set as a mode rath=
er
>> than on a
>> per-call basis. Switching out bound lines is sometimes locked with PIN1.
>
> This is done as a supplementary service control sent to the network  =

> over USSD.
> The details are pretty sketchy but the basics are described in 22.030 Sec=
tion
> 6.5.6.1.

Fantastic, there's somewhere for me to look.

>
>>
>> The other problem is identifying which line was called by a remote calle=
r.
>> I believe +CDIP includes this information (after each RING / +CRING)
>>
>> From what I've seen of the API, it has the ability to report the caller
>> identity for in bound calls and the dialed number for out bound calls, b=
ut
>> I can't seem to find any reference to the number called for in bound cal=
ls
>> which would be used to identify which line was ringing..
>
> CDIP (like CLIP) is issued after every RING/CRING.  Whereas CLIP returns =
the
> calling line identity, CDIP returns the called line identity (e.g. the ph=
one
> number the remote caller dialed.)  According to the specification it is n=
ot
> reported for outbound calls.

It seems that my phone doesn't support CDIP, although it does support  =

line-2/ALS which is a bit odd. I'll investigate more on that..

One thing I'm not certain about is whether CDIP would report which  =

line received the call, or which number the calller dialed as they  =

could be different. I know other areas deal with routing information,  =

but I wasn't sure which which number CDIP reported. It would be great  =

for ALS support if it were the line that received the call, rather  =

than the number dialed by the caller.. though that could be  =

interesting in other situations.

>
>>
>> I was wondering if this service has been considered for ofono or if
>> perhaps it is already there and I've missed it..
>
> oFono currently does not support ALS/MSP and we do not foresee enabling t=
his
> feature in the near term.  If you would like to help out, code / research=
 /
> documentation contributions are always welcome :)

To be fair, you've already given me a lot of information, such as  =

which standards describe the service. I'd be more than happy to try  =

and help out. I personally use ALS and would love to see it  =

incorporated and if I can help achieve that, all the better!

I guess the two tasks are discovering how to collect called line  =

information from a device and updating/changing the API so called-line  =

information is presented via ofono. I suppose they don't necessarily  =

need to be done in that order.

I'll do more investigation and try and come back with something more  =

constructive

Cheers

Chris


--===============1823087287669552842==--

