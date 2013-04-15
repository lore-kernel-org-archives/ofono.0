Content-Type: multipart/mixed; boundary="===============7384062104634744911=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/7] emulator: Change feature check to attend HFP 1.6
Date: Mon, 15 Apr 2013 07:24:35 -0500
Message-ID: <516BF183.2030104@gmail.com>
In-Reply-To: <1365799265-19946-5-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7384062104634744911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 04/12/2013 03:41 PM, Paulo Borges wrote:
> HFP 1.6 adds a new feature called Codec Negotitation. For the HF Role,
> this feature is stored in the eighty bit of the supported features
> bitmap.
>
> This way, we need to change the range of valid HF feature bitmaps to
> 2^8-1.
> ---
>   src/emulator.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

Patch has been applied, but I reworded the commit description slightly.

Regards,
-Denis

--===============7384062104634744911==--

