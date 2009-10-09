Content-Type: multipart/mixed; boundary="===============6354692250412635249=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] voicecall: allow P or , within the dial string
Date: Fri, 09 Oct 2009 05:30:26 +0300
Message-ID: <80fd4e750910081930j383c197fxca48c3bbdf7b6b0a@mail.gmail.com>
In-Reply-To: <200910081537.09150.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6354692250412635249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> >> "DTMF control digit separator" is used as pause according to GSM 02.0=
7.
>> >> According to GSM 11.11 it is stored as BCD code 1100 in the SIM card.
>> >> Nokia modems use 'p' to represent pause. AT commands use ',' to
>> >> represent pause.
>> >
>> > Strictly speaking AT modems use 'C' to represent the pause. =C2=A0Can =
you
>> > point me to any spec that actually says ',' and 'p' are used the way y=
ou
>> > describe?
>>
>> C?
>
> Unless I'm missing something, the DTMF 'C' digit refers exactly to what y=
ou're
> trying to achieve with 'p' and ','
>
> Check TS 11.11 Table 12. =C2=A0'C' is mentioned as the DTMF Control digit=
 separator
> from TS 02.07.

You mean binary code 0b1100 aka hex code 0xC? It would be otherwise
known as DTMF digit 'A'. Welcome to wonderful world of phones.

Have a peek in src/smsutil.c to_semi_octet().

> Also, quoting 27.007 for valid input to VTS: =C2=A0"A single ASCII charac=
ter in the
> set 0 9, #,*,A D. This is interpreted as a single ACSII character whose
> duration is set by the +VTD command."

Yep. Those are actual tones sent within media, however. There are 16
different DTMF tones, 0-9, *, # A, B, C and D have each different
tone. If you say at+vts=3D"A" while call is going on, other end hears a
tone. If you say at+vts=3D"C", different tone is heard.

GSM 11.11 cheated and used the DTMF digits from A to D for other
purpose: 'A' (0b1100, 0xC) for the separating dial string from the
phone number, 'B' for FDN wildcard, 'C' for quoting, and 'D' for
padding.

> It sounds like 'p' is entirely an MMI convention, not anything defined by=
 a
> standard...

Exactly.

>> RFC 4967 uses 'X' to wait for call completion, and 'P' for pause.
>
> oFono does not (yet) care about SIP.

But we care about dial strings, right?

>> Nokia modems use 'p' and '?' for that purpose (extended bcd code
>> 0b1100 =3D> 'p', extended bcd code 0b1101 =3D> '?'). =C2=A0I think G1 us=
es ','
>> instead of 'p'. Either one is fine.

> Yes, you're talking about the 'C' (1100) and 'D' (1101') DTMF characters,=
 as
> above. =C2=A0I have no problem handling 'P', 'p', ',' and 'X' or whatever=
 at the D-
> Bus API level.

Cool.

>However, what gets sent down to the modem must be according to
> some standard. =C2=A0Doing otherwise leads to chaos.

There is no standard. We should specify one.

>> An why to include pause in the tones string in the first place? The
>> current API does not provide any feedback of the sent dtmf digits to
>> the application or between ofono driver and core, so the only way to
>> implement pauses between digits is to include them in the dial string
>> and hope the driver can do something about them.
>
> I still wonder about this myself. =C2=A0Strictly speaking all modems shou=
ld support
> the 'C' digit. =C2=A0In the worst case the modem driver can simulate a 3 =
second
> delay itself. =C2=A0Whether this should be encouraged or not is questiona=
ble.

I'm afraid the modem driver has to implement pause either by itself or
with some modem-specific command.

Each DTMF digit is sent using 24.008/Q.931 "Start DTMF" message,
followed by "Stop DTMF". Start DTMF contains DTMF digit encoded as a
single IRA character (from the set of 0-9, *, # and A-D). If there is
pause (like one defined in 02.07), modem just don't send next "Start
DTMF" for 3 seconds.

AT+VTS tries to hide that, you just give digit and its duration.

Any layer above modem driver has no control on duration of dtmf
digits, nor any idea when the pause gets started and when next digit
should be sent.

...
> However, I agree that the current situation is less than ideal. =C2=A0Ide=
as /
> suggestions welcome.

I'd propose that we allow dial strings in phone numbers, like,

"8188080p1234#pp6789#" (Nokia)
"8188080(a)1234#,,6789#" (V.250)

Both strings mean same, after call gets connected, there is 3 second
pause, then digits 1234# are sent, again 6 second pause, and digits
6789# are sent.

Both will be stored on SIM phonebook in same format. When phone number
is read from SIM card, Ofono modem driver should return it in V.250
format.

Ofono should also accept dial strings like

"8188080,1234#,6789#ABCD#"

where the , means that voicecall should start sending DTMF digits 3
seconds after first RINGING.

If a string starting with 'p' or '@' is given to SendTones() before
call is connected, driver waits until call is connected before sending
it to network. If call is already connected, ',', 'p' or '@' are
interpreted as pause of 3 seconds.

-- =

Pekka.Pessi mail at nokia.com

--===============6354692250412635249==--

