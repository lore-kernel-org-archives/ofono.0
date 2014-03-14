Content-Type: multipart/mixed; boundary="===============6295804962877178739=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] simutil: Fix EF_PNN access
Date: Fri, 14 Mar 2014 13:30:39 -0500
Message-ID: <53234ACF.80504@gmail.com>
In-Reply-To: <1394814224-30014-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6295804962877178739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 03/14/2014 11:23 AM, Alfonso Sanchez-Beato wrote:
> EF_PNN was not being read properly (see TS 24.008, section 10.5.3.5a,
> for network names format), which affected the displayed PLMN name for
> some MVNOs. Some modems already read the file and return the right
> string: these do not show the problem.
> ---
>   src/simutil.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)

That was indeed a bug, nice catch.

Both patches have been applied, thanks.

Regards,
-Denis


--===============6295804962877178739==--

