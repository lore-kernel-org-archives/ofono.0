Content-Type: multipart/mixed; boundary="===============7833696621823151710=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH qmi lte v3 5/6] qmi: stop listening to packet service
 notifications
Date: Mon, 17 Apr 2017 14:51:20 -0500
Message-ID: <edd39a3a-e80c-aa1b-5f83-e7c60fb53d4e@gmail.com>
In-Reply-To: <c91b554e-be23-d623-2a80-f5bbdcb6fd60@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7833696621823151710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/17/2017 02:45 PM, Jonas Bonn wrote:
> On 04/17/2017 07:19 PM, Denis Kenzior wrote:
>> Hi Jonas,
>>
>> On 04/15/2017 10:34 AM, Jonas Bonn wrote:
>>> The packet service status notification tells whether there is _any_
>>> active and enabled context.  Using this to decide whether to
>>> release any given context makes no sense.
>>
>> The gobi driver only supports a single context and afaik only a single
>> network interface is available.  Do you have hardware with support for
>> multiple active contexts?
>
> On an LTE network you can start a "dedicated" bearer.  As far as I
> understand it, the way this is done is to call "start network"
> specifying a profile ID other than the default.  In the ofono context, I
> presume this would be done by creating a new context and activating it:
> it just needs the same APN as the default bearer, and normally one would
> specify other QoS settings.  Given that, then yes, I presume my hardware
> support multiple active contexts; if the Gobi driver only supports one
> context it's presumably because it doesn't support LTE.

Okay, so now you're opening a whole new can of worms.  Dedicated bearers =

are similar to secondary PDP contexts in 2G/3G.  Their handling is even =

more special than primary PDP contexts / default bearers.

I wouldn't presume that your hardware supports this.  You need to check. =

  How many physical network interfaces are exposed?  If its just one =

like the gobi has, then you have your answer.

>
>>
>> Otherwise I think it would be safe to assume that in a single-context
>> case, this code is doing the right thing.
>
> I think, for LTE, that the netreg atom gives you everything you need and
> that this notification is superflous.  I'm thinking now that for non-LTE
> this code might be relevant:  can the context detach spontaneously
> without unregistering from the network?  If yes, then we probably need
> this, still.
>

A context can be forcefully deactivated by the network operator at any =

time.  So yes, this is actually needed.

Regards,
-Denis


--===============7833696621823151710==--

