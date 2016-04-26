Content-Type: multipart/mixed; boundary="===============7870032398956352579=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/2] [RFC] Clean up undefined function pointer casts
Date: Tue, 26 Apr 2016 08:06:08 -0500
Message-ID: <571F67C0.2050400@gmail.com>
In-Reply-To: <1461651574-31530-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7870032398956352579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 04/26/2016 01:19 AM, John Ernberg wrote:
> From: John Ernberg <john.ernberg@actia.se>
>
> v2: Bump glib requirement to version 2.32 to gain access to g_queue_free_=
full,
> this saves using a wrapper function to clean up the queue in the stk.
>
> John Ernberg (2):
>    configure: Bump glib dependecy to 2.32
>    stk: clean up undefined function pointer casts
>
>   configure.ac | 4 ++--
>   src/stk.c    | 6 ++----
>   2 files changed, 4 insertions(+), 6 deletions(-)
>

Both applied, thanks.

Regards,
-Denis

--===============7870032398956352579==--

