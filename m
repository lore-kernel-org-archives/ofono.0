Content-Type: multipart/mixed; boundary="===============4167027430126355432=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] Add agent API to message atom
Date: Wed, 01 Sep 2010 08:40:48 -0400
Message-ID: <1283344848.7452.35.camel@localhost.localdomain>
In-Reply-To: <AANLkTim3x7dZ7HYBmuZr7wQJTeKcbErUkeHo0YcfdDzO@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4167027430126355432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> This was basically what I was thinking, too, with the addition of ^
> >> and $ for matching at the end or beginning of a message.
> >
> > within GLib we have glob pattern matching functions, but nothing that
> > additionally takes ^ and $. Why do you think this would be useful and
> > needed? How many message agents to you expect to be running that are not
> > using port numbers? Do you have some examples messages in mind?
> =

> There are services that use SMS to send confirmation tokens in
> messages, and are not using application ports. But they also require
> the ability to stop such a message ending up in the UI. So perhaps
> this sort of thing is better done higher up the stack, like in the
> messaging application itself.

you really have to give me some concert examples here. The only time I
used these was for WiFi access tokens and these where expected to be
shown to the user.

So what kind of plain text messages need to be hidden from the UI? And
if we wanted to do that, what are the risk factors of accidentally
hiding them. Even with full blown regex pattern matching, I think there
is a high risk for false positives here.

I prefer if we are not doing that. If the services doesn't use port
numbers or some sort of WAP push to allow the device to uniquely
identify its message, then there is something seriously wrong with that
service.

Even just starting to think about the security implications here makes
me kinda worry. My thinking is that oFono should not look into the
content of any messages until it is a clearly defined protocol or
format.

Regards

Marcel



--===============4167027430126355432==--

