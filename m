Content-Type: multipart/mixed; boundary="===============7965166587912533234=="
MIME-Version: 1.0
From: Jens Rehsack <jr_extern@vfnet.de>
Subject: Re: Enhancing mmsd
Date: Fri, 24 Feb 2012 16:17:13 +0100
Message-ID: <4F47A9F9.7010407@vfnet.de>
In-Reply-To: <4F47A235.40807@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7965166587912533234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Am 24.02.2012 15:44, schrieb Ronald Tessier:
> Hi Jens,
> =

> On 02/24/2012 02:29 PM, Jens Rehsack wrote:
>> Hi,
>>
>> as announced in my last mail, I'm here to work with + improve ofono
>> and related software.
>>
>> My next task will be to implement an ofono plugin which handles some
>> UPL push messages. Because there is only one "listener" at
>> org.ofono.PushNotificationAgent possible, I see two and a half way
>> to go on:
>>
>> 1) fork ofono-mmsd to handle more message types than mms
>>     (via plugins?)
>>     1b) fork ofono-mmsd to handle only SUPL push messages
>> 2) find a way for more listeners on push messages
>>
>> Any suggestions, preferred ways?
> =

> I think there is a third way to do what you want : write a SUPL push
> message consumer as an mmsd plugin and not as an ofono plugin. Actually,
> mmsd already implements a WAP push message dispatch mechanism for other
> push message than MMS.
> To check if this fits your needs, please have a look at the consumer.txt
> documentation from mmsd/doc/.

Yeah, you're right. I read it on my first day and had it totally
forgotten meanwhile. Initially it confuses me, because I assumed
there can be embedded documents in an mms - and didn't recognize
that mms is the built-in plugin for mmsd - which should be renamed
into wspd ;)

So my proposal 1 is already done - but I was to much confused to
recognize it. Thanks to point me on it.

Best regards,
Jens

--===============7965166587912533234==--

