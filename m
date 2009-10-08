Content-Type: multipart/mixed; boundary="===============8722110267045699809=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: allow P or , within the dial string
Date: Thu, 08 Oct 2009 15:37:08 -0500
Message-ID: <200910081537.09150.denkenz@gmail.com>
In-Reply-To: <80fd4e750910081230i4a774e10nfabf3a2b201b3852@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8722110267045699809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> 2009/10/8 Denis Kenzior <denkenz@gmail.com>:
> >> "DTMF control digit separator" is used as pause according to GSM 02.07.
> >> According to GSM 11.11 it is stored as BCD code 1100 in the SIM card.
> >> Nokia modems use 'p' to represent pause. AT commands use ',' to
> >> represent pause.
> >
> > Strictly speaking AT modems use 'C' to represent the pause.  Can you
> > point me to any spec that actually says ',' and 'p' are used the way you
> > describe?
>
> C?

Unless I'm missing something, the DTMF 'C' digit refers exactly to what you=
're =

trying to achieve with 'p' and ','

Check TS 11.11 Table 12.  'C' is mentioned as the DTMF Control digit separa=
tor =

from TS 02.07.

Also, quoting 27.007 for valid input to VTS:  "A single ASCII character in =
the =

set 0 9, #,*,A D. This is interpreted as a single ACSII character whose =

duration is set by the +VTD command."

It sounds like 'p' is entirely an MMI convention, not anything defined by a =

standard...

>
> RFC 4967 uses 'X' to wait for call completion, and 'P' for pause.
>

oFono does not (yet) care about SIP.

> Nokia modems use 'p' to represent DMTF control digit separator. GSM
> 02.07 specifies how the DTMF control digit separator is used when
> making calls. The dtmf digits in the dial string are sent after the
> call gets connected. The extra separator characters represent extra
> delays.

Yes, however 02.07 never mentions 'p' or ','.  Quoting: "The way in which t=
he =

separator is entered and display in the ME, is left to the individual =

manufacturer's MMI."

Since 'C' is defined by the standard, that is what oFono core should use.  =
If =

Nokia modems prefer 'p' over C, simply convert these in the specific driver.

> The dial string stored  in the SIM card along with a phone number
> cannot contain DTMF digits A-D. However, the other dialstrings do not
> share the same limitation and they can can contain full set of DTMF
> digits, 0-9, *, #, A, B, C, and D. The special bcd coded digits (dtmf
> control digit separator and wildcard) from the SIM card must be mapped
> outside this set.

SIM storage is a nightmare.  The problem is that on the SIM the following =

characters are valid: 0-9, 'A', 'B', 'C', 'D'.  'F' is used as an endmark =

(e.g. empty) character.  'E' has been deprecated and not used for anything.=
  =

Much of the confusion stems from the fact that 'A' maps to '*' and 'B' maps=
 to =

'#'.  Whenever you store anything on the SIM, you have to convert '*' and '=
#' =

back to 'A' and 'B'.  oFono does this for you when writing to / from the SI=
M.

The EFadn, EFsdn, etc can definitely contain the full set above for the SSC=
 / =

Dialing Number fields.  However, the 'C' and 'D' characters cannot actually=
 be =

sent to the network.

In fact 'D' is particularly evil since it requires special handling in the =
UI.  =

Hence 'D' should be stripped from the valid DTMF set that oFono supports.

'C' is used as a separator in its first occurrence, but also as a pause =

character for all subsequent occurrences.

>
> Nokia modems use 'p' and '?' for that purpose (extended bcd code
> 0b1100 =3D> 'p', extended bcd code 0b1101 =3D> '?').  I think G1 uses ','
> instead of 'p'. Either one is fine.

Yes, you're talking about the 'C' (1100) and 'D' (1101') DTMF characters, a=
s =

above.  I have no problem handling 'P', 'p', ',' and 'X' or whatever at the=
 D-
Bus API level.  However, what gets sent down to the modem must be according=
 to =

some standard.  Doing otherwise leads to chaos.

> An why to include pause in the tones string in the first place? The
> current API does not provide any feedback of the sent dtmf digits to
> the application or between ofono driver and core, so the only way to
> implement pauses between digits is to include them in the dial string
> and hope the driver can do something about them.

I still wonder about this myself.  Strictly speaking all modems should supp=
ort =

the 'C' digit.  In the worst case the modem driver can simulate a 3 second =

delay itself.  Whether this should be encouraged or not is questionable.

'D' should be never sent to oFono in the first place, it is entirely an MMI =

issue.

However, I agree that the current situation is less than ideal.  Ideas / =

suggestions welcome.

Regards,
-Denis

--===============8722110267045699809==--

