Content-Type: multipart/mixed; boundary="===============7356315745960021447=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 6/9] Add SimToolkit and SimApplicationAgent interfaces.
Date: Sat, 03 Jul 2010 02:23:29 +0200
Message-ID: <AANLkTilviJirlDpvqKHwr9Qa1nZxCPgZYAzwxCH7yVk4@mail.gmail.com>
In-Reply-To: <AANLkTin7W2jI49AkuWBd545wCMYLs31oRO0J5o8sgDAE@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7356315745960021447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 3 July 2010 01:40, Andrzej Zaborowski <andrew.zaborowski@intel.com> wr=
ote:
> So when the user launches a SIM Applications app on their device, they
> would see the main menu. =C2=A0Menu would be available as a property of t=
he
> D-bus interface, and the user would register an agent and provide a
> selection from the menu at the same time. =C2=A0Then when the session end=
s,
> the agent would be released at the same time. =C2=A0The question is if a
> session can be started by the UICC, there's no indication that it can
> or cannot, but I haven't seen the sim use any command like DisplayText
> on a different occasion than when navigating the menu. =C2=A0For any other
> command, like SendSMS, call control etc, an Alpha Id is supplied
> instead of using DisplayText.

A data point is which commands allow the "User terminted session" and
"Go back in proactive session" results.  "Go back" is accepted only
for the four commands (DisplayText, GetInkey, GetInput, SelectItem),
and "User terminated session" is allowed for these four plus
DisplayMMS, SetUpCall, PlayTone.  Most other commands provide an
optional Alpha Id, which I believe can be displayed when the screen is
"released", i.e. without the SIM Apps app running.

Best regards,
Andrew

--===============7356315745960021447==--

