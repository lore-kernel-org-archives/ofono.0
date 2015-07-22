Content-Type: multipart/mixed; boundary="===============2387130601439879273=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [info] modem data disconnection
Date: Wed, 22 Jul 2015 11:23:42 -0500
Message-ID: <55AFC38E.6000909@gmail.com>
In-Reply-To: <55AF3609.9070702@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2387130601439879273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mylene,

 >
> ok thank you for the explanation.
> How atoms force to go back into AT commands mode ? Where is it done in th=
e code ?
>

Each atom behaves differently.  Refer to the atom's remove() function =

for details.  E.g. the 'atmodem' gprs_context atom uses g_at_ppp_unref() =

and g_at_chat_resume() to force the chat out of PPP mode.  This is why =

you see "garbage" on the AT trace.  In reality it is just a final HDLC =

frame.

Regards,
-Denis

--===============2387130601439879273==--

