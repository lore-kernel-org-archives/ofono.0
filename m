Content-Type: multipart/mixed; boundary="===============2902298497986696388=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Handle broken AT command process
Date: Mon, 19 Aug 2019 14:55:15 -0500
Message-ID: <9af29e34-290c-7a76-8f1b-82778fc771e9@gmail.com>
In-Reply-To: <9c9e17cf-549d-dfef-21c0-1c6a13913986@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2902298497986696388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 8/19/19 2:29 PM, Martin Hundeb=C3=B8ll wrote:
> Hi,
> =

> Does ofono have a way to handle lacking OK/error messages? I seems like =

> my modem (Quectel M95) is buggy when it comes to unsolicited indications =

> and (as far as I have seen) SIM commands:
> =

>  =C2=A0> AT+CRSM=3D178,28614,3,4,8
>  =C2=A0< +CRSM: 144,0,"FFFFFFFFFFFFFFFF"
>  =C2=A0< OK
>  =C2=A0> AT+CRSM=3D178,28614,4,4,8
>  =C2=A0< Call Ready
>  =C2=A0< +CREG: 5,"0119","04EA"
> =

> The "Call Ready" indication causes a lacking "OK" from the preceding =

> "AT+CRSM" command. This has happened with other CRSM commands, and can =

> also be caused by an unsolicited +CREG indication.

Eww.  Get your vendor on the phone ;)

> =

> I guess one way handle it, is to to glue op the URC listeners to peek =

> into the AT command queue and check if a command is pending for =

> OK/errors, and retry it if so.

Anyway, generally we can't peek ahead.  GAtChat just doesn't work this =

way.  Also, handling unsolicited notifications interleaved with AT =

command responses is why it is a good idea to provide a list of prefixes =

of the expected responses to g_at_chat_send.  That tells GAtChat which =

lines to consume as a 'response' and which to allow through for =

unsolicited notification processing.  If you provide a NULL prefix, then =

everything is consumed as a 'response'.

> =

> But that could cause unexpected side effects depending on the retried =

> command...

I'm not really even sure what to suggest as a workaround to try here... =

If you have multiple TTYs to play with, maybe fork off one dedicated to =

+CRSM and disable all unsolicited notifications on it?

Regards,
-Denis

--===============2902298497986696388==--

