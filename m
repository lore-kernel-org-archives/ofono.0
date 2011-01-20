Content-Type: multipart/mixed; boundary="===============5263383416424520267=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] TODO: Move signal strength property to separate Agent API.
Date: Thu, 20 Jan 2011 11:35:32 +0100
Message-ID: <1295519732.3873.269.camel@aeonflux>
In-Reply-To: <1295519054-2162-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5263383416424520267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> I think we should consider changing the way we handle
> signal strength in oFono.
> =

> In the past I have seen very frequent signal strength
> reports from the modem under certain network conditions.
> I think we can improve the power consumption by changing
> the design here. I know other Radio Interfaces are subscribing
> to changes in power modes and turns off the signal strength
> reporting when screen is turned off. =

> =

> An Agent API for for Signal Strength would allow oFono to
> subscribe to modem signal strength updates only when an Agent is
> registered, and applications should register on the Agent API only
> when the signal-strength information is really needed. =


I don't think is needed. You do not get woken up until you tell D-Bus to
wake you up on that PropertyChanged signal. You can even match the first
parameter of that signal if you desire.

What we might should ensure is that we delay the signal reporting from
the modem. In case it wants to play ping-pong between two values. We
have done that for ConnMan in the past since WiFi signals are also kinda
flaky and made the UI go nuts.

Regards

Marcel



--===============5263383416424520267==--

