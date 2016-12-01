Content-Type: multipart/mixed; boundary="===============6389510474474407012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 4/7] ubloxmodem: add the netmon driver
Date: Thu, 01 Dec 2016 11:18:00 -0600
Message-ID: <58405B48.5050003@gmail.com>
In-Reply-To: <CAH562ETeQh-wQ5EoDN6UVz0ZFOw6ci=ijizudSq+UgQgVieohA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6389510474474407012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Djalal,

 >
> OK thank you for the explanation. I did go with ref counting since
> they are easy to use and I will follow up later with +UCGED which has
> different behaviour depending on firmware version...

Sounds good.

>
> I take a ref just before doing the g_at_chat_send() , however I call
> unref in case g_at_chat_send() returns 0 and fails since in that case
> the GDestroyNotify is still not registered and the command was not
> queued...

That is fine.  In general it might be simpler to have req_cb_data_ref =

initialize the ref count to 1.  Saves you a call to ref()

>
> Hmm so now maybe the leak may happen in this small window between:
> cbd =3D req_cb_data_ref(cbd);
> and
> g_at_chat_send() and before registering the GDestroyNotify
> parameter... in case hardware removal happens or anything... I'm not
> sure and I also don't know how to fix it.

This is not possible.  The hardware removal notification still comes =

over a socket, so regular event loop rules apply.  The function =

invocation won't be interrupted mid-stream.

What we're worried about is us allocating memory, queuing the command =

into GAtChat, but at some point later, the GAtChat object is destroyed =

before the command callback was executed.

Regards,
-Denis

--===============6389510474474407012==--

