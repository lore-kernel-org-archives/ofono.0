Content-Type: multipart/mixed; boundary="===============4611443074333505004=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Option to not power off radio during start ofono
Date: Wed, 19 Feb 2020 12:52:21 -0600
Message-ID: <f81e13eb-6c7a-78ce-c4dd-2fc998cdbb96@gmail.com>
In-Reply-To: <CAHB-PjkycO5zfS7KHpi+m0TK0DztQ0Dvnaa91zzKNnGD+hkUYw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4611443074333505004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 2/18/20 3:19 AM, Richard R=C3=B6jfors wrote:
> Hi,
> =

> Ofono (at least for ublox) is always powering off the radio during start.
> This can of course be handy of programmatic=C2=A0reasons to bring the mod=
em =

> to a known state.
> Some configuration requires the radio to be turned off;=C2=A0 for instanc=
e =

> the LTE auto connect APN. But on the other=C2=A0hand these are stored in =

> non-volatile memory and could be configured before hand.

So by default we bring the device into airplane mode until the SIM card =

has been initialized.  Also, the policy decision of bringing the radio =

up / down was left to external services such as ConnMan.

> =

> The big drawback with turning it off is that it might take time to =

> register again when the radio is on. I have seen it taking more than 10 =

> minutes in extreme cases.
> =


That's nuts.  Shouldn't take more than a few seconds?

> In embedded systems this can be a big issue.
> =


Indeed.

> I'm thinking of adding a configuration option to keep the radio on =

> during start.
> =

> Whats the general thought about this?
> =


Not sure.  Are you certain that adding such low-level config options is =

the right approach?  Even documenting / explaining what and why this =

configuration option is there would be challenging I imagine.

Regards,
-Denis
--===============4611443074333505004==--

