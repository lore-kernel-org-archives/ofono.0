Content-Type: multipart/mixed; boundary="===============2687580853462163947=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Option to not power off radio during start ofono
Date: Tue, 18 Feb 2020 20:27:14 +0100
Message-ID: <CAKSBH7EfS9ni98WPMzMzbs_e3dOBKfLgWtFbAp=S3yU0kpCgAA@mail.gmail.com>
In-Reply-To: <CAHB-PjkycO5zfS7KHpi+m0TK0DztQ0Dvnaa91zzKNnGD+hkUYw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2687580853462163947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Tue, Feb 18, 2020 at 10:19 AM Richard R=C3=B6jfors
<richard.rojfors@gmail.com> wrote:
>
> Hi,
>
> Ofono (at least for ublox) is always powering off the radio during start.
> This can of course be handy of programmatic reasons to bring the modem to=
 a known state.
> Some configuration requires the radio to be turned off;  for instance the=
 LTE auto connect APN. But on the other hand these are stored in non-volati=
le memory and could be configured before hand.
>
> The big drawback with turning it off is that it might take time to regist=
er again when the radio is on. I have seen it taking more than 10 minutes i=
n extreme cases.
>
> In embedded systems this can be a big issue.
>
> I'm thinking of adding a configuration option to keep the radio on during=
 start.
>
> Whats the general thought about this?

my opinion would be to keep it like that.
it can generate several headaches for several use cases, and break
existing code.
for example when the SIM could change as compared with the previous
boot. Then it becomes much harder to recover from this situation.
it would be better to be able to boot the modem in airplane mode,
directly, so that there is no flip-flop effect.

In any case I have never observed 10 minutes.
If this really happens, either the signal is so low that in any case
the link will be pretty unstable, or the stack needs debugging.

>
> BR
> --Richard
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org

BR,
Giacinto
--===============2687580853462163947==--

