Content-Type: multipart/mixed; boundary="===============6778247132087453321=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono CF states not always correct
Date: Tue, 11 Jan 2011 09:16:52 -0600
Message-ID: <4D2C7464.4080704@gmail.com>
In-Reply-To: <4D2C2A4A.80604@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6778247132087453321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

On 01/11/2011 04:00 AM, Jarko Poutiainen wrote:
> Hello,
> =

> I have been trying out and going through the code concerning Call
> Forwarding and I found out that if you enable for example CF VoiceBusy
> and then CF VoiceUnconditional, the VoiceBusy is still according to
> ofono enabled. This of course as such isn't so bad but by using
> org.ofono.SupplementaryServices to query the CF states ofono gives
> different response i.e. now only the VoiceUnconditional is enabled and
> then I can disable only the VoiceUnconditional by using the
> org.ofono.SupplementaryServices and when doing so I found out that now
> ofono thinks that no CF is enabled even though VoiceBusy is actually
> active.
>

So quickly looking at 22.082, for example 1.6.82.2:

"If Call forwarding on mobile subscriber busy is active, activation of
Call forwarding unconditional will be accepted. Call forwarding on
mobile subscriber busy will be quiescent during the active period of
Call forwarding unconditional.  If Call forwarding unconditional is
subsequently deactivated, Call forwarding on mobile subscriber busy
becomes operative again (unless the interaction with another
supplementary service requests that it remains quiescent)."

To me it sounds like oFono is doing exactly the right thing.  Are you
sure your modem is behaving properly?

Regards,
-Denis

--===============6778247132087453321==--

