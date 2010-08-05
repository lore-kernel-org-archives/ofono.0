Content-Type: multipart/mixed; boundary="===============8957011019285583377=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 02/19] sms: introduce message ID API
Date: Thu, 05 Aug 2010 13:02:25 -0500
Message-ID: <4C5AFCB1.1000901@gmail.com>
In-Reply-To: <1281028719.19261.82.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8957011019285583377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

>> The current message id is 32 bits.  Why are we stopping at 16?  We could
>> go all the way to 64 if needed...
> =

> Well, at the end what gets sent to the network is 16 bits right?

So I think we're all confused here.  This ID is not being sent to the
network.  It is only used for uniquely identifying the message over
D-Bus and to message history.  This number can be as small or as big as
we want.

> =

>> Also, we need to take time and some random value into account.  Perhaps
>> including time() output and a simple static counter into the hashing
>> function would make it unique for those 'same sender, same contents
>> messages'
> =

> So then we really don't care about being able to regenerate the hash ID
> from the contents?
> =

> The design discussions we held about this involved being able to, with
> the content of the message and destination number, generating a hash
> that could be uniquely reproduced by rehashing it again. You had a
> reason for it and I can't remember which one it was -- I should have
> written it down. But that brought the problem of 'somebody sending the
> same message to the same number' which yields the same ID.
> =

> However, if to fix that we are adding randomness in the form of time(),
> why bother with the contents? let's just do a random ID from the ground
> up and save us the pain of hashing.
> =


I don't remember this discussion any more.  There might be a case where
an old message is re-delivered because oFono crashed after delivery but
before deletion.

At least to me it seems that generating a random int is really not
guaranteed to be unique over reboots.  Hashing seems way better.
However, I'm not a math/crypto geek, so feel free to prove me wrong.

Regards,
-Denis

--===============8957011019285583377==--

