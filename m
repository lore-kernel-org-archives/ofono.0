Content-Type: multipart/mixed; boundary="===============2688180184165914742=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Re: Ofono CF states not always correct
Date: Fri, 14 Jan 2011 15:20:17 +0200
Message-ID: <4D304D91.50409@tieto.com>
In-Reply-To: <4D2C7464.4080704@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2688180184165914742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 01/11/2011 05:16 PM, Denis Kenzior wrote:
> Hi Jarko,
>
> So quickly looking at 22.082, for example 1.6.82.2:
>
> "If Call forwarding on mobile subscriber busy is active, activation of
> Call forwarding unconditional will be accepted. Call forwarding on
> mobile subscriber busy will be quiescent during the active period of
> Call forwarding unconditional.  If Call forwarding unconditional is
> subsequently deactivated, Call forwarding on mobile subscriber busy
> becomes operative again (unless the interaction with another
> supplementary service requests that it remains quiescent)."
>
> To me it sounds like oFono is doing exactly the right thing.  Are you
> sure your modem is behaving properly?
>
> Regards,
> -Denis

It seems that I explained this poorly. So modem is behaving as you =

quoted but ofono is not. I can for example get ofono in a state where =

ofono replies that no CF is active even though one of them is.

e.g. when I do following:
./list-modems
./test-ussd '**61*+358401234567*11#'
./list-modems
./test-ussd '**21*+358401234567*11#'
./list-modems
Now ofono claims that both are active
./test-ussd '*#002#'
./list-modems
Now ofono correctly states that only VoiceUnconditional is active
./test-ussd '##21#'
./list-modems
Now ofono claims that no call forwarding is set active when VoiceNoReply =

in fact is.
./test-ussd '*#002#'
./list-modems
Now ofono correctly states that VoiceNoReply is active

Does this make this any clearer?

-Jarko-



--===============2688180184165914742==--

