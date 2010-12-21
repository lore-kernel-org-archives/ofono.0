Content-Type: multipart/mixed; boundary="===============0010267176306792088=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Set valid number length in empty EFmsisdn records.
Date: Tue, 21 Dec 2010 14:25:59 -0600
Message-ID: <4D110D57.4050704@gmail.com>
In-Reply-To: <1292849553-4823-3-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0010267176306792088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/20/2010 06:52 AM, Andrzej Zaborowski wrote:
> Valid number length range is 1 - 10 bytes, other values, such as 0xff,
> could potentially crash external parsers.
> ---
>  src/sim.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============0010267176306792088==--

