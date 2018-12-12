Content-Type: multipart/mixed; boundary="===============6163945331115132696=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Wed, 12 Dec 2018 17:22:26 +0100
Message-ID: <CAKSBH7Fb3c9bpkRM3GGYypowLR_1yo8PzBa8LeDDtzenEWvPFQ@mail.gmail.com>
In-Reply-To: <9f667c8d-02bf-e3e9-cec2-5408035dd699@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6163945331115132696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Dec 12, 2018 at 4:35 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> No top-posting on this mailing list please.
>
> On 12/12/2018 01:59 AM, Giacinto Cifelli wrote:
> > No, absolutely not!
> > It is forbidden to do this by the 3GPP!
> >
>
> Can you cite the 3GPP specification number and section that this would
> be violating?

I will check this, but I remember that it is forbidden for at least two rea=
sons:
- the PIN can be changed (in another phone/application), and then it
would be blocked
  this would make the pin cache feature also quite complicated,
because it must be deleted when the presentation is wrong, and if the
SIM is blocked, then also the application is more complicated because
it must consider that it needs to unblock the PIN under some
conditions. Also, if the PIN is changed by ofono, it must also be
tracked by the caching feature.
- the PIN presentation is prerogative and privilege of the user. It
cannot be delegated to the ME. Otherwise there would be no need for a
PIN at all. I have to say, I have seen several SIM with the PIN
disabled (especially in the US), but the user can always enable it if
he likes, and then wouldn't welcome that the device can be used
without his consent.
  from an operator point of view, it attributes the responsibility to
network access and use to the user, just like with the credit cards
chip&pin.

>
> Regards,
> -Denis

--===============6163945331115132696==--

