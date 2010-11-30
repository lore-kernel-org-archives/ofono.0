Content-Type: multipart/mixed; boundary="===============5961567644527491895=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH] stk: Add busy error for the display text command
Date: Tue, 30 Nov 2010 11:24:16 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802C402B0@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813547D902@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5961567644527491895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Guillaume,

> > =

> > Denis on IRC also wondered if this response should be =

> allowed when the =

> > message is flagged urgent.
> > =

> =

> According to the spec I think no, this type of response is =

> not allowed when the message is fluffed urgent.
> =


As per the ETSI TS 102 223 V9.0.0 section 6.4.1, "screen is busy"
applies to high priority text as well. If urgent refers to =

higher priority text which is the case, then I think "screen busy" is
possible. Find below the information from specification.

"High priority text shall be displayed on the screen immediately, except
if there is a conflict of priority level of alerting
such as incoming calls or a low battery warning. In that situation, the
resolution is left to the terminal. If the command is
rejected in spite of the high priority, the terminal shall inform the
UICC using TERMINAL RESPONSE (terminal
currently unable to process command - screen is busy)."

Regards,
Jeevaka

--===============5961567644527491895==--

