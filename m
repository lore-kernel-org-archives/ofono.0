Content-Type: multipart/mixed; boundary="===============0150045160799399737=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/9] Add SimToolkit and SimApplicationAgent interfaces.
Date: Sat, 03 Jul 2010 13:24:39 -0500
Message-ID: <4C2F8067.4090506@gmail.com>
In-Reply-To: <AANLkTin7W2jI49AkuWBd545wCMYLs31oRO0J5o8sgDAE@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0150045160799399737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> So when the user launches a SIM Applications app on their device, they
> would see the main menu.  Menu would be available as a property of the
> D-bus interface, and the user would register an agent and provide a
> selection from the menu at the same time.  Then when the session ends,
> the agent would be released at the same time.  The question is if a

I've had the same exact thought here independently.  Funny that you're
thinking along the same lines.

> session can be started by the UICC, there's no indication that it can
> or cannot, but I haven't seen the sim use any command like DisplayText
> on a different occasion than when navigating the menu.  For any other
> command, like SendSMS, call control etc, an Alpha Id is supplied
> instead of using DisplayText.

Unfortunately DisplayText / Get Input and Select Item can be started
outside a main menu selection, at least according to GSMA DG.11 Device
Field and Lab Test Guidelines Section 8.9.15.

I need to dig into that spec some more, but looks like any SMS-Data
download can trigger a USAT command, no matter what is currently
happening (unless the SIM is busy of course.)

Regards,
-Denis

--===============0150045160799399737==--

