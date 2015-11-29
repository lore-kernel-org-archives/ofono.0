Content-Type: multipart/mixed; boundary="===============5426501405953706818=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: don't dereference a supplied null value
Date: Sun, 29 Nov 2015 16:01:53 -0600
Message-ID: <565B75D1.2030103@gmail.com>
In-Reply-To: <1448008614-26007-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5426501405953706818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 11/20/2015 02:36 AM, Simon Fels wrote:
> When the voicecall atom is unregistered we remove all HFP support as
> well but were supplying a zero as value to the emulator status
> callbacks which caused the process to crash as we were dereferencing
> the supplied value always and not respecting a zero as indicator to
> reset.
> ---
>   src/voicecall.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>

Applied, thanks

Regards,
-Denis


--===============5426501405953706818==--

