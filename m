Content-Type: multipart/mixed; boundary="===============8630557305661628467=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: FYI: Emergency calls with MBM modem
Date: Wed, 07 Jul 2010 12:21:46 -0500
Message-ID: <4C34B7AA.3020009@gmail.com>
In-Reply-To: <AANLkTim-EqhbkjoopgLvX2_GhHxq_3j7k6XWOtTuUygG@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8630557305661628467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 07/07/2010 11:40 AM, Pekka Pessi wrote:
> 2010/7/7 Denis Kenzior <denkenz@gmail.com>:
>>> Main results are:
>>> - emergency calls are not possible in offline mode (CFUN=3D4), ATD112;
>>> returns NO DIALTONE
>>
>> That was expected, do we have a solution in mind on how to do emergency
>> dialing in Offline mode?  Is it a UI problem?
> =

> I'd do like we do in the N900 equivivalent of voicecall atom:
> - request online
> - detach packet radio (if applicable)
> - hang up existing calls
> =

> E.g., we would have something like
> ofono_modem_set_emergency_mode(modem, bool) and
> ofono_modem_get_emergency_mode().
> =

> In emergency mode (while emergency call is on-going) modem would:
> - refuse to make other calls
> - refuse to power off device
> =


Fair enough.

>>> - emergency calls can be made without SIM card (but they require AT+CFU=
N=3D1)
>>
>> That was again expected...
>>
>>> - most MBM modem functionality (AT+COPS, AT+CLCC does not work without =
SIM card)
>>
>> The only one that can be triggered without a SIM card is AT+CLCC.
> =

> I mean, like, now atmodem voicecall driver is using +CHLD, but in
> order to handle emergency calls gracefully it must know if the SIM is
> active or not (and change its behavior accordingly.)
> =


The core doesn't use CHLD in a single call situation.  If we hangup all
calls before initiating an emergency call then this shouldn't be an
issue, right?

> The AT+COPS? or AT+CREG? would be useful if you try to make emergency
> call with weak reception.
> =


I think you will find that most modems have a vendor specific
notification for this and don't use COPS or CREG...  About the only
thing that might be useful is the signal strength...

Regards,
-Denis

--===============8630557305661628467==--

