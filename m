Content-Type: multipart/mixed; boundary="===============4250291936543195253=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Stop imsi/lock query sequence when SIM is removed
Date: Fri, 06 Jan 2017 12:26:48 -0600
Message-ID: <a0a86c75-aeed-a748-439d-ac56b80ca87a@gmail.com>
In-Reply-To: <1483619336-26053-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4250291936543195253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 01/05/2017 06:28 AM, Slava Monich wrote:
> SIM card can be removed while the query is in progress. There's
> still a remote possibility that SIM card is removed and inserted
> back while the query is pending, that would start the second query
> sequence and end up invoking sim_initialize() twice. But at least
> these checks reduce the probability of something like that happening.
> ---
>  src/sim.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============4250291936543195253==--

