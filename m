Content-Type: multipart/mixed; boundary="===============9174562099636060154=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: update attached on netreg updates when running LTE
Date: Fri, 11 Oct 2019 12:31:52 -0500
Message-ID: <b74a0596-bfb1-d152-2700-6bc0697158b2@gmail.com>
In-Reply-To: <20191001201051.21376-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9174562099636060154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 10/1/19 3:10 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> There was a race condition where a context might be
> registered before the netreg status updates to LTE.
> =

> The code took for granted the context is activated after
> the technology update. With this change, any order is
> is accepted.
> ---
>   src/gprs.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============9174562099636060154==--

