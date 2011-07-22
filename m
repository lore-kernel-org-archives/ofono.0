Content-Type: multipart/mixed; boundary="===============2772076574420979679=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [HELP] Voicecall Establishment Using CDMA Phone
Date: Fri, 22 Jul 2011 05:20:58 -0500
Message-ID: <4E294F0A.5030100@gmail.com>
In-Reply-To: <10D123A956DC4B4FA9D7A48B33358362151681D7A9@INDXM3131.dir.svc.accenture.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2772076574420979679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Milan,

On 07/22/2011 06:16 AM, milan.satpathy(a)accenture.com wrote:
> Hi,
> =

>  =

> =

> I have been using =E2=80=9Chfpmodem=E2=80=9D to establish HFP connections=
 and make calls
> using GSM handsets.
> =

> When I tried with a CDMA phone (ACCORD A714), I am able to establish HFP
> connection. But the =E2=80=9Cvoicecallmanager=E2=80=9D methods do not see=
m to work.
> =

> I m not able to create an outgoing call using =E2=80=9CDial=E2=80=9D.
> =

>  =

> =

> Also, when I make an incoming call, I do not see any dbus signal from
> Ofono. The voicecall objectpath (=E2=80=A6/voicecall01) is not created as=
 well.
> Do I need to make use of the cdma modem here? Please suggest, if I need
> to make any configuration changes in order to make a CDMA handset work
> normally.
> =


We need a bit more information than that to help you.  Is the phone
you're trying to use supporting Bluetooth HFP profile (e.g. are other
bluetooth headsets working)

Can you provide AT and debug logs of ofono when you encounter these
problems?

Regards,
-Denis

--===============2772076574420979679==--

