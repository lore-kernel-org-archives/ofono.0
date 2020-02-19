Content-Type: multipart/mixed; boundary="===============5946876226469933317=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Option to not power off radio during start ofono
Date: Wed, 19 Feb 2020 11:04:55 +0100
Message-ID: <CAKSBH7H9tb3fZuOhNbF04Wnx542m8uCyAy4R9SPy2XVoLWL4Vw@mail.gmail.com>
In-Reply-To: <CAHB-Pjkwr25o88UT7jdFjxi3VyYVsM3Spsk-DVpQahYCa4v0DA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5946876226469933317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Wed, Feb 19, 2020 at 10:06 AM Richard R=C3=B6jfors
<richard.rojfors@gmail.com> wrote:
>
> Hi Giancinto,
>
> Den tis 18 feb. 2020 kl 20:27 skrev Giacinto Cifelli <gciofono@gmail.co=
m>:
>>
>> Hi Richard,
>>
>> On Tue, Feb 18, 2020 at 10:19 AM Richard R=C3=B6jfors
>> <richard.rojfors@gmail.com> wrote:
>> >
>> > Hi,
>> >
>> > Ofono (at least for ublox) is always powering off the radio during sta=
rt.
>> > This can of course be handy of programmatic reasons to bring the modem=
 to a known state.
>> > Some configuration requires the radio to be turned off;  for instance =
the LTE auto connect APN. But on the other hand these are stored in non-vol=
atile memory and could be configured before hand.
>> >
>> > The big drawback with turning it off is that it might take time to reg=
ister again when the radio is on. I have seen it taking more than 10 minute=
s in extreme cases.
>> >
>> > In embedded systems this can be a big issue.
>> >
>> > I'm thinking of adding a configuration option to keep the radio on dur=
ing start.
>> >
>> > Whats the general thought about this?
>>
>> my opinion would be to keep it like that.
>> it can generate several headaches for several use cases, and break
>> existing code.
>
>
> Yes I agree that the startup sequence will change, which is risky, but
> it would be an option for people knowing what they are doing.
>
>>
>> for example when the SIM could change as compared with the previous
>> boot.
>
>
> When using this option you should know what you are doing. As I said you
> might need to write settings to non-volatile memory since runtime changes
> might not apply. And a SIM wont just change in environments where this
> option should be used.
>
>>
>> Then it becomes much harder to recover from this situation.
>> it would be better to be able to boot the modem in airplane mode,
>> directly, so that there is no flip-flop effect.
>
>
> That could be an option, but that will cost up to several seconds of time.
> In the systems I'm talking about the boot loader might kick the modem
> running to get it registered as quickly as possible.
>
>>
>>
>> In any case I have never observed 10 minutes.
>
>
> This is not the regular case. But I have observed this.
>
>>
>> If this really happens, either the signal is so low that in any case
>> the link will be pretty unstable, or the stack needs debugging.
>
>
> I contacted the FAE's from the vendor regarding this. I guess they
> want to keep the work load down, but their major complaint was
> the way ofono turns off the radio. And even if they would fix their
> bugs there will be modems in the field that behaves like this.
> But regardless; 10min is a super long time, even if its just
> seconds to save, that could be of importance...
>
>
> I'm not sure its a good idea to introduce this. I need to,
> but I wanted to check if there was an interest in the general public.

trying is quite easy. In plugins/ublox.c, there are 2 occurrencies of
"AT+CFUN=3D4":
 -> change both of them to "AT+CFUN=3D1".
  (I am not sure whether this will produce an error in case the modem
is already in CFUN:1, but it is worth trying).

If you are satisfied, then you can make it conditional with an
     if (getenv("OFONO_UBLOX_NO_CFUN_FLIP"))

But again, you know what you are doing in the lab, not later in the field.
If there is a SIM detection switch, for example, it is in general
detected by the modem only (and not by the application) and  therefore
only when it is running.
It can work well if the SIM is soldered.

>
> --Richard

Giacinto
--===============5946876226469933317==--

