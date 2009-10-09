Content-Type: multipart/mixed; boundary="===============2866366587263806986=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: allow P or , within the dial string
Date: Fri, 09 Oct 2009 01:22:50 -0500
Message-ID: <200910090122.51209.denkenz@gmail.com>
In-Reply-To: <80fd4e750910081930j383c197fxca48c3bbdf7b6b0a@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2866366587263806986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> > Unless I'm missing something, the DTMF 'C' digit refers exactly to what
> > you're trying to achieve with 'p' and ','
> >
> > Check TS 11.11 Table 12.  'C' is mentioned as the DTMF Control digit
> > separator from TS 02.07.
>
> You mean binary code 0b1100 aka hex code 0xC? It would be otherwise
> known as DTMF digit 'A'. Welcome to wonderful world of phones.
>
> Have a peek in src/smsutil.c to_semi_octet().
>

Funny part is that I wrote that function :)  But actually you're absolutely =

correct.  I forgot how context sensitive this specification is.  Just so we=
're =

on the same page:

24.008 Table 10.5.118 maps BCD thus:
0-9, 10 -> '*', 11 -> '#', 12-> 'a', 13-> 'b', 14->'c', 15 -> endmark

TS 11.11, 51.011 and 31.102 define the BCD SIM storage thus:
0-9, 10-> '*', 11->'#', 12->'C' DTMF Control Digit separator, 13 -> 'D' Wil=
d =

value. 14 -> RFU, 15->Endmark.

DTMF digits have yet another coding.  The current implementation is actuall=
y =

correct,  so you can safely ignore most of what I said in the last message.

> I'm afraid the modem driver has to implement pause either by itself or
> with some modem-specific command.
>
> Each DTMF digit is sent using 24.008/Q.931 "Start DTMF" message,
> followed by "Stop DTMF". Start DTMF contains DTMF digit encoded as a
> single IRA character (from the set of 0-9, *, # and A-D). If there is
> pause (like one defined in 02.07), modem just don't send next "Start
> DTMF" for 3 seconds.
>
> AT+VTS tries to hide that, you just give digit and its duration.

Problem is, AT+VTS only handles true DTMF characters according to 27.007.  =
Any =

pauses have to be simulated or sent directly using ATD.  If we are going to =

support such dialstrings, we have to do this in the core daemon, not the =

driver.

> I'd propose that we allow dial strings in phone numbers, like,
>
> "8188080p1234#pp6789#" (Nokia)
> "8188080(a)1234#,,6789#" (V.250)

Yuck.  Lets come up with one format to support, if possible.  How does CDMA =

handle this nonsense?

>
> Ofono should also accept dial strings like
>
> "8188080,1234#,6789#ABCD#"
>
> where the , means that voicecall should start sending DTMF digits 3
> seconds after first RINGING.

A significant number of modems do not return from ATD until the call is =

connected, not just ringing.  So unless we use a different multiplexer chan=
nel =

for DTMF such behavior cannot be guaranteed.  Even with a multiplexer this =

probably won't work with a significant number of modems.

>
> If a string starting with 'p' or '@' is given to SendTones() before
> call is connected, driver waits until call is connected before sending
> it to network. If call is already connected, ',', 'p' or '@' are
> interpreted as pause of 3 seconds.

Yuck.  I suggest we leave SendTones as is.  If we support this behavior it =

should be specified by the dialing number.

The biggest issue is that there is no progress synchronization as you've =

already mentioned.   Most of the modern platforms need to generate audible =

events whenever a DTMF is signaled since this is (potentially) no longer =

handled by the modem.   The current API was actually intended to be used on=
ly =

as a 'slave' by a controlling entity that interacts with UI, audio framewor=
k =

and oFono.

While I'm sure we can accommodate a state machine to handle all of this =

nonsense inside oFono, I'm no longer convinced we should.

First step should be to come up with a nice, clean API for all of this that =

will report DTMF progress, and has a realistic chance of actually being =

implemented across modems and technologies.

Regards,
-Denis

--===============2866366587263806986==--

