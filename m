Content-Type: multipart/mixed; boundary="===============2258935955444761370=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 13:01:18 -0600
Message-ID: <4D4C4CFE.3010508@gmail.com>
In-Reply-To: <A459777776EB4841B844E1134E7928740157C9DC@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2258935955444761370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On 02/04/2011 12:52 PM, mikhail.zabaluev(a)nokia.com wrote:
> Hi,
> =

>> -----Original Message-----
>> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
>> Behalf Of ext Marcel Holtmann
>> Sent: Friday, February 04, 2011 8:13 PM
>> To: ofono(a)ofono.org
>> Subject: RE: [RFC 2/2] doc: Add description for history agent interface
>>
>>> Why, you already cache fragments by their respective message refs
>> efficiently.
>>> The only thing missing is a thin API to provide a view on complete
>> messages.
>>
>> we are not storing the complete message. We give it to the history API.
> =

> Somehow we never got to the "because" part in this discussion. Or is it a=
 dogma in oFono?
>

Because we wanted to avoid this exact discussion.  If you want some
particular API for text messaging, feel free to implement it.
Everything you need is provided.  The sms assembly / status assembly
code will not help you in any way here.

> =

> Sorry, I only jumped into the discussion after it has started and did not=
 read the patch.
> But now that I do, I see an additional AddMatch and a GetOwnerName in thi=
s flow.
> =

> And the failure mode of the agent disconnecting is... to drop events on t=
he floor???
> =


Then please take the hint and get more background first.  Marcel did
mention in the thread that his patch is an RFC (he is a maintainer after
all) and that spooling of messages when the agent is not registered is
still not done.

Regards,
-Denis

--===============2258935955444761370==--

