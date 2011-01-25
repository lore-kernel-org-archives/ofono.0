Content-Type: multipart/mixed; boundary="===============6837424327977458097=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: voicecall: behavior of ReleaseAndAnswere with held calls?
Date: Tue, 25 Jan 2011 16:01:53 -0600
Message-ID: <4D3F4851.8050609@gmail.com>
In-Reply-To: <AANLkTi=9=p6+nxrpJra0R=FMCCXaCdyLt9iaZSLmjAFg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6837424327977458097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tomasz,

On 01/25/2011 03:43 PM, Tomasz Gregorek wrote:
> Hi Denis
> =

> 2011/1/25 Denis Kenzior <denkenz(a)gmail.com <mailto:denkenz@gmail.com>>
> =

>     Hi Tomasz,
> =

>     > Shouldn=E2=80=99t ReleaseAndAnswere() release the active call and b=
ring
>     back the
>     > held one in such situation?
>     >
> =

>     You shouldn't be using ReleaseAndAnswer in this case, instead you sho=
uld
>     use SwapCalls.  SwapCalls has the added benefit of allowing swapping =
of
>     held and active calls even if there is a call waiting (if your modem
>     hardware supports this.)
> =

> =

> SwapCalls wont release active call. This would be a case when we finished
> active call and we want to disconnect and get back to the held one.
> Though this can also be done with Release on active call followed
> by SwapCalls.
> =


Yep, Hangup or HangupMultiparty then SwapCalls.  If you feel that a
single operation to accomplish hangup + swap is required we can
certainly consider it.  For now it didn't pass our API is Minimal +
Complete test.  Perhaps ReleaseAndSwap()...?

>     >
>     > There also could be a little more description of behavior for a case
>     > when we have held and waiting calls saying that the waiting call
>     will be answered and
>     > that held won=E2=80=99t be released.
>     >
> =

>     The documentation says: "Releases currently active call and answers t=
he
>     currently waiting call".
> =

>     Is this not enough? Can you suggest better wording?
> =

> =

> If we are not touching held calls with this function than it is enough.
> I would only add "if any exist" as this function works when there are held
> and waiting calls.
> =

> "Releases currently active call if any exists, and answers the
> currently waiting call."
>  =


Fair enough, fixed with commit b937d99791abc8c33ef968be40f193f3985bca8d.

Regards,
-Denis

--===============6837424327977458097==--

