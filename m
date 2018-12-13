Content-Type: multipart/mixed; boundary="===============5378057870436327251=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Thu, 13 Dec 2018 17:42:45 +0100
Message-ID: <CAKSBH7EkFXpKCKxKwRZ8WmxGyOm7a4DjZYQecnA77crnYCwiew@mail.gmail.com>
In-Reply-To: <b8877863-c2bf-84af-cf9b-307a942351dd@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5378057870436327251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Dec 13, 2018 at 5:28 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >>>> Can you cite the 3GPP specification number and section that this wou=
ld
>>>> be violating?
>>
>> 21.111 (USIM and IC card requirements), or
>> predecessors/successors.> I have taken the rel.7, whose paragraph 5.3
>> (User Data Stored in ME) mentions:
>>
>> "User related security codes such
>> as PIN and Unblock PIN may only be
>> stored by the ME during the
>> procedures involving such a code and shall
>> be discarded by the ME
>> immediately after completion of the procedure."

> Thanks for digging that up, this section should definitely be mentioned
> in a comment in the patch or the commit description.
>
> The question is really what to do and I can see both sides of the
> argument.  So let me play devil's advocate:
>
> If a firmware crashes on a device with a PIN lock and the user was
> browsing the internet at that time, it would be quite intrusive to
> interrupt the user and prompt them for a PIN (after all, they already
> entered the PIN).  Additionally, if the PIN was stored for just this
> case and the firmware reboots fast enough, a crash might not even be
> noticed by the user at all.  Now one can argue that the firmware
> shouldn't crash, and I agree, but realistically the chances of that
> never happening are NIL.

on the other hand, the sessions will be lost anyway, downloads and
streaming interrupted, due to the change of mobile IP, even if
the reboot would be fast.

>
> So if we do proceed with this feature, it should try pretty hard to
> comply with the spirit of the cited section, even if it isn't complying
> with it in a literal sense.

I don't agree with this.
In the original intents, the PIN is shared through DBus,
with quite some risk to disclose it to still other applications.

And then, if you want to restore the status as before the reboot,
maybe there were other PINs or keys presented.
Should they be stored and managed too?

And in case of USB devices, they disappear and re-enum later.
Should we think about storing the PIN non-volatile
for supporting the feature for these devices???

And should we have a timeout for the reboot?

>
> Regards,
> -Denis

Regards,
Giacinto

--===============5378057870436327251==--

