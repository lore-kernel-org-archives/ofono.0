Content-Type: multipart/mixed; boundary="===============6318356230749916783=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 9/9] modem: global data is pre-zeroed
Date: Mon, 29 Oct 2018 14:05:19 -0500
Message-ID: <7584e6b6-b6cf-e822-fb57-29fcaee1a6d0@gmail.com>
In-Reply-To: <20181026101319.27709-10-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6318356230749916783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/26/2018 05:13 AM, Jonas Bonn wrote:
> Module-local and global data are BSS symbols and don't require
> zero-initialization.
> ---
>   src/modem.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

Regards,
-Denis


--===============6318356230749916783==--

