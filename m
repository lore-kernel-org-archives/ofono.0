Content-Type: multipart/mixed; boundary="===============4774397970433399837=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] TODO: Move signal strength property to separate Agent API.
Date: Thu, 20 Jan 2011 12:03:32 +0100
Message-ID: <1295521412.3873.278.camel@aeonflux>
In-Reply-To: <AANLkTim8A3zFQEu+3O0p+Q5V_YBy38hPNXKApjR1cQUp@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4774397970433399837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > I don't think is needed. You do not get woken up until you tell D-Bus to
> > wake you up on that PropertyChanged signal. You can even match the first
> > parameter of that signal if you desire.
> =

> I think this is still a worthy optimization, because this way not even
> oFono will wake up unnecessarily.

if you followed the discussion between Kristen and myself on IRC about
how stupid some modem are, then I worry seriously how good we can get
here.

That said, I am open for suggestions here, but they need to be backed up
by what certain modems can do for us in this area. And then we have to
also look at the screwed up hardware.

> > What we might should ensure is that we delay the signal reporting from
> > the modem. In case it wants to play ping-pong between two values. We
> > have done that for ConnMan in the past since WiFi signals are also kinda
> > flaky and made the UI go nuts.
> =

> Personally, I would just move to reporting the strength value in 0...5
> bars. Most UIs I've seen report bars in their UIs, and this way these
> clients will get woken up much more infrequently.
> =

> In addition if percentage is really required, we could offer that as a
> separate signal, but to instruct to use with caution. Or put it in a
> plugin. :)

To be honest, I have no idea if percentage is the best thing. We just
picked it initially to have something.

My take here is that you either have no signal, bad signal and a good
signal. Everything else is just fake for the human brain that tries to
associate anything with the bars it sees. Lets face it unless you deal
with dB directly you have no proper relation on what this visual aid
means in reality.

If we go back in the good old days, then we had 4 bars, then it became 7
in some Nokia phones, now it is 5. What is common, what makes sense?

Regards

Marcel



--===============4774397970433399837==--

