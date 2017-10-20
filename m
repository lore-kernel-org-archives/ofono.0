Content-Type: multipart/mixed; boundary="===============4918149443556009330=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simauth: Fixed incorrect AUTS length
Date: Fri, 20 Oct 2017 14:07:03 -0500
Message-ID: <7edc1799-a51e-6b03-d6fa-9ac5d8c72a17@gmail.com>
In-Reply-To: <1508521252-2690-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4918149443556009330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/20/2017 12:40 PM, James Prestwood wrote:
> The initial SimAuth implementation incorrectly parsed
> the AUTS value as 16 bytes, not 14.
> ---
>   src/sim-auth.c | 2 +-
>   src/simutil.c  | 9 +++++----
>   2 files changed, 6 insertions(+), 5 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============4918149443556009330==--

