Content-Type: multipart/mixed; boundary="===============4077434001711197425=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: voicecall: behavior of ReleaseAndAnswere with held calls?
Date: Tue, 25 Jan 2011 14:37:54 -0600
Message-ID: <4D3F34A2.1070805@gmail.com>
In-Reply-To: <3ED83A9DB3B6D94CA68BF7C03F2981D3531AD94119@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4077434001711197425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tomasz,

> Shouldn=E2=80=99t ReleaseAndAnswere() release the active call and bring b=
ack the
> held one in such situation?
>

You shouldn't be using ReleaseAndAnswer in this case, instead you should
use SwapCalls.  SwapCalls has the added benefit of allowing swapping of
held and active calls even if there is a call waiting (if your modem
hardware supports this.)

> =

> There also could be a little more description of behavior for a case
> when we have held and waiting calls saying that the waiting call will be =
answered and
> that held won=E2=80=99t be released.
> =


The documentation says: "Releases currently active call and answers the
currently waiting call".

Is this not enough? Can you suggest better wording?

Regards,
-Denis

--===============4077434001711197425==--

