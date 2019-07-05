Content-Type: multipart/mixed; boundary="===============6322970429338475478=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/10] gatresult: include glib header
Date: Fri, 05 Jul 2019 17:18:37 -0500
Message-ID: <0abdb122-22b9-7061-3086-c54ea49bafc0@gmail.com>
In-Reply-To: <20190703180955.18246-2-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6322970429338475478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 07/03/2019 01:09 PM, Martin Hundeb=C3=B8ll wrote:
> The gatresult data types embeds GSList members, and the function
> prototypes uses glib types.
> =

> Add include of glib.h to allow use of gatresult.h without also including
> glib.h
> ---
>   gatchat/gatresult.h | 2 ++
>   1 file changed, 2 insertions(+)
> =


Patch 1-3 applied, thanks.

Regards,
-Denis


--===============6322970429338475478==--

