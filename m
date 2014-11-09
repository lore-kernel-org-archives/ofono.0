Content-Type: multipart/mixed; boundary="===============0997814147495108436=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Problem with hangup of multiple calls
Date: Sun, 09 Nov 2014 15:09:35 +0100
Message-ID: <545F759F.5010407@chini.tk>
In-Reply-To: <53EFBA17.2020705@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0997814147495108436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 16.08.2014 22:07, Georg Chini wrote:
> Hello,
>
> I am using ofono (compiled from git) and bluez 5.21 to access
> my old Nokia 6230i. I have a problem, when I call two parties.
> When one call is ended, I do not receive a dbus signal. As soon
> as I hangup the second call, I get "CallRemoved" messages for
> both calls, so the first signal is delayed until the second call is
> finished.
> Any idea why this happens or how to debug it further?
>

I asked the question above some time ago but never received
any reply. So I am asking again ...

Somewhat more detail: I tried to do some debugging and when
one call is on hold and the active call is hung up, I do not even
receive a CIEV in the HFP driver. So the signal must be dropped
on a lower level. Any ideas?

Regards
               Georg

--===============0997814147495108436==--

