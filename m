Content-Type: multipart/mixed; boundary="===============0886196171681412922=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/3] sim: validate IMS private identity
Date: Tue, 19 Jan 2021 10:05:39 -0600
Message-ID: <69e6d1d6-69ad-8f27-042a-88bb8e77dc43@gmail.com>
In-Reply-To: <20210116192107.18568-3-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0886196171681412922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 1/16/21 1:21 PM, Sergey Matyukevich wrote:
> Make sure that IMS private identity is a valid UTF8 string before
> setting sim->impi field. Otherwise ofono may crash on dbus assert
> when SIM properties are reported via org.ofono.SimManager interface.
> ---
>   src/sim.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =


Patch  2 and 3 applied, thanks.

Regards,
-Denis

--===============0886196171681412922==--

