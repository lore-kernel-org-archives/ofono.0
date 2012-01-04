Content-Type: multipart/mixed; boundary="===============0787122315425001660=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: api property notification order
Date: Wed, 04 Jan 2012 13:29:37 +0200
Message-ID: <CAHiDW_HUJtPO7AwazogNrsV5vuFeupYj66OW9JhyzsO5zWH8xw@mail.gmail.com>
In-Reply-To: <4F00F6F6.8050501@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0787122315425001660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, thanks for a comprehensive answer.

On Mon, Jan 2, 2012 at 2:14 AM, Denis Kenzior <denkenz@gmail.com> wrote:
  [...clip...]
>> returns. From an API user point of view that is wrong. As an example I
>> thought this would be a fairly logical way to handle PIN resets:
>> =C2=A0 * property change SimManager.PinRequired=3D"puk" -> show pin rese=
t UI to user
>> =C2=A0 * user enters PUK and new PIN -> call SimManager.PinReset()
>> =C2=A0 * wait for method to return, present any errors. In particular
>> org.ofono.Error.Failed:
>> =C2=A0 =C2=A0 "It looks like you entered the wrong PUK. You can try agai=
n X more
>> times before the SIM is permanently locked"
>> Doing that will mislead the user really badly as the Retries-property
>> hasn't been decreased yet...
>>
>
> Ah, but the problem here is really not the ordering. =C2=A0The problem is
> that this is a fairly complicated transaction, requiring several calls
> to the driver and affecting several attributes at once. Not only do the
> pin retries have to be checked, but also what the new PIN required is or
> whether the SIM is blocked forever. e.g. you might actually have run out
> of PUK retries and blocked your SIM forever. =C2=A0To add additional
> complexity, not all modem drivers support querying pin retries, or we
> simply do not have the AT command details available...
>
> What is happening here is that the method return is generated purely on
> the success / failure of the pin reset operation, not

Ah, I see. I did take a look at the code but missed this. I was afraid
you might have reasons for it...

From a software 'completeness' POV I should just make my UI messages
change as the situation in ofono changes, but I dislike that for two
reasons: First, it makes the whole thing a lot more complex, and
second, changing UI messages is just bad design: I'd rather wait until
the 'side effects' like retry-counts are all there and then show the
message. I realise I can never be 100% sure that things won't change
but I'm mostly interested in the 99.9% cases.

It looks like I don't really have an alternative though -- I think
I'll delay the message creation by a very short time so the retry
count is correct in most cases and add state handling for the message
content to cover the 0.x%.

> In general I'm open to the idea of querying pin retries and pin type
> before returning from PIN/PUK related method calls.  However, this
> probably needs to be studied a bit more carefully for feasibility and
> impact.

That sounds good to me.

Jussi

--===============0787122315425001660==--

