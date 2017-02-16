Content-Type: multipart/mixed; boundary="===============7083481598661433380=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] atmodem: use ATD99 to enter data state when needed
Date: Thu, 16 Feb 2017 11:53:15 -0600
Message-ID: <14f5544b-eae1-8b3d-ac79-1028a831e55b@gmail.com>
In-Reply-To: <20170216084000.2758-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7083481598661433380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 02/16/2017 02:40 AM, Christophe Ronco wrote:
> Some modems do not support AT+CGDATA=3D"PPP",X to enter data state.
> Use AT+CGDATA=3D? to detect these modems and for them use ATD*99***X#
> to enter data state.
> ---
>  drivers/atmodem/gprs-context.c | 50 ++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============7083481598661433380==--

