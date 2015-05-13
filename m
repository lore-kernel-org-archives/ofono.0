Content-Type: multipart/mixed; boundary="===============4625734586708480810=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] cinterion: Correct use of freed structure
Date: Wed, 13 May 2015 15:58:52 -0500
Message-ID: <5553BB0C.5050203@gmail.com>
In-Reply-To: <1431533327-8844-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4625734586708480810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 05/13/2015 11:08 AM, Alex J Lennon wrote:
> On error struct cb_data *cbd was used after in cinterion_set_online
> after already being freed.
> ---
>   plugins/cinterion.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============4625734586708480810==--

