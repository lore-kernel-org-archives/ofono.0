Content-Type: multipart/mixed; boundary="===============6332608634374665289=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH qmi lte v3 5/6] qmi: stop listening to packet service
 notifications
Date: Mon, 17 Apr 2017 21:45:01 +0200
Message-ID: <c91b554e-be23-d623-2a80-f5bbdcb6fd60@southpole.se>
In-Reply-To: <3d9bafa0-a01d-bcb9-c189-521e5beeb93b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6332608634374665289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 07:19 PM, Denis Kenzior wrote:
> Hi Jonas,
>
> On 04/15/2017 10:34 AM, Jonas Bonn wrote:
>> The packet service status notification tells whether there is _any_
>> active and enabled context.  Using this to decide whether to
>> release any given context makes no sense.
>
> The gobi driver only supports a single context and afaik only a single =

> network interface is available.  Do you have hardware with support for =

> multiple active contexts?

On an LTE network you can start a "dedicated" bearer.  As far as I =

understand it, the way this is done is to call "start network" =

specifying a profile ID other than the default.  In the ofono context, I =

presume this would be done by creating a new context and activating it:  =

it just needs the same APN as the default bearer, and normally one would =

specify other QoS settings.  Given that, then yes, I presume my hardware =

support multiple active contexts; if the Gobi driver only supports one =

context it's presumably because it doesn't support LTE.

>
> Otherwise I think it would be safe to assume that in a single-context =

> case, this code is doing the right thing.

I think, for LTE, that the netreg atom gives you everything you need and =

that this notification is superflous.  I'm thinking now that for non-LTE =

this code might be relevant:  can the context detach spontaneously =

without unregistering from the network?  If yes, then we probably need =

this, still.

/Jonas

>
>>
>> It might make sense to monitor this status in the GPRS atom, but
>> not here in the gprs-context atom.
>> ---
>>  drivers/qmimodem/gprs-context.c | 30 ------------------------------
>>  1 file changed, 30 deletions(-)
>>
>
> Regards,
> -Denis
>


--===============6332608634374665289==--

