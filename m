Content-Type: multipart/mixed; boundary="===============4262580592820064795=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] gprs: Do nothing on detached when attaching.
Date: Tue, 24 Sep 2019 09:55:58 -0500
Message-ID: <b1934c85-3dcc-bcc6-57c8-fb1a67bb3edb@gmail.com>
In-Reply-To: <20190923071546.32592-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4262580592820064795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 9/23/19 2:15 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> Its incorrect to fiddle with the driver attach state when
> attaching. When attaching the state is transitioning,
> and the correct state will now always be assigned in
> the end of the attach process, regardless of result.
> ---
>   src/gprs.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============4262580592820064795==--

