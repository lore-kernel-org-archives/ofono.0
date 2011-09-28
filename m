Content-Type: multipart/mixed; boundary="===============0063564303469574946=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH -v4 16/21] sap: retrigger bluetooth GetProperties call
Date: Tue, 27 Sep 2011 23:37:34 -0500
Message-ID: <4E82A48E.2090403@gmail.com>
In-Reply-To: <1317157460-17012-16-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0063564303469574946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 09/27/2011 04:04 PM, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> =

> When plugging a SAP capable modem, GetProperties need to be called again
> to fetch the SAP Server devices from BlueZ.
> ---
>  plugins/bluetooth.c |    6 ++++++
>  plugins/bluetooth.h |    1 +
>  plugins/sap.c       |    2 ++
>  3 files changed, 9 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============0063564303469574946==--

