Content-Type: multipart/mixed; boundary="===============0172959572196704346=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH qmi lte v3 1/6] qmi: free cb_data on error
Date: Mon, 17 Apr 2017 12:08:08 -0500
Message-ID: <1db7c3ad-0c04-6acc-849e-660b19c2dd37@gmail.com>
In-Reply-To: <20170415153446.31803-3-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0172959572196704346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/15/2017 10:34 AM, Jonas Bonn wrote:
> ...and move allocation of structure up to variable declarations to
> match the pattern used elsewhere in the code.
> ---
>  drivers/qmimodem/gprs-context.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============0172959572196704346==--

