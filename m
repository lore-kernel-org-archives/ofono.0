Content-Type: multipart/mixed; boundary="===============2669156064445505663=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RFC] Add agent API to message atom
Date: Wed, 01 Sep 2010 08:57:53 +0300
Message-ID: <AANLkTim3x7dZ7HYBmuZr7wQJTeKcbErUkeHo0YcfdDzO@mail.gmail.com>
In-Reply-To: <1283258260.7452.13.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2669156064445505663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/8/31 Marcel Holtmann <marcel@holtmann.org>:
>> This was basically what I was thinking, too, with the addition of ^
>> and $ for matching at the end or beginning of a message.
>
> within GLib we have glob pattern matching functions, but nothing that
> additionally takes ^ and $. Why do you think this would be useful and
> needed? How many message agents to you expect to be running that are not
> using port numbers? Do you have some examples messages in mind?

There are services that use SMS to send confirmation tokens in
messages, and are not using application ports. But they also require
the ability to stop such a message ending up in the UI. So perhaps
this sort of thing is better done higher up the stack, like in the
messaging application itself.

Cheers,
Aki

--===============2669156064445505663==--

