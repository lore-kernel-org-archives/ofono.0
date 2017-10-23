Content-Type: multipart/mixed; boundary="===============0025014399961123841=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] atmodem: Query the list of supported <fac>s from the
 modem
Date: Mon, 23 Oct 2017 17:25:09 -0500
Message-ID: <a7f642c5-4c7c-a66a-ac9f-e26250f1b8c4@gmail.com>
In-Reply-To: <1508791956-25711-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0025014399961123841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 10/23/2017 03:52 PM, Slava Monich wrote:
> Not all modems support all <fac>s (particularly, "PS"), let's be polite
> and not ask them for the ones they don't support.
> ---
>   drivers/atmodem/sim.c | 57 ++++++++++++++++++++++++++++++++++++++++----=
-------
>   1 file changed, 45 insertions(+), 12 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============0025014399961123841==--

